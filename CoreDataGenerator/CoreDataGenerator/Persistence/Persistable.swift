//
//  Persistable.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import Foundation
import CoreData

public typealias JSONObject = [String: Any]

public typealias PersistableManagedObject = NSManagedObject & UniqueIDConstraintKeyPath & GroupIDKeyPath & Persistable

public protocol UniqueIDConstraintKeyPath {
    associatedtype EntityID: Equatable & Hashable

    static var idKeyPath: WritableKeyPath<Self, EntityID> { get }
}

public protocol GroupIDKeyPath {
    static var groupIDKeyPath: WritableKeyPath<Self, String?> { get }
}

public enum BatchInsertionPolicy {
    case deleteAllPreviousEntries
    case deleteNonExistingAndInsertOrUpdate
    case insertOrUpdate
}

public struct DeleteOptions {
    var sourceContext: NSManagedObjectContext
    var offset: Int?
    var predicate: NSPredicate
    var groupID: String?
    var comparisonClauses: [ComparisonClause]

    public init(sourceContext: NSManagedObjectContext = CoreDataStore.shared.newBackgroundContext,
                predicate: NSPredicate = .true,
                groupID: String? = nil,
                comparisonClauses: [ComparisonClause] = [],
                offset: Int? = nil) {
        self.sourceContext = sourceContext
        self.predicate = predicate
        self.groupID = groupID
        self.comparisonClauses = comparisonClauses
        self.offset = offset
    }
}

public enum PersistableError: Error {
    case failedToSaveEntityToStore
    case modelMismatch
}

/// Any object that needs to get through the `Persistence` CoreData stack needs to conform to `Persistable` protocol
/// It takes care of basic CRUD operations, where all reads are done defaultly on the main context, if none other
/// is specified.
///
/// Each method is using the default `StoreManager` which contains `NSPersistentContainer`, but if a new one
/// is needed, it can be passed to any of the methods.
public protocol Persistable {
    /// Unique ID type which must conform
    associatedtype EntityID: Equatable

    /// Retrieves a number of objects which can be fetched using predicate from context
    /// - Parameters:
    ///   - groupID: Optional identifier of the group of entities
    ///   - predicate: Count condition
    ///   - sourceContext: Instance of `NSManagedObjectContext` in which the method will look for the `entityID`. Default is `mainContext`.
    static func count(groupID: String?,
                      using predicate: NSPredicate,
                      sourceContext: NSManagedObjectContext) -> Int

    /// Retrieves a single entity from a `StoreManager` instance defined with `store` parameter, defaultly from a
    /// main context from `store`, but a different one can be passed with `sourceContext` parameter.
    ///
    /// - Parameters:
    ///   - entityID: Unique ID which every entity must have, and only one entity must have this particular one
    ///   - sourceContext: Instance of `NSManagedObjectContext` in which the method will look for the `entityID`. Default is `mainContext`.
    /// - Returns: Existing object with `entityID`, or nil if one could not be found
    static func get(entityID: EntityID,
                    sourceContext: NSManagedObjectContext) -> Self?

    /// Retrives multiple entities from a `StoreManager` instance defined with `store` parameter, defaultly from a
    /// main context on the `store`, but different one can be passed with `sourceContext` parameter.
    ///
    /// - Parameters:
    ///   - groupID: Optional identifier of the group of entities
    ///   - predicate: Query predicate used to fetch the entities.
    ///   - comparisonClauses: Array of `ComparisonClause` instances.
    ///   - sourceContext: Instance of `NSManagedObjectContext` in which the method will look for the `entityID`. Default is `mainContext`.
    /// - Returns: Objects from `sourceContext` which conform to `predicate` and sorted in regards to `comparisonClauses`
    static func get(groupID: String?,
                    using predicate: NSPredicate,
                    comparisonClauses: [ComparisonClause],
                    sourceContext: NSManagedObjectContext) -> [Self]

