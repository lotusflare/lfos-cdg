//
//  CoreDataStore.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import Foundation
import CoreData

public enum RepositoryType {
    case sqlite
    case inMemory
}

public enum ModelType {
    case name(String)
    case defaultModel
}

public enum MigrationPolicy {
    case recreateStoreOnHeavyWeightMigration
    case resolveMigrationManually
}

public struct CoreDataConfig {
    public init(repositoryType: RepositoryType, modelType: ModelType, migrationPolicy: MigrationPolicy) {
        self.repositoryType = repositoryType
        self.modelType = modelType
        self.migrationPolicy = migrationPolicy
    }

    let repositoryType: RepositoryType
    let modelType: ModelType
    let migrationPolicy: MigrationPolicy
}

public class CoreDataStore {
    public init(with version: ModelVersion) {
        config = CoreDataConfig(repositoryType: .sqlite, modelType: .defaultModel, migrationPolicy: .recreateStoreOnHeavyWeightMigration)
        self.version = version
    }

    private enum Constants {
        static let currentVersionKey = "currentVersionKeyCDG"
        static let userDefaultsCDGSuitName = "CDGUserDefaults"
    }

    public static var shared: CoreDataStore {
        guard let instance = allStores.sorted(by: { $0.version < $1.version }).last else {
            fatalError("Unable to find version, make sure that the Version is added to DataStoreVersion")
        }
        return instance
    }

    public static var allVersions = [ModelVersion]()
    private static var allStores = [CoreDataStore]()
    private(set) var entityDescriptionMap: [String: NSEntityDescription] = [:]
    var sourceMigrationManagedModel: NSManagedObjectModel?
    public var version: ModelVersion
    var cdgUserDefaults: UserDefaults { UserDefaults(suiteName: Constants.userDefaultsCDGSuitName)! }

    public var mappingModel: ((NSMappingModel) -> Void)?

    var currentVersion: ModelVersion? {
        let modelData = CoreDataStore.shared.cdgUserDefaults.value(forKey: Constants.currentVersionKey) as! Data
        return try? JSONDecoder().decode(ModelVersion.self, from: modelData)
    }

    public func entityDescription(for entityName: String) -> NSEntityDescription {
        if let entityDescription = entityDescriptionMap[entityName] {
            return entityDescription
        }

        let entityDescription = NSEntityDescription()
        entityDescription.name = entityName
        entityDescription.managedObjectClassName = entityName
        entityDescriptionMap[entityName] = entityDescription

        return entityDescription
    }


    private var config: CoreDataConfig
    public func setup(with config: CoreDataConfig) {
        if erasablePersistentContainer == nil {
            let closure = {
                self.config = config
                self.loadStores()
            }

            !Thread.isMainThread ? DispatchQueue.main.sync { closure() } : closure()
        }
    }

    private var erasableManagedModel: NSManagedObjectModel?
    private var erasablePersistentContainer: NSPersistentContainer?

    var managedModel: NSManagedObjectModel {
        if erasableManagedModel == nil {
            loadModel()
        }
        return erasableManagedModel!
    }

    private var persistentContainer: NSPersistentContainer {
        return lock(self) {
            if erasablePersistentContainer == nil {
                loadStores()
            }
            return erasablePersistentContainer!
        }
    }

    private func handleMigration(_ error: Error) {
        switch config.migrationPolicy {
            case .recreateStoreOnHeavyWeightMigration: removeStoreAndRecreate()
            case .resolveMigrationManually:
                guard var currentVersion = self.currentVersion else {
                    assertionFailure("Missing current version. Unable to perfrom migration")
                    return
                }

                let latestVersion = CoreDataStore.shared.version
                // Iterate through all version migrations until the latest version.
                 while currentVersion != latestVersion {
                    guard let source = CoreDataStore.getCoreDataStore(by: currentVersion),
                          let destination = CoreDataStore.getCoreDataStore(by: currentVersion.nextVersion()),
                          let mappingModel = destination.mappingModel else {
                        return
                    }
                do {
                    try performHeavyweightMigration(sourceModel: source.managedModel,
                                                    destinationModel: destination.managedModel, mappingModel)
                } catch {
                    logError(error)
                    assertionFailure("Failed to perform migration from \(source.version.getFormatted()) to \(destination.version.getFormatted())")
                }
                    guard let nextVersion = currentVersion.nextVersion() else { break }
                    currentVersion = nextVersion
                }

                loadPersistentStores()
        }
    }
}

extension CoreDataStore {
    private var modelName: String {
        return {
            switch config.modelType {
            case .defaultModel: return Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? "DefaultCoreDataStackName"
            case .name(let name): return name
            }
        }()
    }
}