    /// Retrieves all entities from a `StoreManager` instance defined with `store` parameter, defaultly from a
    /// main context on the `store`, but a different one can be passed with `sourceContext` parameter.
    /// - Parameters:
    ///   - groupID: Optional identifier of the group of entities
    ///   - comparisonClauses: Array of `ComparisonClause` instances.
    ///   - sourceContext: Instance of `NSManagedObjectContext` in which the method will look for the `entityID`. Default is `mainContext`.
    /// - Returns: All existing objects
    static func getAll(groupID: String?,
                       comparisonClauses: [ComparisonClause],
                       sourceContext: NSManagedObjectContext) -> [Self]

    /// Creates a `Persistable` entity on a background context on a `NSPersistentStore` defined with `store` parameter
    /// `updateClosure` is triggered on a background thread, passing a newly created object, or if it already exists, object to be updated.
    /// - Parameters:
    ///   - groupID: Optional identifier of the group of entities
    ///   - updateIfEntityExists: Flag which defines what the method will do when it finds a duplicate in the database. If set to `true`,
    ///                           it will fetch the existing one and call `updateClosure` one more time to update the existing entity, if set to `false`, update will be omitted.
    ///   - updateClosure: Triggered when a new entity is created or, existing entity fetched.
    ///   - entity: Newly created entity to be updated
    ///   - context: Context on which the creation is executed on. Can be used to create relationship entities
    ///   - completeClosure: After saving backgrond context, the complete block is dispatched asynchronously on the
    ///                      main thread, with a fresh object refetched from main context.
    static func create(groupID: String?,
                       updateIfEntityExists: Bool,
                       updateClosure: @escaping (_ entity: inout Self, _ context: NSManagedObjectContext) -> Void,
                       completeClosure: ((Result<Self, PersistableError>) -> Void)?)


    /// Create and populate entity on a background context.
    /// - Parameters:
    ///   - groupID: Optional identifier of the group of entities
    ///   - updateIfEntityExists: Flag which defines what the method will do when it finds a duplicate in the database. If set to `true`,
    ///                           it will fetch the existing one and call `updateClosure` one more time to update the existing entity, if set to `false`, update will be omitted.
    ///   - insertionPolicy: BatchInsertionPolicy defines how data will be stored.
    ///   - completeClosure: After saving backgrond context, the complete block is dispatched asynchronously on the
    ///                      main thread, with a fresh object refetched from main context.
    func createAndPopulate(groupID: String?, updateIfEntityExists: Bool, insertionPolicy: BatchInsertionPolicy, completeClosure: ((Result<Self, PersistableError>) -> Void)?)

    static func createBatchAndPopulate<PersistableType: Persistable & UniqueIDConstraintKeyPath>(
        groupID: String?, from plainModels: [PersistableType], insertionPolicy: BatchInsertionPolicy, completeClosure: ((Result<[PersistableType], PersistableError>) -> Void)?)

    /// Init exclusively used to initialize relationship entities. Should be used when `create` or `update` is called, and context is available.
    /// - Parameters:
    ///   - groupID: Optional identifier of the group of entities
    ///   - entityID: Unique ID which every entity must have, and only one entity must have this particular one
    ///   - context: Context on which the creation is executed on.
    static func createEntity(groupID: String?, entityID: EntityID, context: NSManagedObjectContext) -> Self?

    /// Create a temporary object which will be destroyed after the exection
    /// of `updateClosure`
    ///
    /// - Parameters:
    ///     - groupID: Optional identifier of the group of entities
    ///     - updateClosure: Closure with new temporary object for editing
    ///     - entity: Newly created entity to be updated
    ///     - context: Context on which the creation is executed on. Can be used to create relationship entities
    static func createTemporary(groupID: String?, updateClosure: @escaping (_ entity: inout Self, _ context: NSManagedObjectContext) -> Void)

    /// Update an object in an update closure
    ///
    /// - Parameters:
    ///   - updateClosure: Closure with object for editing
    ///   - entity: Newly created entity to be updated
    ///   - context: Context on which the creation is executed on. Can be used to create relationship entities.
    ///   - completeClosure: Closure with saved object on main thread
    func update(updateClosure: @escaping (_ entity: inout Self, _ context: NSManagedObjectContext) -> Void,
                completeClosure: ((Self) -> Void)?)

    /// Deletes an entity from a NSManagedObjectContext specified by `context` parameter
    ///
    /// - Parameters:
    ///     - sourceContext: Source `NSManagedObjectContext`. Default is StoreManager's `newBackgroundContext`
    ///     - completeClosure: Closure which is triggered after context save
    func delete(sourceContext: NSManagedObjectContext, completeClosure: (() -> Void)?)

    /// Deletes a collection of entity results fetched by `predicate` condition defined in `DeleteOptions`.
    /// - Parameters:
    ///   - options: An instance of `DeleteOptions`, which can contain group identifier, `NSPredicate`,  `ComparisonClause` instances, `offset`, and execution context.
    ///   - completeClosure: Closure which is triggered after context save
    static func delete(with options: DeleteOptions,
                       completeClosure: (() -> Void)?)

    /// Gets all groups associated with this entity that exist in the database
    /// - Parameters:
    ///    - sourceContext: Source `NSManagedObjectContext`. Default is StoreManager's `newBackgroundContext
    static func getAllGroups(sourceContext: NSManagedObjectContext) -> [String]?

    @discardableResult
    func populate<T: Persistable>(groupID: String?, with plainModel: T, context: NSManagedObjectContext) -> Self
}

public extension Persistable where Self: UniqueIDConstraintKeyPath {
    var uniqueIdValue: EntityID {
        return self[keyPath: Self.idKeyPath]
    }

    @discardableResult
    func populate<T: Persistable>(groupID: String?, with plainModel: T, context: NSManagedObjectContext) -> Self {
        return self
    }
}

public extension Persistable where Self: NSManagedObject & UniqueIDConstraintKeyPath & GroupIDKeyPath {
    var groupId: String? {
        return self[keyPath: Self.groupIDKeyPath]
    }