extension CoreDataStore {
    /// View context of an injected `NSPersistentContainer`
    public var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    public var newBackgroundContext: NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }

    /// Performs a `closure` on a background queue, creating a background context and passing it in `closure`
    ///
    /// - Parameter closure: Closure which will be executed on background context
    func performBackgroundTask(closure: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask { context in
            context.transactionAuthor = memoryAddress(of: Thread.current)
            closure(context)
        }
    }

    private func loadModel() {
        if
            case let ModelType.name(modelName) = config.modelType,
            let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd"),
            let model = NSManagedObjectModel(contentsOf: modelURL) {

            erasableManagedModel = model
        } else {
            let model = NSManagedObjectModel()
            model.entities = Array(entityDescriptionMap.values)
            model.versionIdentifiers = [version.getFormatted()]
            erasableManagedModel = model
        }
    }

    private func loadStores() {
        erasablePersistentContainer = NSPersistentContainer(name: modelName, managedObjectModel: managedModel)
        loadPersistentStores()
        erasablePersistentContainer?.viewContext.automaticallyMergesChangesFromParent = true
    }

    private func loadPersistentStores()  {
        erasablePersistentContainer?.loadPersistentStores { (description, error) in
            if let error = error {
                self.handleMigration(error)
            } else {
                // Save current version to userDefaults
                do {
                    let data = try JSONEncoder().encode(CoreDataStore.shared.version)
                    self.cdgUserDefaults.setValue(data, forKey: Constants.currentVersionKey)
                } catch {
                    logError(error)
                }
            }
            description.type = self.stringRepositoryType
        }
    }

    private var stringRepositoryType: String {
        switch config.repositoryType {
            case .inMemory: return NSInMemoryStoreType
            case .sqlite: return NSSQLiteStoreType
        }
    }

    private func removeStoreAndRecreate() {
        guard let storeURL = storeURL, FileManager.default.fileExists(atPath: storeURL.path) else {
            assertionFailure("Sqlite file doesn't exist on path, possible first app run")
            return
        }
        do {
            try erasablePersistentContainer?.persistentStoreCoordinator.persistentStores.forEach { (store) in
                try erasablePersistentContainer?.persistentStoreCoordinator.remove(store)
            }
            try FileManager.default.removeItem(at: storeURL)
            loadStores()
            logWarning("STORE RECREATED DUE TO MIGRATION")

        } catch {
            logError(error)
            assertionFailure("File manager failed to remove sql file:\n\(error)")
        }
    }

    enum MigrationError: Error {
        case missingStoreURL
    }

    private func performHeavyweightMigration(sourceModel: NSManagedObjectModel, destinationModel: NSManagedObjectModel, _ mappingClosure: (NSMappingModel) -> Void) throws {
        guard let storeURL = storeURL, FileManager.default.fileExists(atPath: storeURL.path) else {
            throw MigrationError.missingStoreURL
        }

        let mappingModel: NSMappingModel
        mappingModel = try NSMappingModel.inferredMappingModel(forSourceModel: sourceModel,
                                                               destinationModel: destinationModel)

        hydrate(mappingModel: mappingModel)

        // Call mapping closure from CoreDataConfig
        mappingClosure(mappingModel)

        // Create a temporary URL for destination
        let temporaryStoreUrl = storeURL.appendingPathExtension(".migration")

        // Remove tempStore if already created
        removeFileIfExists(at: temporaryStoreUrl)

        let migrationManager = NSMigrationManager(sourceModel: sourceModel,
                                                  destinationModel: destinationModel)
        try migrationManager.migrateStore(from: storeURL,
                                          sourceType: stringRepositoryType,
                                          options: nil,
                                          with: mappingModel,
                                          toDestinationURL: temporaryStoreUrl,
                                          destinationType: stringRepositoryType,
                                          destinationOptions: nil)

        moveFileIfExists(from: temporaryStoreUrl, to: storeURL)
    }

    func hydrate(mappingModel: NSMappingModel) {
        guard let mappings = mappingModel.entityMappings else {
            assertionFailure("Missing entity mappings")
            return
        }

        mappingModel.entityMappings = mappings.map { mapping in
            guard let entityName = mapping.sourceEntityName else { return mapping }

            let newMapping = NSEntityMapping()
            newMapping.mappingType = .customEntityMappingType
            newMapping.name = entityName

            newMapping.sourceEntityName = mapping.sourceEntityName
            newMapping.sourceEntityVersionHash = mapping.sourceEntityVersionHash
            newMapping.destinationEntityName = mapping.destinationEntityName
            newMapping.destinationEntityVersionHash = mapping.destinationEntityVersionHash
            newMapping.sourceExpression = mapping.sourceExpression
            newMapping.attributeMappings = mapping.attributeMappings
            newMapping.relationshipMappings = mapping.relationshipMappings

            return newMapping
        }
    }
}

// MARK: - FileManager helpers
extension CoreDataStore {
    private var documentsDirectory: URL? {
        FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last
    }

    private var storeURL: URL? {
        guard let documentsDirectory = self.documentsDirectory else {
            assertionFailure("Failed to get documents directories")
            return nil
        }
        return documentsDirectory.appendingPathComponent(modelName + ".sqlite")
    }

    private func moveFileIfExists(from: URL, to: URL) {
        removeFileIfExists(at: to)

        let fileManager = FileManager.default
        guard fileManager.fileExists(atPath: from.path) else { return }

        do {
            try fileManager.moveItem(at: from, to: to)
        } catch let error {
            logWarning("Couldn't move store from \(from.path) to \(to.path): \(error)")
        }
    }

    /// Removes a file for specified URL
    /// - Parameter at: URL of the file
    private func removeFileIfExists(at: URL) {
        let fileManager = FileManager.default
        guard fileManager.fileExists(atPath: at.path) else {
            return
        }
        do {
            try fileManager.removeItem(at: at)
        } catch let error {
            logWarning("Couldn't remove file at \(at.path): \(error)")
        }
    }
}

extension CoreDataStore {
    public static func saveVersions(_ versions: [ModelVersion]) {
        self.allVersions = versions
    }

    public static func saveDataStoreVersions(_ dataStores: [CoreDataStore]) {
        self.allStores = dataStores
    }

    static func getCoreDataStore(by: ModelVersion?) -> CoreDataStore? {
        guard let version = by else { return nil }
        return allStores.first(where: { $0.version == version })
    }
}