    static func count(groupID: String? = nil,
                      using predicate: NSPredicate,
                      sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Int {
        let fetchRequest = NSFetchRequest<Self>(entityName: "\(Self.self)")
        fetchRequest.predicate = groupIDPredicate(groupID: groupID, combinedWith: predicate)

        var count: Int = 0
        sourceContext.performAndWait {
            do {
                count = try sourceContext.count(for: fetchRequest)
            } catch {
                logError("Failed fetching entity of type: \(Self.self)")
            }
        }

        return count
    }

    static func get(entityID: EntityID,
                    sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Self? {
        var result: Self?

        sourceContext.performAndWait {
            let fetchRequest = NSFetchRequest<Self>(entityName: "\(Self.self)")
            fetchRequest.predicate = idKeyPath == entityID

            do {
                result = try sourceContext.fetch(fetchRequest).first
            } catch {
                logError("Failed fetching entity of type: \(Self.self)")
            }
        }

        return result
    }

    static func get(groupID: String? = nil,
                    using predicate: NSPredicate,
                    comparisonClauses: [ComparisonClause] = [],
                    sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [Self] {

        var results: [Self] = []
        sourceContext.performAndWait {
            let fetchRequest = NSFetchRequest<Self>(entityName: "\(Self.self)")
            fetchRequest.predicate = groupIDPredicate(groupID: groupID, combinedWith: predicate)
            fetchRequest.sortDescriptors = comparisonClauses.map { $0.sortDescriptor }

            do {
                results = try sourceContext.fetch(fetchRequest)
            } catch {
                logError("Failed fetching entity of type: \(Self.self)")
            }
        }
        return results
    }

    static func getAll(groupID: String? = nil,
                       comparisonClauses: [ComparisonClause] = [],
                       sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [Self] {
        return get(groupID: groupID,
                   using: .true,
                   comparisonClauses: comparisonClauses,
                   sourceContext: sourceContext)
    }

    func createAndPopulate(groupID: String?, updateIfEntityExists: Bool, insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<Self, PersistableError>) -> Void)?) {
        Self.createBatchAndPopulate(groupID: groupID, from: [self], insertionPolicy: insertionPolicy) { result in
            switch result {
            case .success(let response):
                guard let savedEntity = response.first else { completeClosure?(.failure(.failedToSaveEntityToStore)); return }
                completeClosure?(.success(savedEntity))
            case .failure(let error):
                completeClosure?(.failure(error))
            }
        }
    }

    static func create(groupID: String? = nil,
                       updateIfEntityExists: Bool = true,
                       updateClosure: @escaping (inout Self, NSManagedObjectContext) -> Void,
                       completeClosure: ((Result<Self, PersistableError>) -> Void)?) {
        CoreDataStore.shared.performBackgroundTask { (context) in
            var entityID: Self.EntityID?

            context.performAndWait {
                var temporaryEntity = Self(context: context)
                updateClosure(&temporaryEntity, context)

                entityID = temporaryEntity[keyPath: idKeyPath]
                guard let entityID = entityID else { return }

                let duplicateEntities = get(using: idKeyPath == entityID,
                                            sourceContext: context)
                    .filter { $0.objectID != temporaryEntity.objectID }

                if !duplicateEntities.isEmpty {
                    if updateIfEntityExists {
                        context.delete(temporaryEntity)
                        logVerbose("There is already an entity of type \(Self.self) with id: \(entityID), in database, will trigger `updateClosure` again to populate existing entity.")
                        duplicateEntities.forEach { var duplicate = $0; updateClosure(&duplicate, context) }
                    } else {
                        logError("Trying to create an entity of type: \(Self.self) with unique id: \(entityID), which already exists in database. If it's meant to be updated set `updateIfEntityExists` flag to `true`. Aborting.")
                        context.reset()
                    }
                }

                do {
                    if context.hasChanges {
                        try context.save()
                    }
                } catch {
                    logError(error)
                }
            }

            DispatchQueue.main.async {
                guard let entityID = entityID, let savedObject = Self.get(entityID: entityID) else {
                    completeClosure?(.failure(.failedToSaveEntityToStore))
                    logError("Entity of type \(Self.self) failed to save in persistent store.")
                    return
                }
                completeClosure?(.success(savedObject))
            }
        }
    }

    static func createBatchAndPopulate<PersistableType: Persistable & UniqueIDConstraintKeyPath>(
        groupID: String? = nil, from plainModels: [PersistableType], insertionPolicy: BatchInsertionPolicy, completeClosure: ((Result<[PersistableType], PersistableError>) -> Void)?) {

        CoreDataStore.shared.performBackgroundTask { (context) in
            let entityToStoreIDs: [EntityID] = plainModels.compactMap { model in
                guard let id = model.uniqueIdValue as? EntityID, "\(id)" != "nil" else { return nil }
                return id
            }

            let insertionClosure = {
                context.perform {
                    var savedEntityIds = [EntityID]()

                    // Insertion/updating
                    switch insertionPolicy {
                    case .deleteNonExistingAndInsertOrUpdate, .insertOrUpdate:
                        // Update already existing entities or insert new
                        let alreadyExistingEntites = get(groupID: groupID,
                                                         using: idKeyPath === entityToStoreIDs,
                                                         comparisonClauses: [],
                                                         sourceContext: context)
                        var managedEntityIDMap: [EntityID: Self] = [:]

                        alreadyExistingEntites.forEach {
                            managedEntityIDMap[$0[keyPath: type(of: $0).idKeyPath]] = $0
                        }

                        plainModels.forEach { (modelToStore) in
                            // Get or create entity to update
                            if let uniqueId = modelToStore.uniqueIdValue as? EntityID,
                               let entity = managedEntityIDMap[uniqueId] ?? createEntity(entityID: uniqueId, context: context) {

                                savedEntityIds.append(self.getEntityIdAndPopulate(entity: entity,
                                                                                  with: groupID,
                                                                                  from: modelToStore,
                                                                                  in: context))
                            }
                        }
                    case .deleteAllPreviousEntries:
                        // All previous entries were deleted, so just insert new ones
                        plainModels.forEach { (modelToStore) in
                            if let uniqueId = modelToStore.uniqueIdValue as? EntityID,
                               let entity = createEntity(entityID: uniqueId, context: context) {

                                savedEntityIds.append(self.getEntityIdAndPopulate(entity: entity,
                                                                                  with: groupID,
                                                                                  from: modelToStore,
                                                                                  in: context))
                            }
                        }
                    }

                    do {
                        if context.hasChanges {
                            try context.save()
                        }
                    } catch {
                        logError(error)
                    }

                    // Check if all objects are saved
                    DispatchQueue.main.async {
                        let savedObjects = PersistableType.get(groupID: groupID,
                                                               using: PersistableType.idKeyPath === savedEntityIds.compactMap { $0 as? PersistableType.EntityID },
                                                               comparisonClauses: [],
                                                               sourceContext: CoreDataStore.shared.mainContext)



                        guard savedObjects.count == plainModels.count else {
                            completeClosure?(.failure(.failedToSaveEntityToStore))

                            logError("Entity of type \(Self.self) failed to save in persistent store.")
                            return
                        }
                        completeClosure?(.success(savedObjects))
                    }
                }
            }

            // Deletion
            switch insertionPolicy {
            case .deleteAllPreviousEntries:
                // Delete all previous entries from cache
                delete(with: DeleteOptions(sourceContext: context, groupID: groupID), completeClosure: insertionClosure)
            case .deleteNonExistingAndInsertOrUpdate:
                // Delete non existing objects from cache
                delete(with:
                        DeleteOptions(sourceContext: context, predicate: !(idKeyPath === entityToStoreIDs), groupID: groupID), completeClosure: insertionClosure)
            default:
                insertionClosure()
            }
        }
    }

    static func createEntity(groupID: String? = nil,
                             entityID: EntityID,
                             context: NSManagedObjectContext) -> Self? {
        guard context != CoreDataStore.shared.mainContext else {
            logError("Trying to create an entity on main context! This init method is only meant to be used when creating relationships. Aborting.")
            assertionFailure("Trying to create an entity on main context! This init method is only meant to be used when creating relationships. Aborting.")
            return nil
        }

        var resultEntity: Self?
        if let existingEntity = get(entityID: entityID, sourceContext: context) {
            logVerbose("Trying to create relationship of type \(Self.self) with id: \(entityID) which already exists. Using persisted one")
            resultEntity = existingEntity
        } else {
            context.performAndWait {
                var entity = Self(entity: Self.entity(), insertInto: context)
                entity[keyPath: idKeyPath] = entityID
                resultEntity = entity
            }
        }

        return resultEntity
    }

    static func createTemporary(groupID: String? = nil, updateClosure: @escaping (_ entity: inout Self, _ context: NSManagedObjectContext) -> Void) {
        CoreDataStore.shared.performBackgroundTask { (context) in
            context.perform {
                var temporaryEntity = Self(entity: entity(), insertInto: context)
                updateClosure(&temporaryEntity, context)
                context.reset()
            }
        }
    }

    func update(updateClosure: @escaping (_ entity: inout Self, _ context: NSManagedObjectContext) -> Void,
                completeClosure: ((Self) -> Void)? = nil) {

        // Intentionally capturing self so it would survive scope in operation queue
        CoreDataStore.shared.performBackgroundTask { (context) in
            context.performAndWait {
                let uniqueID = self[keyPath: Self.idKeyPath]
                guard var refetchedEntity = Self.get(entityID: uniqueID,
                                                     sourceContext: context) else {
                    logError("Failed to fetch entity of type \(Self.self) with id: \(uniqueID)")
                    return
                }

                updateClosure(&refetchedEntity, context)

                do {
                    if context.hasChanges {
                        try context.save()
                    }
                } catch {
                    logError(error)
                }
            }

            DispatchQueue.main.async {
                let uniqueID = self[keyPath: Self.idKeyPath]
                guard let refetchedEntity = Self.get(entityID: uniqueID) else {
                    logError("Entity of type \(Self.self) failed to save in persistent store.")
                    return
                }
                completeClosure?(refetchedEntity)
            }
        }
    }

    func delete(sourceContext: NSManagedObjectContext = CoreDataStore.shared.newBackgroundContext,
                completeClosure: (() -> Void)? = nil) {
        let uniqueID = self[keyPath: Self.idKeyPath]
        let deleteOptions = DeleteOptions(sourceContext: sourceContext,
                                          predicate: Self.idKeyPath == uniqueID)
        Self.delete(with: deleteOptions,
                    completeClosure: completeClosure)
    }

    static func delete(with options: DeleteOptions = DeleteOptions(),
                       completeClosure: (() -> Void)? = nil) {

        guard options.sourceContext != CoreDataStore.shared.mainContext else {
            logError("Trying to perform delete operations on main context. Aborting.")
            return
        }
        let context = options.sourceContext

        context.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "\(Self.self)")
            fetchRequest.predicate = groupIDPredicate(groupID: options.groupID, combinedWith: options.predicate)
            fetchRequest.sortDescriptors = options.comparisonClauses.map { $0.sortDescriptor }

            if let offset = options.offset {
                fetchRequest.fetchOffset = offset
            }

            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeObjectIDs

            do {
                guard
                    let result = try context.execute(batchDeleteRequest) as? NSBatchDeleteResult,
                    let entityIDs = result.result as? [NSManagedObjectID] else {
                    logError("Batch delete \(Self.self) is not of type `NSBatchDeleteResult`. Aborting.")

                    context.reset()
                    return
                }

                let changes = [NSDeletedObjectsKey: entityIDs]
                NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [CoreDataStore.shared.mainContext])

            } catch {
                logError("Delete operation of entity of type: \(Self.self) failed with error:\n\(error)\nAborting.")
                context.reset()
            }

            do {
                if context.hasChanges {
                    try context.save()
                }
            } catch {
                logError(error)
            }

            DispatchQueue.main.async {
                completeClosure?()
            }
        }
    }

    func deleteWithoutCommiting(context: NSManagedObjectContext) {
        context.perform {
            context.delete(self)
        }
    }

    // MARK: - Helpers
    static private func getEntityIdAndPopulate<PersistableType: Persistable & UniqueIDConstraintKeyPath>(entity: Self,
                                                                                                         with groupID: String?,
                                                                                                         from model: PersistableType,
                                                                                                         in context: NSManagedObjectContext) -> Self.EntityID {
        var entityID: Self.EntityID!
        context.performAndWait {
            entityID = entity.populate(groupID: groupID, with: model, context: context).uniqueIdValue
        }

        return entityID
    }
}

public extension Collection where Element: PersistableManagedObject {
    func delete(context: NSManagedObjectContext = CoreDataStore.shared.newBackgroundContext,
                complete: @escaping () -> Void) {
        let ids = map { $0[keyPath: Element.idKeyPath] }

        let deleteOptions = DeleteOptions(sourceContext: context, predicate: Element.idKeyPath === ids)
        Element.delete(with: deleteOptions,
                       completeClosure: complete)
    }
}

private extension Persistable where Self: GroupIDKeyPath {
    static func groupIDPredicate(groupID: String?, combinedWith predicate: NSPredicate) -> NSPredicate {
        // If we return just the predicate the app will crash, but if create a new predicate with the same predicate format, then everything works 🤯
        guard let groupID = groupID, !groupID.isEmpty else { return NSPredicate(format: predicate.predicateFormat) }
        let groupIDPredicate = groupIDKeyPath == groupID
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate, groupIDPredicate])
        return compoundPredicate
    }
}
