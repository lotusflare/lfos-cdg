// Generated using Sourcery 1.4.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Foundation
import CoreData
import CoreDataGenerator


extension Airplane { static var managedModelName = "ManagedAirplane" }

@objc(ManagedAirplane)
final public class ManagedAirplane: PersistableManagedObject, KeyPathable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedAirplane> {
        return NSFetchRequest<ManagedAirplane>(entityName: "ManagedAirplane")
    }

    public static var idKeyPath: WritableKeyPath<ManagedAirplane, String?> {
        return \ManagedAirplane.id
    }

    public static var groupIDKeyPath: WritableKeyPath<ManagedAirplane, String?> {
        return \ManagedAirplane.lfCoreDataEntityGroupIdentifier
    }

    @NSManaged @objc(lfCoreDataEntityIsPopulated) public var lfCoreDataEntityIsPopulated: NSNumber

    public var isPopulated: Bool {
        return lfCoreDataEntityIsPopulated as! Bool
    }

    @NSManaged @objc(lfCoreDataEntityGroupIdentifier) public var lfCoreDataEntityGroupIdentifier: String?

    @NSManaged public var id: String?
    @NSManaged public var name: String

    var plainModel: Airplane?
    var plainCounter = 0
    public var isModelRecursive: Bool { return plainCounter > 5 }

    func toPlainModel(isRecursive: Bool = false) -> Airplane {
        plainCounter.increment(); defer { plainCounter.decrement() }
        if var model = self.plainModel {
            model.id = self.id
        } else {
            let airplane = Airplane(
            id: self.id,
            name: self.name
        )
        self.plainModel = airplane
      }
        return plainModel!
    }

    override public func awakeFromInsert() {
      super.awakeFromInsert()
      self.name = .empty
    }


    @discardableResult
    public func populate<T : Persistable>(groupID: String?, with plainModel: T, context: NSManagedObjectContext) -> Self {
        guard let plainModel = plainModel as? Airplane else { return self }
        lfCoreDataEntityIsPopulated = NSNumber(booleanLiteral: true)
        lfCoreDataEntityGroupIdentifier = groupID
        // Set autoID
        id = UUID().uuidString
        name = plainModel.name 
        return self
    }

    public static func managedKeyPathFrom<EntityType, VariableType>(_ plainKeyPath: KeyPath<EntityType, VariableType>) -> String {
        switch plainKeyPath {
            case \Airplane.id: return "id"
            case \Airplane.name: return "name"
            default: return ""
        }
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        do {
            let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "ManagedAirplane")
            fetchRequest.returnsDistinctResults = true
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.propertiesToFetch = ["lfCoreDataEntityGroupIdentifier"]
            let result = try sourceContext.fetch(fetchRequest).flatMap { $0.allValues }.compactMap { $0 as? String }
            return result
        } catch {
            logError(error)
            return nil
        }
    }
}

extension Airplane: Persistable, UniqueIDConstraintKeyPath {
    public static var idKeyPath: WritableKeyPath<Airplane, ManagedAirplane.EntityID> {
        return \Airplane.id
    }

    public static func count(groupID: String? = nil, using predicate: NSPredicate = .true, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Int {
        return ManagedAirplane.count(groupID: groupID, using: predicate, sourceContext: sourceContext)
    }

    public static func get(entityID: ManagedAirplane.EntityID, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Airplane? {
        ManagedAirplane.get(entityID: entityID, sourceContext: sourceContext)?.toPlainModel()
    }

    public static func get(groupID: String? = nil, using predicate: NSPredicate, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [Airplane] {
        ManagedAirplane.get(groupID: groupID, using: predicate, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func getAll(groupID: String? = nil, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [Airplane] {
        ManagedAirplane.getAll(groupID: groupID, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func create(groupID: String? = nil,
                              updateIfEntityExists: Bool,
                              updateClosure: @escaping (_ entity: inout Airplane, _ context: NSManagedObjectContext) -> Void,
                              completeClosure: ((Result<Airplane, PersistableError>) -> Void)?) {
                               ManagedAirplane.create(groupID: groupID,
            updateIfEntityExists: updateIfEntityExists,
            updateClosure: { (entity, context) in
                var plainEntity: Airplane = entity.toPlainModel()
                updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }, completeClosure: { result in
            switch result {
                case .success(let entity):
                    completeClosure?(.success(entity.toPlainModel()))

                case .failure(let error):
                    completeClosure?(.failure(error))
            }
        })
    }

    public static func createEntity(groupID: String? = nil, entityID: ManagedAirplane.EntityID, context: NSManagedObjectContext) -> Airplane? {
        ManagedAirplane.createEntity(groupID: groupID, entityID: entityID, context: context)?.toPlainModel()
    }

    public static func createTemporary(groupID: String? = nil, updateClosure: @escaping (inout Airplane, NSManagedObjectContext) -> Void) {
        ManagedAirplane.createTemporary { (entity, context) in
            var plainEntity = entity.toPlainModel()
            updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }
    }

    public func createAndPopulate(groupID: String? = nil, updateIfEntityExists: Bool = true, insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<Airplane, PersistableError>) -> Void)?) {
        ManagedAirplane.createBatchAndPopulate(groupID: groupID, from: [self], insertionPolicy: insertionPolicy) { result in
            switch result {
            case .success(let response):
                guard let savedEntity = response.first else { completeClosure?(.failure(.failedToSaveEntityToStore)); return }
                completeClosure?(.success(savedEntity))
            case .failure(let error):
                completeClosure?(.failure(error))
            }
        }
    }

    public func update(updateClosure: @escaping (inout Airplane, NSManagedObjectContext) -> Void, completeClosure: ((Airplane) -> Void)?) {
        let managedEntity = ManagedAirplane.get(entityID: self[keyPath: Self.idKeyPath])

        managedEntity?.update(updateClosure: { (entity, context) in
            var mutableSelf = self
            updateClosure(&mutableSelf, context)
            entity.populate(groupID: managedEntity?.lfCoreDataEntityGroupIdentifier, with: mutableSelf, context: context)

        }, completeClosure: { updatedEntity in
            completeClosure?(updatedEntity.toPlainModel())
        })
    }

    public func delete(sourceContext: NSManagedObjectContext = CoreDataStore.shared.newBackgroundContext, completeClosure: (() -> Void)?) {
        let managedEntity = ManagedAirplane.get(entityID: self[keyPath: Self.idKeyPath], sourceContext: sourceContext)
        managedEntity?.delete(sourceContext: sourceContext, completeClosure: completeClosure)
    }

    public static func delete(with options: DeleteOptions = DeleteOptions(), completeClosure: (() -> Void)?) {
        ManagedAirplane.delete(with: options, completeClosure: completeClosure)
    }

    public static func createBatchAndPopulate<PersistableType: Persistable & UniqueIDConstraintKeyPath>(groupID: String? = nil, from plainModels: [PersistableType], insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<[PersistableType], PersistableError>) -> Void)?) {
      ManagedAirplane.createBatchAndPopulate(groupID: groupID, from: plainModels, insertionPolicy: insertionPolicy, completeClosure: completeClosure)
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        return ManagedAirplane.getAllGroups(sourceContext: sourceContext)
    }
}

extension BasicStruct { static var managedModelName = "ManagedBasicStruct" }

@objc(ManagedBasicStruct)
final public class ManagedBasicStruct: PersistableManagedObject, KeyPathable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedBasicStruct> {
        return NSFetchRequest<ManagedBasicStruct>(entityName: "ManagedBasicStruct")
    }

    public static var idKeyPath: WritableKeyPath<ManagedBasicStruct, String> {
        return \ManagedBasicStruct.id
    }

    public static var groupIDKeyPath: WritableKeyPath<ManagedBasicStruct, String?> {
        return \ManagedBasicStruct.lfCoreDataEntityGroupIdentifier
    }

    @NSManaged @objc(lfCoreDataEntityIsPopulated) public var lfCoreDataEntityIsPopulated: NSNumber

    public var isPopulated: Bool {
        return lfCoreDataEntityIsPopulated as! Bool
    }

    @NSManaged @objc(lfCoreDataEntityGroupIdentifier) public var lfCoreDataEntityGroupIdentifier: String?

    @NSManaged public var id: String
    @NSManaged public var otherValue: NSNumber

    var plainModel: BasicStruct?
    var plainCounter = 0
    public var isModelRecursive: Bool { return plainCounter > 5 }

    func toPlainModel(isRecursive: Bool = false) -> BasicStruct {
        plainCounter.increment(); defer { plainCounter.decrement() }
        if var model = self.plainModel {
            model.id = self.id
        } else {
            let basicStruct = BasicStruct(
            id: self.id,
            otherValue: self.otherValue.intValue
        )
        self.plainModel = basicStruct
      }
        return plainModel!
    }

    override public func awakeFromInsert() {
      super.awakeFromInsert()
      self.id = .empty
      self.otherValue = .empty
    }


    @discardableResult
    public func populate<T : Persistable>(groupID: String?, with plainModel: T, context: NSManagedObjectContext) -> Self {
        guard let plainModel = plainModel as? BasicStruct else { return self }
        lfCoreDataEntityIsPopulated = NSNumber(booleanLiteral: true)
        lfCoreDataEntityGroupIdentifier = groupID
        id = plainModel.id 
        otherValue = plainModel.otherValue as NSNumber
        return self
    }

    public static func managedKeyPathFrom<EntityType, VariableType>(_ plainKeyPath: KeyPath<EntityType, VariableType>) -> String {
        switch plainKeyPath {
            case \BasicStruct.id: return "id"
            case \BasicStruct.otherValue: return "otherValue"
            default: return ""
        }
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        do {
            let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "ManagedBasicStruct")
            fetchRequest.returnsDistinctResults = true
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.propertiesToFetch = ["lfCoreDataEntityGroupIdentifier"]
            let result = try sourceContext.fetch(fetchRequest).flatMap { $0.allValues }.compactMap { $0 as? String }
            return result
        } catch {
            logError(error)
            return nil
        }
    }
}

extension BasicStruct: Persistable, UniqueIDConstraintKeyPath {
    public static var idKeyPath: WritableKeyPath<BasicStruct, ManagedBasicStruct.EntityID> {
        return \BasicStruct.id
    }

    public static func count(groupID: String? = nil, using predicate: NSPredicate = .true, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Int {
        return ManagedBasicStruct.count(groupID: groupID, using: predicate, sourceContext: sourceContext)
    }

    public static func get(entityID: ManagedBasicStruct.EntityID, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> BasicStruct? {
        ManagedBasicStruct.get(entityID: entityID, sourceContext: sourceContext)?.toPlainModel()
    }

    public static func get(groupID: String? = nil, using predicate: NSPredicate, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [BasicStruct] {
        ManagedBasicStruct.get(groupID: groupID, using: predicate, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func getAll(groupID: String? = nil, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [BasicStruct] {
        ManagedBasicStruct.getAll(groupID: groupID, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func create(groupID: String? = nil,
                              updateIfEntityExists: Bool,
                              updateClosure: @escaping (_ entity: inout BasicStruct, _ context: NSManagedObjectContext) -> Void,
                              completeClosure: ((Result<BasicStruct, PersistableError>) -> Void)?) {
                               ManagedBasicStruct.create(groupID: groupID,
            updateIfEntityExists: updateIfEntityExists,
            updateClosure: { (entity, context) in
                var plainEntity: BasicStruct = entity.toPlainModel()
                updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }, completeClosure: { result in
            switch result {
                case .success(let entity):
                    completeClosure?(.success(entity.toPlainModel()))

                case .failure(let error):
                    completeClosure?(.failure(error))
            }
        })
    }

    public static func createEntity(groupID: String? = nil, entityID: ManagedBasicStruct.EntityID, context: NSManagedObjectContext) -> BasicStruct? {
        ManagedBasicStruct.createEntity(groupID: groupID, entityID: entityID, context: context)?.toPlainModel()
    }

    public static func createTemporary(groupID: String? = nil, updateClosure: @escaping (inout BasicStruct, NSManagedObjectContext) -> Void) {
        ManagedBasicStruct.createTemporary { (entity, context) in
            var plainEntity = entity.toPlainModel()
            updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }
    }

    public func createAndPopulate(groupID: String? = nil, updateIfEntityExists: Bool = true, insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<BasicStruct, PersistableError>) -> Void)?) {
        ManagedBasicStruct.createBatchAndPopulate(groupID: groupID, from: [self], insertionPolicy: insertionPolicy) { result in
            switch result {
            case .success(let response):
                guard let savedEntity = response.first else { completeClosure?(.failure(.failedToSaveEntityToStore)); return }
                completeClosure?(.success(savedEntity))
            case .failure(let error):
                completeClosure?(.failure(error))
            }
        }
    }

    public func update(updateClosure: @escaping (inout BasicStruct, NSManagedObjectContext) -> Void, completeClosure: ((BasicStruct) -> Void)?) {
        let managedEntity = ManagedBasicStruct.get(entityID: self[keyPath: Self.idKeyPath])

        managedEntity?.update(updateClosure: { (entity, context) in
            var mutableSelf = self
            updateClosure(&mutableSelf, context)
            entity.populate(groupID: managedEntity?.lfCoreDataEntityGroupIdentifier, with: mutableSelf, context: context)

        }, completeClosure: { updatedEntity in
            completeClosure?(updatedEntity.toPlainModel())
        })
    }

    public func delete(sourceContext: NSManagedObjectContext = CoreDataStore.shared.newBackgroundContext, completeClosure: (() -> Void)?) {
        let managedEntity = ManagedBasicStruct.get(entityID: self[keyPath: Self.idKeyPath], sourceContext: sourceContext)
        managedEntity?.delete(sourceContext: sourceContext, completeClosure: completeClosure)
    }

    public static func delete(with options: DeleteOptions = DeleteOptions(), completeClosure: (() -> Void)?) {
        ManagedBasicStruct.delete(with: options, completeClosure: completeClosure)
    }

    public static func createBatchAndPopulate<PersistableType: Persistable & UniqueIDConstraintKeyPath>(groupID: String? = nil, from plainModels: [PersistableType], insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<[PersistableType], PersistableError>) -> Void)?) {
      ManagedBasicStruct.createBatchAndPopulate(groupID: groupID, from: plainModels, insertionPolicy: insertionPolicy, completeClosure: completeClosure)
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        return ManagedBasicStruct.getAllGroups(sourceContext: sourceContext)
    }
}

extension Car { static var managedModelName = "ManagedCar" }

@objc(ManagedCar)
final public class ManagedCar: PersistableManagedObject, KeyPathable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedCar> {
        return NSFetchRequest<ManagedCar>(entityName: "ManagedCar")
    }

    public static var idKeyPath: WritableKeyPath<ManagedCar, String?> {
        return \ManagedCar.id
    }

    public static var groupIDKeyPath: WritableKeyPath<ManagedCar, String?> {
        return \ManagedCar.lfCoreDataEntityGroupIdentifier
    }

    @NSManaged @objc(lfCoreDataEntityIsPopulated) public var lfCoreDataEntityIsPopulated: NSNumber

    public var isPopulated: Bool {
        return lfCoreDataEntityIsPopulated as! Bool
    }

    @NSManaged @objc(lfCoreDataEntityGroupIdentifier) public var lfCoreDataEntityGroupIdentifier: String?

    @NSManaged public var id: String?
    @NSManaged public var manufacturer: String
    @NSManaged public var name: String

    var plainModel: Car?
    var plainCounter = 0
    public var isModelRecursive: Bool { return plainCounter > 5 }

    func toPlainModel(isRecursive: Bool = false) -> Car {
        plainCounter.increment(); defer { plainCounter.decrement() }
        if var model = self.plainModel {
            model.id = self.id
        } else {
            let car = Car(
            id: self.id,
            manufacturer: self.manufacturer,
            name: self.name
        )
        self.plainModel = car
      }
        return plainModel!
    }

    override public func awakeFromInsert() {
      super.awakeFromInsert()
      self.manufacturer = .empty
      self.name = .empty
    }


    @discardableResult
    public func populate<T : Persistable>(groupID: String?, with plainModel: T, context: NSManagedObjectContext) -> Self {
        guard let plainModel = plainModel as? Car else { return self }
        lfCoreDataEntityIsPopulated = NSNumber(booleanLiteral: true)
        lfCoreDataEntityGroupIdentifier = groupID
        // Set autoID
        id = UUID().uuidString
        manufacturer = plainModel.manufacturer 
        name = plainModel.name 
        return self
    }

    public static func managedKeyPathFrom<EntityType, VariableType>(_ plainKeyPath: KeyPath<EntityType, VariableType>) -> String {
        switch plainKeyPath {
            case \Car.id: return "id"
            case \Car.manufacturer: return "manufacturer"
            case \Car.name: return "name"
            default: return ""
        }
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        do {
            let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "ManagedCar")
            fetchRequest.returnsDistinctResults = true
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.propertiesToFetch = ["lfCoreDataEntityGroupIdentifier"]
            let result = try sourceContext.fetch(fetchRequest).flatMap { $0.allValues }.compactMap { $0 as? String }
            return result
        } catch {
            logError(error)
            return nil
        }
    }
}

extension Car: Persistable, UniqueIDConstraintKeyPath {
    public static var idKeyPath: WritableKeyPath<Car, ManagedCar.EntityID> {
        return \Car.id
    }

    public static func count(groupID: String? = nil, using predicate: NSPredicate = .true, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Int {
        return ManagedCar.count(groupID: groupID, using: predicate, sourceContext: sourceContext)
    }

    public static func get(entityID: ManagedCar.EntityID, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Car? {
        ManagedCar.get(entityID: entityID, sourceContext: sourceContext)?.toPlainModel()
    }

    public static func get(groupID: String? = nil, using predicate: NSPredicate, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [Car] {
        ManagedCar.get(groupID: groupID, using: predicate, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func getAll(groupID: String? = nil, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [Car] {
        ManagedCar.getAll(groupID: groupID, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func create(groupID: String? = nil,
                              updateIfEntityExists: Bool,
                              updateClosure: @escaping (_ entity: inout Car, _ context: NSManagedObjectContext) -> Void,
                              completeClosure: ((Result<Car, PersistableError>) -> Void)?) {
                               ManagedCar.create(groupID: groupID,
            updateIfEntityExists: updateIfEntityExists,
            updateClosure: { (entity, context) in
                var plainEntity: Car = entity.toPlainModel()
                updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }, completeClosure: { result in
            switch result {
                case .success(let entity):
                    completeClosure?(.success(entity.toPlainModel()))

                case .failure(let error):
                    completeClosure?(.failure(error))
            }
        })
    }

    public static func createEntity(groupID: String? = nil, entityID: ManagedCar.EntityID, context: NSManagedObjectContext) -> Car? {
        ManagedCar.createEntity(groupID: groupID, entityID: entityID, context: context)?.toPlainModel()
    }

    public static func createTemporary(groupID: String? = nil, updateClosure: @escaping (inout Car, NSManagedObjectContext) -> Void) {
        ManagedCar.createTemporary { (entity, context) in
            var plainEntity = entity.toPlainModel()
            updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }
    }

    public func createAndPopulate(groupID: String? = nil, updateIfEntityExists: Bool = true, insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<Car, PersistableError>) -> Void)?) {
        ManagedCar.createBatchAndPopulate(groupID: groupID, from: [self], insertionPolicy: insertionPolicy) { result in
            switch result {
            case .success(let response):
                guard let savedEntity = response.first else { completeClosure?(.failure(.failedToSaveEntityToStore)); return }
                completeClosure?(.success(savedEntity))
            case .failure(let error):
                completeClosure?(.failure(error))
            }
        }
    }

    public func update(updateClosure: @escaping (inout Car, NSManagedObjectContext) -> Void, completeClosure: ((Car) -> Void)?) {
        let managedEntity = ManagedCar.get(entityID: self[keyPath: Self.idKeyPath])

        managedEntity?.update(updateClosure: { (entity, context) in
            var mutableSelf = self
            updateClosure(&mutableSelf, context)
            entity.populate(groupID: managedEntity?.lfCoreDataEntityGroupIdentifier, with: mutableSelf, context: context)

        }, completeClosure: { updatedEntity in
            completeClosure?(updatedEntity.toPlainModel())
        })
    }

    public func delete(sourceContext: NSManagedObjectContext = CoreDataStore.shared.newBackgroundContext, completeClosure: (() -> Void)?) {
        let managedEntity = ManagedCar.get(entityID: self[keyPath: Self.idKeyPath], sourceContext: sourceContext)
        managedEntity?.delete(sourceContext: sourceContext, completeClosure: completeClosure)
    }

    public static func delete(with options: DeleteOptions = DeleteOptions(), completeClosure: (() -> Void)?) {
        ManagedCar.delete(with: options, completeClosure: completeClosure)
    }

    public static func createBatchAndPopulate<PersistableType: Persistable & UniqueIDConstraintKeyPath>(groupID: String? = nil, from plainModels: [PersistableType], insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<[PersistableType], PersistableError>) -> Void)?) {
      ManagedCar.createBatchAndPopulate(groupID: groupID, from: plainModels, insertionPolicy: insertionPolicy, completeClosure: completeClosure)
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        return ManagedCar.getAllGroups(sourceContext: sourceContext)
    }
}

extension ChildNestedClass { static var managedModelName = "ManagedChildNestedClass" }

@objc(ManagedChildNestedClass)
final public class ManagedChildNestedClass: PersistableManagedObject, KeyPathable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedChildNestedClass> {
        return NSFetchRequest<ManagedChildNestedClass>(entityName: "ManagedChildNestedClass")
    }

    public static var idKeyPath: WritableKeyPath<ManagedChildNestedClass, String> {
        return \ManagedChildNestedClass.id
    }

    public static var groupIDKeyPath: WritableKeyPath<ManagedChildNestedClass, String?> {
        return \ManagedChildNestedClass.lfCoreDataEntityGroupIdentifier
    }

    @NSManaged @objc(lfCoreDataEntityIsPopulated) public var lfCoreDataEntityIsPopulated: NSNumber

    public var isPopulated: Bool {
        return lfCoreDataEntityIsPopulated as! Bool
    }

    @NSManaged @objc(lfCoreDataEntityGroupIdentifier) public var lfCoreDataEntityGroupIdentifier: String?

    @NSManaged public var id: String
    @NSManaged public var name: String

    var plainModel: ChildNestedClass?
    var plainCounter = 0
    public var isModelRecursive: Bool { return plainCounter > 5 }

    func toPlainModel(isRecursive: Bool = false) -> ChildNestedClass {
        plainCounter.increment(); defer { plainCounter.decrement() }
        if let model = self.plainModel {
            model.id = self.id
        } else {
            let childNestedClass = ChildNestedClass(
            id: self.id,
            name: self.name
        )
        self.plainModel = childNestedClass
      }
        return plainModel!
    }

    override public func awakeFromInsert() {
      super.awakeFromInsert()
      self.id = .empty
      self.name = .empty
    }


    @discardableResult
    public func populate<T : Persistable>(groupID: String?, with plainModel: T, context: NSManagedObjectContext) -> Self {
        guard let plainModel = plainModel as? ChildNestedClass else { return self }
        lfCoreDataEntityIsPopulated = NSNumber(booleanLiteral: true)
        lfCoreDataEntityGroupIdentifier = groupID
        id = plainModel.id 
        name = plainModel.name 
        return self
    }

    public static func managedKeyPathFrom<EntityType, VariableType>(_ plainKeyPath: KeyPath<EntityType, VariableType>) -> String {
        switch plainKeyPath {
            case \ChildNestedClass.id: return "id"
            case \ChildNestedClass.name: return "name"
            default: return ""
        }
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        do {
            let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "ManagedChildNestedClass")
            fetchRequest.returnsDistinctResults = true
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.propertiesToFetch = ["lfCoreDataEntityGroupIdentifier"]
            let result = try sourceContext.fetch(fetchRequest).flatMap { $0.allValues }.compactMap { $0 as? String }
            return result
        } catch {
            logError(error)
            return nil
        }
    }
}

extension ChildNestedClass: Persistable, UniqueIDConstraintKeyPath {
    public static var idKeyPath: WritableKeyPath<ChildNestedClass, ManagedChildNestedClass.EntityID> {
        return \ChildNestedClass.id
    }

    public static func count(groupID: String? = nil, using predicate: NSPredicate = .true, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Int {
        return ManagedChildNestedClass.count(groupID: groupID, using: predicate, sourceContext: sourceContext)
    }

    public static func get(entityID: ManagedChildNestedClass.EntityID, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> ChildNestedClass? {
        ManagedChildNestedClass.get(entityID: entityID, sourceContext: sourceContext)?.toPlainModel()
    }

    public static func get(groupID: String? = nil, using predicate: NSPredicate, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [ChildNestedClass] {
        ManagedChildNestedClass.get(groupID: groupID, using: predicate, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func getAll(groupID: String? = nil, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [ChildNestedClass] {
        ManagedChildNestedClass.getAll(groupID: groupID, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func create(groupID: String? = nil,
                              updateIfEntityExists: Bool,
                              updateClosure: @escaping (_ entity: inout ChildNestedClass, _ context: NSManagedObjectContext) -> Void,
                              completeClosure: ((Result<ChildNestedClass, PersistableError>) -> Void)?) {
                               ManagedChildNestedClass.create(groupID: groupID,
            updateIfEntityExists: updateIfEntityExists,
            updateClosure: { (entity, context) in
                var plainEntity: ChildNestedClass = entity.toPlainModel()
                updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }, completeClosure: { result in
            switch result {
                case .success(let entity):
                    completeClosure?(.success(entity.toPlainModel()))

                case .failure(let error):
                    completeClosure?(.failure(error))
            }
        })
    }

    public static func createEntity(groupID: String? = nil, entityID: ManagedChildNestedClass.EntityID, context: NSManagedObjectContext) -> ChildNestedClass? {
        ManagedChildNestedClass.createEntity(groupID: groupID, entityID: entityID, context: context)?.toPlainModel()
    }

    public static func createTemporary(groupID: String? = nil, updateClosure: @escaping (inout ChildNestedClass, NSManagedObjectContext) -> Void) {
        ManagedChildNestedClass.createTemporary { (entity, context) in
            var plainEntity = entity.toPlainModel()
            updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }
    }

    public func createAndPopulate(groupID: String? = nil, updateIfEntityExists: Bool = true, insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<ChildNestedClass, PersistableError>) -> Void)?) {
        ManagedChildNestedClass.createBatchAndPopulate(groupID: groupID, from: [self], insertionPolicy: insertionPolicy) { result in
            switch result {
            case .success(let response):
                guard let savedEntity = response.first else { completeClosure?(.failure(.failedToSaveEntityToStore)); return }
                completeClosure?(.success(savedEntity))
            case .failure(let error):
                completeClosure?(.failure(error))
            }
        }
    }

    public func update(updateClosure: @escaping (inout ChildNestedClass, NSManagedObjectContext) -> Void, completeClosure: ((ChildNestedClass) -> Void)?) {
        let managedEntity = ManagedChildNestedClass.get(entityID: self[keyPath: Self.idKeyPath])

        managedEntity?.update(updateClosure: { (entity, context) in
            var mutableSelf = self
            updateClosure(&mutableSelf, context)
            entity.populate(groupID: managedEntity?.lfCoreDataEntityGroupIdentifier, with: mutableSelf, context: context)

        }, completeClosure: { updatedEntity in
            completeClosure?(updatedEntity.toPlainModel())
        })
    }

    public func delete(sourceContext: NSManagedObjectContext = CoreDataStore.shared.newBackgroundContext, completeClosure: (() -> Void)?) {
        let managedEntity = ManagedChildNestedClass.get(entityID: self[keyPath: Self.idKeyPath], sourceContext: sourceContext)
        managedEntity?.delete(sourceContext: sourceContext, completeClosure: completeClosure)
    }

    public static func delete(with options: DeleteOptions = DeleteOptions(), completeClosure: (() -> Void)?) {
        ManagedChildNestedClass.delete(with: options, completeClosure: completeClosure)
    }

    public static func createBatchAndPopulate<PersistableType: Persistable & UniqueIDConstraintKeyPath>(groupID: String? = nil, from plainModels: [PersistableType], insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<[PersistableType], PersistableError>) -> Void)?) {
      ManagedChildNestedClass.createBatchAndPopulate(groupID: groupID, from: plainModels, insertionPolicy: insertionPolicy, completeClosure: completeClosure)
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        return ManagedChildNestedClass.getAllGroups(sourceContext: sourceContext)
    }
}

extension ChildRecursiveClass { static var managedModelName = "ManagedChildRecursiveClass" }

@objc(ManagedChildRecursiveClass)
final public class ManagedChildRecursiveClass: PersistableManagedObject, KeyPathable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedChildRecursiveClass> {
        return NSFetchRequest<ManagedChildRecursiveClass>(entityName: "ManagedChildRecursiveClass")
    }

    public static var idKeyPath: WritableKeyPath<ManagedChildRecursiveClass, String> {
        return \ManagedChildRecursiveClass.id
    }

    public static var groupIDKeyPath: WritableKeyPath<ManagedChildRecursiveClass, String?> {
        return \ManagedChildRecursiveClass.lfCoreDataEntityGroupIdentifier
    }

    @NSManaged @objc(lfCoreDataEntityIsPopulated) public var lfCoreDataEntityIsPopulated: NSNumber

    public var isPopulated: Bool {
        return lfCoreDataEntityIsPopulated as! Bool
    }

    @NSManaged @objc(lfCoreDataEntityGroupIdentifier) public var lfCoreDataEntityGroupIdentifier: String?

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var grandchild: ManagedGrandchildRecursiveClass?
    @NSManaged public var parent: ManagedParentRecursiveClass?

    var plainModel: ChildRecursiveClass?
    var plainCounter = 0
    public var isModelRecursive: Bool { return plainCounter > 5 }

    func toPlainModel(isRecursive: Bool = false) -> ChildRecursiveClass {
        plainCounter.increment(); defer { plainCounter.decrement() }
        if let model = self.plainModel {
            model.id = self.id
            model.grandchild = self.grandchild?.toPlainModel(isRecursive: grandchild?.isModelRecursive ?? false)
            if !isRecursive { model.parent = isRecursive ? nil : self.parent?.toPlainModel(isRecursive: parent?.isModelRecursive ?? false)}
        } else {
            let childRecursiveClass = ChildRecursiveClass(
            id: self.id,
            name: self.name,
            grandchild: self.grandchild?.toPlainModel(isRecursive: grandchild?.isModelRecursive ?? false),
            parent: isRecursive ? nil : self.parent?.toPlainModel(isRecursive: parent?.isModelRecursive ?? false)
        )
        self.plainModel = childRecursiveClass
      }
        return plainModel!
    }

    override public func awakeFromInsert() {
      super.awakeFromInsert()
      self.id = .empty
      self.name = .empty
    }


    @discardableResult
    public func populate<T : Persistable>(groupID: String?, with plainModel: T, context: NSManagedObjectContext) -> Self {
        guard let plainModel = plainModel as? ChildRecursiveClass else { return self }
        lfCoreDataEntityIsPopulated = NSNumber(booleanLiteral: true)
        lfCoreDataEntityGroupIdentifier = groupID
        id = plainModel.id 
        name = plainModel.name 
        if let grandchild = plainModel.grandchild {
            if let managedGrandchild = ManagedGrandchildRecursiveClass.get(entityID: grandchild.uniqueIdValue, sourceContext: context) {
                self.grandchild = managedGrandchild
                return self
            }
        if let managedRelationship = ManagedGrandchildRecursiveClass
                .createEntity(entityID: grandchild.uniqueIdValue, context: context)?
                .populate(groupID: groupID, with: grandchild, context: context) {
                  self.grandchild = managedRelationship
        }
        }
        if let parent = plainModel.parent {
            if let managedParent = ManagedParentRecursiveClass.get(entityID: parent.uniqueIdValue, sourceContext: context) {
                self.parent = managedParent
                return self
            }
        if let managedRelationship = ManagedParentRecursiveClass
                .createEntity(entityID: parent.uniqueIdValue, context: context)?
                .populate(groupID: groupID, with: parent, context: context) {
                  self.parent = managedRelationship
        }
        }
        return self
    }

    public static func managedKeyPathFrom<EntityType, VariableType>(_ plainKeyPath: KeyPath<EntityType, VariableType>) -> String {
        switch plainKeyPath {
            case \ChildRecursiveClass.id: return "id"
            case \ChildRecursiveClass.name: return "name"
            case \ChildRecursiveClass.grandchild?.id: return "grandchild.id"
            case \ChildRecursiveClass.grandchild?.name: return "grandchild.name"
            default: return ""
        }
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        do {
            let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "ManagedChildRecursiveClass")
            fetchRequest.returnsDistinctResults = true
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.propertiesToFetch = ["lfCoreDataEntityGroupIdentifier"]
            let result = try sourceContext.fetch(fetchRequest).flatMap { $0.allValues }.compactMap { $0 as? String }
            return result
        } catch {
            logError(error)
            return nil
        }
    }
}

extension ChildRecursiveClass: Persistable, UniqueIDConstraintKeyPath {
    public static var idKeyPath: WritableKeyPath<ChildRecursiveClass, ManagedChildRecursiveClass.EntityID> {
        return \ChildRecursiveClass.id
    }

    public static func count(groupID: String? = nil, using predicate: NSPredicate = .true, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Int {
        return ManagedChildRecursiveClass.count(groupID: groupID, using: predicate, sourceContext: sourceContext)
    }

    public static func get(entityID: ManagedChildRecursiveClass.EntityID, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> ChildRecursiveClass? {
        ManagedChildRecursiveClass.get(entityID: entityID, sourceContext: sourceContext)?.toPlainModel()
    }

    public static func get(groupID: String? = nil, using predicate: NSPredicate, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [ChildRecursiveClass] {
        ManagedChildRecursiveClass.get(groupID: groupID, using: predicate, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func getAll(groupID: String? = nil, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [ChildRecursiveClass] {
        ManagedChildRecursiveClass.getAll(groupID: groupID, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func create(groupID: String? = nil,
                              updateIfEntityExists: Bool,
                              updateClosure: @escaping (_ entity: inout ChildRecursiveClass, _ context: NSManagedObjectContext) -> Void,
                              completeClosure: ((Result<ChildRecursiveClass, PersistableError>) -> Void)?) {
                               ManagedChildRecursiveClass.create(groupID: groupID,
            updateIfEntityExists: updateIfEntityExists,
            updateClosure: { (entity, context) in
                var plainEntity: ChildRecursiveClass = entity.toPlainModel()
                updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }, completeClosure: { result in
            switch result {
                case .success(let entity):
                    completeClosure?(.success(entity.toPlainModel()))

                case .failure(let error):
                    completeClosure?(.failure(error))
            }
        })
    }

    public static func createEntity(groupID: String? = nil, entityID: ManagedChildRecursiveClass.EntityID, context: NSManagedObjectContext) -> ChildRecursiveClass? {
        ManagedChildRecursiveClass.createEntity(groupID: groupID, entityID: entityID, context: context)?.toPlainModel()
    }

    public static func createTemporary(groupID: String? = nil, updateClosure: @escaping (inout ChildRecursiveClass, NSManagedObjectContext) -> Void) {
        ManagedChildRecursiveClass.createTemporary { (entity, context) in
            var plainEntity = entity.toPlainModel()
            updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }
    }

    public func createAndPopulate(groupID: String? = nil, updateIfEntityExists: Bool = true, insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<ChildRecursiveClass, PersistableError>) -> Void)?) {
        ManagedChildRecursiveClass.createBatchAndPopulate(groupID: groupID, from: [self], insertionPolicy: insertionPolicy) { result in
            switch result {
            case .success(let response):
                guard let savedEntity = response.first else { completeClosure?(.failure(.failedToSaveEntityToStore)); return }
                completeClosure?(.success(savedEntity))
            case .failure(let error):
                completeClosure?(.failure(error))
            }
        }
    }

    public func update(updateClosure: @escaping (inout ChildRecursiveClass, NSManagedObjectContext) -> Void, completeClosure: ((ChildRecursiveClass) -> Void)?) {
        let managedEntity = ManagedChildRecursiveClass.get(entityID: self[keyPath: Self.idKeyPath])

        managedEntity?.update(updateClosure: { (entity, context) in
            var mutableSelf = self
            updateClosure(&mutableSelf, context)
            entity.populate(groupID: managedEntity?.lfCoreDataEntityGroupIdentifier, with: mutableSelf, context: context)

        }, completeClosure: { updatedEntity in
            completeClosure?(updatedEntity.toPlainModel())
        })
    }

    public func delete(sourceContext: NSManagedObjectContext = CoreDataStore.shared.newBackgroundContext, completeClosure: (() -> Void)?) {
        let managedEntity = ManagedChildRecursiveClass.get(entityID: self[keyPath: Self.idKeyPath], sourceContext: sourceContext)
        managedEntity?.delete(sourceContext: sourceContext, completeClosure: completeClosure)
    }

    public static func delete(with options: DeleteOptions = DeleteOptions(), completeClosure: (() -> Void)?) {
        ManagedChildRecursiveClass.delete(with: options, completeClosure: completeClosure)
    }

    public static func createBatchAndPopulate<PersistableType: Persistable & UniqueIDConstraintKeyPath>(groupID: String? = nil, from plainModels: [PersistableType], insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<[PersistableType], PersistableError>) -> Void)?) {
      ManagedChildRecursiveClass.createBatchAndPopulate(groupID: groupID, from: plainModels, insertionPolicy: insertionPolicy, completeClosure: completeClosure)
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        return ManagedChildRecursiveClass.getAllGroups(sourceContext: sourceContext)
    }
}

extension ChildStruct { static var managedModelName = "ManagedChildStruct" }

@objc(ManagedChildStruct)
final public class ManagedChildStruct: PersistableManagedObject, KeyPathable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedChildStruct> {
        return NSFetchRequest<ManagedChildStruct>(entityName: "ManagedChildStruct")
    }

    public static var idKeyPath: WritableKeyPath<ManagedChildStruct, String> {
        return \ManagedChildStruct.id
    }

    public static var groupIDKeyPath: WritableKeyPath<ManagedChildStruct, String?> {
        return \ManagedChildStruct.lfCoreDataEntityGroupIdentifier
    }

    @NSManaged @objc(lfCoreDataEntityIsPopulated) public var lfCoreDataEntityIsPopulated: NSNumber

    public var isPopulated: Bool {
        return lfCoreDataEntityIsPopulated as! Bool
    }

    @NSManaged @objc(lfCoreDataEntityGroupIdentifier) public var lfCoreDataEntityGroupIdentifier: String?

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var age: NSNumber
    @NSManaged public var child: ManagedGrandChild?
    @NSManaged public var projects: NSOrderedSet

    var plainModel: ChildStruct?
    var plainCounter = 0
    public var isModelRecursive: Bool { return plainCounter > 5 }

    func toPlainModel(isRecursive: Bool = false) -> ChildStruct {
        plainCounter.increment(); defer { plainCounter.decrement() }
        if var model = self.plainModel {
            model.id = self.id
        } else {
            let childStruct = ChildStruct(
            id: self.id,
            name: self.name,
            age: self.age.intValue,
            child: self.child?.toPlainModel(isRecursive: child?.isModelRecursive ?? false),
            projects: self.projects.filter { ($0 as! ManagedProject).isPopulated }.compactMap{($0 as! ManagedProject).toPlainModel(isRecursive: ($0 as! ManagedProject).isModelRecursive)}
        )
        self.plainModel = childStruct
      }
        return plainModel!
    }

    override public func awakeFromInsert() {
      super.awakeFromInsert()
      self.id = .empty
      self.name = .empty
      self.age = .empty
    }


    @discardableResult
    public func populate<T : Persistable>(groupID: String?, with plainModel: T, context: NSManagedObjectContext) -> Self {
        guard let plainModel = plainModel as? ChildStruct else { return self }
        lfCoreDataEntityIsPopulated = NSNumber(booleanLiteral: true)
        lfCoreDataEntityGroupIdentifier = groupID
        id = plainModel.id 
        name = plainModel.name 
        age = plainModel.age as NSNumber
        if let child = plainModel.child {
            if let managedChild = ManagedGrandChild.get(entityID: child.uniqueIdValue, sourceContext: context) {
                self.child = managedChild
                return self
            }
        if let managedRelationship = ManagedGrandChild
                .createEntity(entityID: child.uniqueIdValue, context: context)?
                .populate(groupID: groupID, with: child, context: context) {
                  self.child = managedRelationship
        }
        }
        let projectsToManyRelationship = NSMutableOrderedSet()

        for element in plainModel.projects ?? [] {
            if let managedRelationship = ManagedProject
                   .createEntity(entityID: element[keyPath: Project.idKeyPath], context: context)?
                   .populate(groupID: groupID, with: element, context: context) {
                projectsToManyRelationship.add(managedRelationship)
            }
        }
        self.projects = projectsToManyRelationship
        return self
    }

    public static func managedKeyPathFrom<EntityType, VariableType>(_ plainKeyPath: KeyPath<EntityType, VariableType>) -> String {
        switch plainKeyPath {
            case \ChildStruct.id: return "id"
            case \ChildStruct.name: return "name"
            case \ChildStruct.age: return "age"
            case \ChildStruct.child?.id: return "child.id"
            case \ChildStruct.child?.firstName: return "child.firstName"
            case \ChildStruct.child?.age: return "child.age"
            case \ChildStruct.projects: return "projects"
            default: return ""
        }
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        do {
            let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "ManagedChildStruct")
            fetchRequest.returnsDistinctResults = true
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.propertiesToFetch = ["lfCoreDataEntityGroupIdentifier"]
            let result = try sourceContext.fetch(fetchRequest).flatMap { $0.allValues }.compactMap { $0 as? String }
            return result
        } catch {
            logError(error)
            return nil
        }
    }
}

extension ChildStruct: Persistable, UniqueIDConstraintKeyPath {
    public static var idKeyPath: WritableKeyPath<ChildStruct, ManagedChildStruct.EntityID> {
        return \ChildStruct.id
    }

    public static func count(groupID: String? = nil, using predicate: NSPredicate = .true, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Int {
        return ManagedChildStruct.count(groupID: groupID, using: predicate, sourceContext: sourceContext)
    }

    public static func get(entityID: ManagedChildStruct.EntityID, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> ChildStruct? {
        ManagedChildStruct.get(entityID: entityID, sourceContext: sourceContext)?.toPlainModel()
    }

    public static func get(groupID: String? = nil, using predicate: NSPredicate, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [ChildStruct] {
        ManagedChildStruct.get(groupID: groupID, using: predicate, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func getAll(groupID: String? = nil, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [ChildStruct] {
        ManagedChildStruct.getAll(groupID: groupID, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func create(groupID: String? = nil,
                              updateIfEntityExists: Bool,
                              updateClosure: @escaping (_ entity: inout ChildStruct, _ context: NSManagedObjectContext) -> Void,
                              completeClosure: ((Result<ChildStruct, PersistableError>) -> Void)?) {
                               ManagedChildStruct.create(groupID: groupID,
            updateIfEntityExists: updateIfEntityExists,
            updateClosure: { (entity, context) in
                var plainEntity: ChildStruct = entity.toPlainModel()
                updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }, completeClosure: { result in
            switch result {
                case .success(let entity):
                    completeClosure?(.success(entity.toPlainModel()))

                case .failure(let error):
                    completeClosure?(.failure(error))
            }
        })
    }

    public static func createEntity(groupID: String? = nil, entityID: ManagedChildStruct.EntityID, context: NSManagedObjectContext) -> ChildStruct? {
        ManagedChildStruct.createEntity(groupID: groupID, entityID: entityID, context: context)?.toPlainModel()
    }

    public static func createTemporary(groupID: String? = nil, updateClosure: @escaping (inout ChildStruct, NSManagedObjectContext) -> Void) {
        ManagedChildStruct.createTemporary { (entity, context) in
            var plainEntity = entity.toPlainModel()
            updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }
    }

    public func createAndPopulate(groupID: String? = nil, updateIfEntityExists: Bool = true, insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<ChildStruct, PersistableError>) -> Void)?) {
        ManagedChildStruct.createBatchAndPopulate(groupID: groupID, from: [self], insertionPolicy: insertionPolicy) { result in
            switch result {
            case .success(let response):
                guard let savedEntity = response.first else { completeClosure?(.failure(.failedToSaveEntityToStore)); return }
                completeClosure?(.success(savedEntity))
            case .failure(let error):
                completeClosure?(.failure(error))
            }
        }
    }

    public func update(updateClosure: @escaping (inout ChildStruct, NSManagedObjectContext) -> Void, completeClosure: ((ChildStruct) -> Void)?) {
        let managedEntity = ManagedChildStruct.get(entityID: self[keyPath: Self.idKeyPath])

        managedEntity?.update(updateClosure: { (entity, context) in
            var mutableSelf = self
            updateClosure(&mutableSelf, context)
            entity.populate(groupID: managedEntity?.lfCoreDataEntityGroupIdentifier, with: mutableSelf, context: context)

        }, completeClosure: { updatedEntity in
            completeClosure?(updatedEntity.toPlainModel())
        })
    }

    public func delete(sourceContext: NSManagedObjectContext = CoreDataStore.shared.newBackgroundContext, completeClosure: (() -> Void)?) {
        let managedEntity = ManagedChildStruct.get(entityID: self[keyPath: Self.idKeyPath], sourceContext: sourceContext)
        managedEntity?.delete(sourceContext: sourceContext, completeClosure: completeClosure)
    }

    public static func delete(with options: DeleteOptions = DeleteOptions(), completeClosure: (() -> Void)?) {
        ManagedChildStruct.delete(with: options, completeClosure: completeClosure)
    }

    public static func createBatchAndPopulate<PersistableType: Persistable & UniqueIDConstraintKeyPath>(groupID: String? = nil, from plainModels: [PersistableType], insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<[PersistableType], PersistableError>) -> Void)?) {
      ManagedChildStruct.createBatchAndPopulate(groupID: groupID, from: plainModels, insertionPolicy: insertionPolicy, completeClosure: completeClosure)
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        return ManagedChildStruct.getAllGroups(sourceContext: sourceContext)
    }
}

extension GrandChild { static var managedModelName = "ManagedGrandChild" }

@objc(ManagedGrandChild)
final public class ManagedGrandChild: PersistableManagedObject, KeyPathable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedGrandChild> {
        return NSFetchRequest<ManagedGrandChild>(entityName: "ManagedGrandChild")
    }

    public static var idKeyPath: WritableKeyPath<ManagedGrandChild, String> {
        return \ManagedGrandChild.id
    }

    public static var groupIDKeyPath: WritableKeyPath<ManagedGrandChild, String?> {
        return \ManagedGrandChild.lfCoreDataEntityGroupIdentifier
    }

    @NSManaged @objc(lfCoreDataEntityIsPopulated) public var lfCoreDataEntityIsPopulated: NSNumber

    public var isPopulated: Bool {
        return lfCoreDataEntityIsPopulated as! Bool
    }

    @NSManaged @objc(lfCoreDataEntityGroupIdentifier) public var lfCoreDataEntityGroupIdentifier: String?

    @NSManaged public var id: String
    @NSManaged public var firstName: String
    @NSManaged public var age: NSNumber

    var plainModel: GrandChild?
    var plainCounter = 0
    public var isModelRecursive: Bool { return plainCounter > 5 }

    func toPlainModel(isRecursive: Bool = false) -> GrandChild {
        plainCounter.increment(); defer { plainCounter.decrement() }
        if var model = self.plainModel {
            model.id = self.id
        } else {
            let grandChild = GrandChild(
            id: self.id,
            firstName: self.firstName,
            age: self.age.intValue
        )
        self.plainModel = grandChild
      }
        return plainModel!
    }

    override public func awakeFromInsert() {
      super.awakeFromInsert()
      self.id = .empty
      self.firstName = .empty
      self.age = .empty
    }


    @discardableResult
    public func populate<T : Persistable>(groupID: String?, with plainModel: T, context: NSManagedObjectContext) -> Self {
        guard let plainModel = plainModel as? GrandChild else { return self }
        lfCoreDataEntityIsPopulated = NSNumber(booleanLiteral: true)
        lfCoreDataEntityGroupIdentifier = groupID
        id = plainModel.id 
        firstName = plainModel.firstName 
        age = plainModel.age as NSNumber
        return self
    }

    public static func managedKeyPathFrom<EntityType, VariableType>(_ plainKeyPath: KeyPath<EntityType, VariableType>) -> String {
        switch plainKeyPath {
            case \GrandChild.id: return "id"
            case \GrandChild.firstName: return "firstName"
            case \GrandChild.age: return "age"
            default: return ""
        }
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        do {
            let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "ManagedGrandChild")
            fetchRequest.returnsDistinctResults = true
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.propertiesToFetch = ["lfCoreDataEntityGroupIdentifier"]
            let result = try sourceContext.fetch(fetchRequest).flatMap { $0.allValues }.compactMap { $0 as? String }
            return result
        } catch {
            logError(error)
            return nil
        }
    }
}

extension GrandChild: Persistable, UniqueIDConstraintKeyPath {
    public static var idKeyPath: WritableKeyPath<GrandChild, ManagedGrandChild.EntityID> {
        return \GrandChild.id
    }

    public static func count(groupID: String? = nil, using predicate: NSPredicate = .true, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Int {
        return ManagedGrandChild.count(groupID: groupID, using: predicate, sourceContext: sourceContext)
    }

    public static func get(entityID: ManagedGrandChild.EntityID, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> GrandChild? {
        ManagedGrandChild.get(entityID: entityID, sourceContext: sourceContext)?.toPlainModel()
    }

    public static func get(groupID: String? = nil, using predicate: NSPredicate, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [GrandChild] {
        ManagedGrandChild.get(groupID: groupID, using: predicate, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func getAll(groupID: String? = nil, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [GrandChild] {
        ManagedGrandChild.getAll(groupID: groupID, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func create(groupID: String? = nil,
                              updateIfEntityExists: Bool,
                              updateClosure: @escaping (_ entity: inout GrandChild, _ context: NSManagedObjectContext) -> Void,
                              completeClosure: ((Result<GrandChild, PersistableError>) -> Void)?) {
                               ManagedGrandChild.create(groupID: groupID,
            updateIfEntityExists: updateIfEntityExists,
            updateClosure: { (entity, context) in
                var plainEntity: GrandChild = entity.toPlainModel()
                updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }, completeClosure: { result in
            switch result {
                case .success(let entity):
                    completeClosure?(.success(entity.toPlainModel()))

                case .failure(let error):
                    completeClosure?(.failure(error))
            }
        })
    }

    public static func createEntity(groupID: String? = nil, entityID: ManagedGrandChild.EntityID, context: NSManagedObjectContext) -> GrandChild? {
        ManagedGrandChild.createEntity(groupID: groupID, entityID: entityID, context: context)?.toPlainModel()
    }

    public static func createTemporary(groupID: String? = nil, updateClosure: @escaping (inout GrandChild, NSManagedObjectContext) -> Void) {
        ManagedGrandChild.createTemporary { (entity, context) in
            var plainEntity = entity.toPlainModel()
            updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }
    }

    public func createAndPopulate(groupID: String? = nil, updateIfEntityExists: Bool = true, insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<GrandChild, PersistableError>) -> Void)?) {
        ManagedGrandChild.createBatchAndPopulate(groupID: groupID, from: [self], insertionPolicy: insertionPolicy) { result in
            switch result {
            case .success(let response):
                guard let savedEntity = response.first else { completeClosure?(.failure(.failedToSaveEntityToStore)); return }
                completeClosure?(.success(savedEntity))
            case .failure(let error):
                completeClosure?(.failure(error))
            }
        }
    }

    public func update(updateClosure: @escaping (inout GrandChild, NSManagedObjectContext) -> Void, completeClosure: ((GrandChild) -> Void)?) {
        let managedEntity = ManagedGrandChild.get(entityID: self[keyPath: Self.idKeyPath])

        managedEntity?.update(updateClosure: { (entity, context) in
            var mutableSelf = self
            updateClosure(&mutableSelf, context)
            entity.populate(groupID: managedEntity?.lfCoreDataEntityGroupIdentifier, with: mutableSelf, context: context)

        }, completeClosure: { updatedEntity in
            completeClosure?(updatedEntity.toPlainModel())
        })
    }

    public func delete(sourceContext: NSManagedObjectContext = CoreDataStore.shared.newBackgroundContext, completeClosure: (() -> Void)?) {
        let managedEntity = ManagedGrandChild.get(entityID: self[keyPath: Self.idKeyPath], sourceContext: sourceContext)
        managedEntity?.delete(sourceContext: sourceContext, completeClosure: completeClosure)
    }

    public static func delete(with options: DeleteOptions = DeleteOptions(), completeClosure: (() -> Void)?) {
        ManagedGrandChild.delete(with: options, completeClosure: completeClosure)
    }

    public static func createBatchAndPopulate<PersistableType: Persistable & UniqueIDConstraintKeyPath>(groupID: String? = nil, from plainModels: [PersistableType], insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<[PersistableType], PersistableError>) -> Void)?) {
      ManagedGrandChild.createBatchAndPopulate(groupID: groupID, from: plainModels, insertionPolicy: insertionPolicy, completeClosure: completeClosure)
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        return ManagedGrandChild.getAllGroups(sourceContext: sourceContext)
    }
}

extension GrandchildRecursiveClass { static var managedModelName = "ManagedGrandchildRecursiveClass" }

@objc(ManagedGrandchildRecursiveClass)
final public class ManagedGrandchildRecursiveClass: PersistableManagedObject, KeyPathable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedGrandchildRecursiveClass> {
        return NSFetchRequest<ManagedGrandchildRecursiveClass>(entityName: "ManagedGrandchildRecursiveClass")
    }

    public static var idKeyPath: WritableKeyPath<ManagedGrandchildRecursiveClass, String> {
        return \ManagedGrandchildRecursiveClass.id
    }

    public static var groupIDKeyPath: WritableKeyPath<ManagedGrandchildRecursiveClass, String?> {
        return \ManagedGrandchildRecursiveClass.lfCoreDataEntityGroupIdentifier
    }

    @NSManaged @objc(lfCoreDataEntityIsPopulated) public var lfCoreDataEntityIsPopulated: NSNumber

    public var isPopulated: Bool {
        return lfCoreDataEntityIsPopulated as! Bool
    }

    @NSManaged @objc(lfCoreDataEntityGroupIdentifier) public var lfCoreDataEntityGroupIdentifier: String?

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var grandfather: ManagedParentRecursiveClass?

    var plainModel: GrandchildRecursiveClass?
    var plainCounter = 0
    public var isModelRecursive: Bool { return plainCounter > 5 }

    func toPlainModel(isRecursive: Bool = false) -> GrandchildRecursiveClass {
        plainCounter.increment(); defer { plainCounter.decrement() }
        if let model = self.plainModel {
            model.id = self.id
            if !isRecursive { model.grandfather = isRecursive ? nil : self.grandfather?.toPlainModel(isRecursive: grandfather?.isModelRecursive ?? false)}
        } else {
            let grandchildRecursiveClass = GrandchildRecursiveClass(
            id: self.id,
            name: self.name,
            grandfather: isRecursive ? nil : self.grandfather?.toPlainModel(isRecursive: grandfather?.isModelRecursive ?? false)
        )
        self.plainModel = grandchildRecursiveClass
      }
        return plainModel!
    }

    override public func awakeFromInsert() {
      super.awakeFromInsert()
      self.id = .empty
      self.name = .empty
    }


    @discardableResult
    public func populate<T : Persistable>(groupID: String?, with plainModel: T, context: NSManagedObjectContext) -> Self {
        guard let plainModel = plainModel as? GrandchildRecursiveClass else { return self }
        lfCoreDataEntityIsPopulated = NSNumber(booleanLiteral: true)
        lfCoreDataEntityGroupIdentifier = groupID
        id = plainModel.id 
        name = plainModel.name 
        if let grandfather = plainModel.grandfather {
            if let managedGrandfather = ManagedParentRecursiveClass.get(entityID: grandfather.uniqueIdValue, sourceContext: context) {
                self.grandfather = managedGrandfather
                return self
            }
        if let managedRelationship = ManagedParentRecursiveClass
                .createEntity(entityID: grandfather.uniqueIdValue, context: context)?
                .populate(groupID: groupID, with: grandfather, context: context) {
                  self.grandfather = managedRelationship
        }
        }
        return self
    }

    public static func managedKeyPathFrom<EntityType, VariableType>(_ plainKeyPath: KeyPath<EntityType, VariableType>) -> String {
        switch plainKeyPath {
            case \GrandchildRecursiveClass.id: return "id"
            case \GrandchildRecursiveClass.name: return "name"
            default: return ""
        }
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        do {
            let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "ManagedGrandchildRecursiveClass")
            fetchRequest.returnsDistinctResults = true
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.propertiesToFetch = ["lfCoreDataEntityGroupIdentifier"]
            let result = try sourceContext.fetch(fetchRequest).flatMap { $0.allValues }.compactMap { $0 as? String }
            return result
        } catch {
            logError(error)
            return nil
        }
    }
}

extension GrandchildRecursiveClass: Persistable, UniqueIDConstraintKeyPath {
    public static var idKeyPath: WritableKeyPath<GrandchildRecursiveClass, ManagedGrandchildRecursiveClass.EntityID> {
        return \GrandchildRecursiveClass.id
    }

    public static func count(groupID: String? = nil, using predicate: NSPredicate = .true, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Int {
        return ManagedGrandchildRecursiveClass.count(groupID: groupID, using: predicate, sourceContext: sourceContext)
    }

    public static func get(entityID: ManagedGrandchildRecursiveClass.EntityID, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> GrandchildRecursiveClass? {
        ManagedGrandchildRecursiveClass.get(entityID: entityID, sourceContext: sourceContext)?.toPlainModel()
    }

    public static func get(groupID: String? = nil, using predicate: NSPredicate, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [GrandchildRecursiveClass] {
        ManagedGrandchildRecursiveClass.get(groupID: groupID, using: predicate, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func getAll(groupID: String? = nil, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [GrandchildRecursiveClass] {
        ManagedGrandchildRecursiveClass.getAll(groupID: groupID, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func create(groupID: String? = nil,
                              updateIfEntityExists: Bool,
                              updateClosure: @escaping (_ entity: inout GrandchildRecursiveClass, _ context: NSManagedObjectContext) -> Void,
                              completeClosure: ((Result<GrandchildRecursiveClass, PersistableError>) -> Void)?) {
                               ManagedGrandchildRecursiveClass.create(groupID: groupID,
            updateIfEntityExists: updateIfEntityExists,
            updateClosure: { (entity, context) in
                var plainEntity: GrandchildRecursiveClass = entity.toPlainModel()
                updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }, completeClosure: { result in
            switch result {
                case .success(let entity):
                    completeClosure?(.success(entity.toPlainModel()))

                case .failure(let error):
                    completeClosure?(.failure(error))
            }
        })
    }

    public static func createEntity(groupID: String? = nil, entityID: ManagedGrandchildRecursiveClass.EntityID, context: NSManagedObjectContext) -> GrandchildRecursiveClass? {
        ManagedGrandchildRecursiveClass.createEntity(groupID: groupID, entityID: entityID, context: context)?.toPlainModel()
    }

    public static func createTemporary(groupID: String? = nil, updateClosure: @escaping (inout GrandchildRecursiveClass, NSManagedObjectContext) -> Void) {
        ManagedGrandchildRecursiveClass.createTemporary { (entity, context) in
            var plainEntity = entity.toPlainModel()
            updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }
    }

    public func createAndPopulate(groupID: String? = nil, updateIfEntityExists: Bool = true, insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<GrandchildRecursiveClass, PersistableError>) -> Void)?) {
        ManagedGrandchildRecursiveClass.createBatchAndPopulate(groupID: groupID, from: [self], insertionPolicy: insertionPolicy) { result in
            switch result {
            case .success(let response):
                guard let savedEntity = response.first else { completeClosure?(.failure(.failedToSaveEntityToStore)); return }
                completeClosure?(.success(savedEntity))
            case .failure(let error):
                completeClosure?(.failure(error))
            }
        }
    }

    public func update(updateClosure: @escaping (inout GrandchildRecursiveClass, NSManagedObjectContext) -> Void, completeClosure: ((GrandchildRecursiveClass) -> Void)?) {
        let managedEntity = ManagedGrandchildRecursiveClass.get(entityID: self[keyPath: Self.idKeyPath])

        managedEntity?.update(updateClosure: { (entity, context) in
            var mutableSelf = self
            updateClosure(&mutableSelf, context)
            entity.populate(groupID: managedEntity?.lfCoreDataEntityGroupIdentifier, with: mutableSelf, context: context)

        }, completeClosure: { updatedEntity in
            completeClosure?(updatedEntity.toPlainModel())
        })
    }

    public func delete(sourceContext: NSManagedObjectContext = CoreDataStore.shared.newBackgroundContext, completeClosure: (() -> Void)?) {
        let managedEntity = ManagedGrandchildRecursiveClass.get(entityID: self[keyPath: Self.idKeyPath], sourceContext: sourceContext)
        managedEntity?.delete(sourceContext: sourceContext, completeClosure: completeClosure)
    }

    public static func delete(with options: DeleteOptions = DeleteOptions(), completeClosure: (() -> Void)?) {
        ManagedGrandchildRecursiveClass.delete(with: options, completeClosure: completeClosure)
    }

    public static func createBatchAndPopulate<PersistableType: Persistable & UniqueIDConstraintKeyPath>(groupID: String? = nil, from plainModels: [PersistableType], insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<[PersistableType], PersistableError>) -> Void)?) {
      ManagedGrandchildRecursiveClass.createBatchAndPopulate(groupID: groupID, from: plainModels, insertionPolicy: insertionPolicy, completeClosure: completeClosure)
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        return ManagedGrandchildRecursiveClass.getAllGroups(sourceContext: sourceContext)
    }
}

extension GroupStruct { static var managedModelName = "ManagedGroupStruct" }

@objc(ManagedGroupStruct)
final public class ManagedGroupStruct: PersistableManagedObject, KeyPathable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedGroupStruct> {
        return NSFetchRequest<ManagedGroupStruct>(entityName: "ManagedGroupStruct")
    }

    public static var idKeyPath: WritableKeyPath<ManagedGroupStruct, String> {
        return \ManagedGroupStruct.id
    }

    public static var groupIDKeyPath: WritableKeyPath<ManagedGroupStruct, String?> {
        return \ManagedGroupStruct.lfCoreDataEntityGroupIdentifier
    }

    @NSManaged @objc(lfCoreDataEntityIsPopulated) public var lfCoreDataEntityIsPopulated: NSNumber

    public var isPopulated: Bool {
        return lfCoreDataEntityIsPopulated as! Bool
    }

    @NSManaged @objc(lfCoreDataEntityGroupIdentifier) public var lfCoreDataEntityGroupIdentifier: String?

    @NSManaged public var id: String
    @NSManaged public var group: String

    var plainModel: GroupStruct?
    var plainCounter = 0
    public var isModelRecursive: Bool { return plainCounter > 5 }

    func toPlainModel(isRecursive: Bool = false) -> GroupStruct {
        plainCounter.increment(); defer { plainCounter.decrement() }
        if var model = self.plainModel {
            model.id = self.id
        } else {
            let groupStruct = GroupStruct(
            id: self.id,
            group: self.group
        )
        self.plainModel = groupStruct
      }
        return plainModel!
    }

    override public func awakeFromInsert() {
      super.awakeFromInsert()
      self.id = .empty
      self.group = .empty
    }


    @discardableResult
    public func populate<T : Persistable>(groupID: String?, with plainModel: T, context: NSManagedObjectContext) -> Self {
        guard let plainModel = plainModel as? GroupStruct else { return self }
        lfCoreDataEntityIsPopulated = NSNumber(booleanLiteral: true)
        lfCoreDataEntityGroupIdentifier = groupID
        id = plainModel.id 
        group = plainModel.group 
        return self
    }

    public static func managedKeyPathFrom<EntityType, VariableType>(_ plainKeyPath: KeyPath<EntityType, VariableType>) -> String {
        switch plainKeyPath {
            case \GroupStruct.id: return "id"
            case \GroupStruct.group: return "group"
            default: return ""
        }
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        do {
            let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "ManagedGroupStruct")
            fetchRequest.returnsDistinctResults = true
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.propertiesToFetch = ["lfCoreDataEntityGroupIdentifier"]
            let result = try sourceContext.fetch(fetchRequest).flatMap { $0.allValues }.compactMap { $0 as? String }
            return result
        } catch {
            logError(error)
            return nil
        }
    }
}

extension GroupStruct: Persistable, UniqueIDConstraintKeyPath {
    public static var idKeyPath: WritableKeyPath<GroupStruct, ManagedGroupStruct.EntityID> {
        return \GroupStruct.id
    }

    public static func count(groupID: String? = nil, using predicate: NSPredicate = .true, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Int {
        return ManagedGroupStruct.count(groupID: groupID, using: predicate, sourceContext: sourceContext)
    }

    public static func get(entityID: ManagedGroupStruct.EntityID, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> GroupStruct? {
        ManagedGroupStruct.get(entityID: entityID, sourceContext: sourceContext)?.toPlainModel()
    }

    public static func get(groupID: String? = nil, using predicate: NSPredicate, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [GroupStruct] {
        ManagedGroupStruct.get(groupID: groupID, using: predicate, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func getAll(groupID: String? = nil, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [GroupStruct] {
        ManagedGroupStruct.getAll(groupID: groupID, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func create(groupID: String? = nil,
                              updateIfEntityExists: Bool,
                              updateClosure: @escaping (_ entity: inout GroupStruct, _ context: NSManagedObjectContext) -> Void,
                              completeClosure: ((Result<GroupStruct, PersistableError>) -> Void)?) {
                               ManagedGroupStruct.create(groupID: groupID,
            updateIfEntityExists: updateIfEntityExists,
            updateClosure: { (entity, context) in
                var plainEntity: GroupStruct = entity.toPlainModel()
                updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }, completeClosure: { result in
            switch result {
                case .success(let entity):
                    completeClosure?(.success(entity.toPlainModel()))

                case .failure(let error):
                    completeClosure?(.failure(error))
            }
        })
    }

    public static func createEntity(groupID: String? = nil, entityID: ManagedGroupStruct.EntityID, context: NSManagedObjectContext) -> GroupStruct? {
        ManagedGroupStruct.createEntity(groupID: groupID, entityID: entityID, context: context)?.toPlainModel()
    }

    public static func createTemporary(groupID: String? = nil, updateClosure: @escaping (inout GroupStruct, NSManagedObjectContext) -> Void) {
        ManagedGroupStruct.createTemporary { (entity, context) in
            var plainEntity = entity.toPlainModel()
            updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }
    }

    public func createAndPopulate(groupID: String? = nil, updateIfEntityExists: Bool = true, insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<GroupStruct, PersistableError>) -> Void)?) {
        ManagedGroupStruct.createBatchAndPopulate(groupID: groupID, from: [self], insertionPolicy: insertionPolicy) { result in
            switch result {
            case .success(let response):
                guard let savedEntity = response.first else { completeClosure?(.failure(.failedToSaveEntityToStore)); return }
                completeClosure?(.success(savedEntity))
            case .failure(let error):
                completeClosure?(.failure(error))
            }
        }
    }

    public func update(updateClosure: @escaping (inout GroupStruct, NSManagedObjectContext) -> Void, completeClosure: ((GroupStruct) -> Void)?) {
        let managedEntity = ManagedGroupStruct.get(entityID: self[keyPath: Self.idKeyPath])

        managedEntity?.update(updateClosure: { (entity, context) in
            var mutableSelf = self
            updateClosure(&mutableSelf, context)
            entity.populate(groupID: managedEntity?.lfCoreDataEntityGroupIdentifier, with: mutableSelf, context: context)

        }, completeClosure: { updatedEntity in
            completeClosure?(updatedEntity.toPlainModel())
        })
    }

    public func delete(sourceContext: NSManagedObjectContext = CoreDataStore.shared.newBackgroundContext, completeClosure: (() -> Void)?) {
        let managedEntity = ManagedGroupStruct.get(entityID: self[keyPath: Self.idKeyPath], sourceContext: sourceContext)
        managedEntity?.delete(sourceContext: sourceContext, completeClosure: completeClosure)
    }

    public static func delete(with options: DeleteOptions = DeleteOptions(), completeClosure: (() -> Void)?) {
        ManagedGroupStruct.delete(with: options, completeClosure: completeClosure)
    }

    public static func createBatchAndPopulate<PersistableType: Persistable & UniqueIDConstraintKeyPath>(groupID: String? = nil, from plainModels: [PersistableType], insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<[PersistableType], PersistableError>) -> Void)?) {
      ManagedGroupStruct.createBatchAndPopulate(groupID: groupID, from: plainModels, insertionPolicy: insertionPolicy, completeClosure: completeClosure)
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        return ManagedGroupStruct.getAllGroups(sourceContext: sourceContext)
    }
}

extension MainEntity { static var managedModelName = "ManagedMainEntity" }

@objc(ManagedMainEntity)
final public class ManagedMainEntity: PersistableManagedObject, KeyPathable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedMainEntity> {
        return NSFetchRequest<ManagedMainEntity>(entityName: "ManagedMainEntity")
    }

    public static var idKeyPath: WritableKeyPath<ManagedMainEntity, String> {
        return \ManagedMainEntity.id
    }

    public static var groupIDKeyPath: WritableKeyPath<ManagedMainEntity, String?> {
        return \ManagedMainEntity.lfCoreDataEntityGroupIdentifier
    }

    @NSManaged @objc(lfCoreDataEntityIsPopulated) public var lfCoreDataEntityIsPopulated: NSNumber

    public var isPopulated: Bool {
        return lfCoreDataEntityIsPopulated as! Bool
    }

    @NSManaged @objc(lfCoreDataEntityGroupIdentifier) public var lfCoreDataEntityGroupIdentifier: String?

    @NSManaged public var id: String
    @NSManaged public var details: String
    @NSManaged public var nestedField: ManagedNestedEntity

    var plainModel: MainEntity?
    var plainCounter = 0
    public var isModelRecursive: Bool { return plainCounter > 5 }

    func toPlainModel(isRecursive: Bool = false) -> MainEntity {
        plainCounter.increment(); defer { plainCounter.decrement() }
        if var model = self.plainModel {
            model.id = self.id
            model.details = self.details
            model.nestedField = self.nestedField.toPlainModel(isRecursive:isRecursive)
        } else {
            let mainEntity = MainEntity(
            id: self.id,
            details: self.details,
            nestedField: self.nestedField.toPlainModel(isRecursive:isRecursive)
        )
        self.plainModel = mainEntity
      }
        return plainModel!
    }

    override public func awakeFromInsert() {
      super.awakeFromInsert()
      self.id = .empty
      self.details = .empty
    }


    @discardableResult
    public func populate<T : Persistable>(groupID: String?, with plainModel: T, context: NSManagedObjectContext) -> Self {
        guard let plainModel = plainModel as? MainEntity else { return self }
        lfCoreDataEntityIsPopulated = NSNumber(booleanLiteral: true)
        lfCoreDataEntityGroupIdentifier = groupID
        id = plainModel.id 
        details = plainModel.details 
        let nestedField = plainModel.nestedField
        if let managedRelationship = ManagedNestedEntity
                .createEntity(entityID: nestedField.uniqueIdValue, context: context)?
                .populate(groupID: groupID, with: nestedField, context: context) {
                  self.nestedField = managedRelationship
        }
        return self
    }

    public static func managedKeyPathFrom<EntityType, VariableType>(_ plainKeyPath: KeyPath<EntityType, VariableType>) -> String {
        switch plainKeyPath {
            case \MainEntity.id: return "id"
            case \MainEntity.details: return "details"
            case \MainEntity.nestedField.id: return "nestedField.id"
            case \MainEntity.nestedField.info: return "nestedField.info"
            default: return ""
        }
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        do {
            let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "ManagedMainEntity")
            fetchRequest.returnsDistinctResults = true
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.propertiesToFetch = ["lfCoreDataEntityGroupIdentifier"]
            let result = try sourceContext.fetch(fetchRequest).flatMap { $0.allValues }.compactMap { $0 as? String }
            return result
        } catch {
            logError(error)
            return nil
        }
    }
}

extension MainEntity: Persistable, UniqueIDConstraintKeyPath {
    public static var idKeyPath: WritableKeyPath<MainEntity, ManagedMainEntity.EntityID> {
        return \MainEntity.id
    }

    public static func count(groupID: String? = nil, using predicate: NSPredicate = .true, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Int {
        return ManagedMainEntity.count(groupID: groupID, using: predicate, sourceContext: sourceContext)
    }

    public static func get(entityID: ManagedMainEntity.EntityID, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> MainEntity? {
        ManagedMainEntity.get(entityID: entityID, sourceContext: sourceContext)?.toPlainModel()
    }

    public static func get(groupID: String? = nil, using predicate: NSPredicate, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [MainEntity] {
        ManagedMainEntity.get(groupID: groupID, using: predicate, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func getAll(groupID: String? = nil, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [MainEntity] {
        ManagedMainEntity.getAll(groupID: groupID, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func create(groupID: String? = nil,
                              updateIfEntityExists: Bool,
                              updateClosure: @escaping (_ entity: inout MainEntity, _ context: NSManagedObjectContext) -> Void,
                              completeClosure: ((Result<MainEntity, PersistableError>) -> Void)?) {
                               ManagedMainEntity.create(groupID: groupID,
            updateIfEntityExists: updateIfEntityExists,
            updateClosure: { (entity, context) in
                var plainEntity: MainEntity = entity.toPlainModel()
                updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }, completeClosure: { result in
            switch result {
                case .success(let entity):
                    completeClosure?(.success(entity.toPlainModel()))

                case .failure(let error):
                    completeClosure?(.failure(error))
            }
        })
    }

    public static func createEntity(groupID: String? = nil, entityID: ManagedMainEntity.EntityID, context: NSManagedObjectContext) -> MainEntity? {
        ManagedMainEntity.createEntity(groupID: groupID, entityID: entityID, context: context)?.toPlainModel()
    }

    public static func createTemporary(groupID: String? = nil, updateClosure: @escaping (inout MainEntity, NSManagedObjectContext) -> Void) {
        ManagedMainEntity.createTemporary { (entity, context) in
            var plainEntity = entity.toPlainModel()
            updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }
    }

    public func createAndPopulate(groupID: String? = nil, updateIfEntityExists: Bool = true, insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<MainEntity, PersistableError>) -> Void)?) {
        ManagedMainEntity.createBatchAndPopulate(groupID: groupID, from: [self], insertionPolicy: insertionPolicy) { result in
            switch result {
            case .success(let response):
                guard let savedEntity = response.first else { completeClosure?(.failure(.failedToSaveEntityToStore)); return }
                completeClosure?(.success(savedEntity))
            case .failure(let error):
                completeClosure?(.failure(error))
            }
        }
    }

    public func update(updateClosure: @escaping (inout MainEntity, NSManagedObjectContext) -> Void, completeClosure: ((MainEntity) -> Void)?) {
        let managedEntity = ManagedMainEntity.get(entityID: self[keyPath: Self.idKeyPath])

        managedEntity?.update(updateClosure: { (entity, context) in
            var mutableSelf = self
            updateClosure(&mutableSelf, context)
            entity.populate(groupID: managedEntity?.lfCoreDataEntityGroupIdentifier, with: mutableSelf, context: context)

        }, completeClosure: { updatedEntity in
            completeClosure?(updatedEntity.toPlainModel())
        })
    }

    public func delete(sourceContext: NSManagedObjectContext = CoreDataStore.shared.newBackgroundContext, completeClosure: (() -> Void)?) {
        let managedEntity = ManagedMainEntity.get(entityID: self[keyPath: Self.idKeyPath], sourceContext: sourceContext)
        managedEntity?.delete(sourceContext: sourceContext, completeClosure: completeClosure)
    }

    public static func delete(with options: DeleteOptions = DeleteOptions(), completeClosure: (() -> Void)?) {
        ManagedMainEntity.delete(with: options, completeClosure: completeClosure)
    }

    public static func createBatchAndPopulate<PersistableType: Persistable & UniqueIDConstraintKeyPath>(groupID: String? = nil, from plainModels: [PersistableType], insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<[PersistableType], PersistableError>) -> Void)?) {
      ManagedMainEntity.createBatchAndPopulate(groupID: groupID, from: plainModels, insertionPolicy: insertionPolicy, completeClosure: completeClosure)
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        return ManagedMainEntity.getAllGroups(sourceContext: sourceContext)
    }
}

extension Migration { static var managedModelName = "ManagedMigration" }

@objc(ManagedMigration)
final public class ManagedMigration: PersistableManagedObject, KeyPathable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedMigration> {
        return NSFetchRequest<ManagedMigration>(entityName: "ManagedMigration")
    }

    public static var idKeyPath: WritableKeyPath<ManagedMigration, String> {
        return \ManagedMigration.id
    }

    public static var groupIDKeyPath: WritableKeyPath<ManagedMigration, String?> {
        return \ManagedMigration.lfCoreDataEntityGroupIdentifier
    }

    @NSManaged @objc(lfCoreDataEntityIsPopulated) public var lfCoreDataEntityIsPopulated: NSNumber

    public var isPopulated: Bool {
        return lfCoreDataEntityIsPopulated as! Bool
    }

    @NSManaged @objc(lfCoreDataEntityGroupIdentifier) public var lfCoreDataEntityGroupIdentifier: String?

    @NSManaged public var id: String

    var plainModel: Migration?
    var plainCounter = 0
    public var isModelRecursive: Bool { return plainCounter > 5 }

    func toPlainModel(isRecursive: Bool = false) -> Migration {
        plainCounter.increment(); defer { plainCounter.decrement() }
        if var model = self.plainModel {
            model.id = self.id
        } else {
            let migration = Migration(
            id: self.id
        )
        self.plainModel = migration
      }
        return plainModel!
    }

    override public func awakeFromInsert() {
      super.awakeFromInsert()
      self.id = .empty
    }


    @discardableResult
    public func populate<T : Persistable>(groupID: String?, with plainModel: T, context: NSManagedObjectContext) -> Self {
        guard let plainModel = plainModel as? Migration else { return self }
        lfCoreDataEntityIsPopulated = NSNumber(booleanLiteral: true)
        lfCoreDataEntityGroupIdentifier = groupID
        id = plainModel.id 
        return self
    }

    public static func managedKeyPathFrom<EntityType, VariableType>(_ plainKeyPath: KeyPath<EntityType, VariableType>) -> String {
        switch plainKeyPath {
            case \Migration.id: return "id"
            default: return ""
        }
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        do {
            let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "ManagedMigration")
            fetchRequest.returnsDistinctResults = true
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.propertiesToFetch = ["lfCoreDataEntityGroupIdentifier"]
            let result = try sourceContext.fetch(fetchRequest).flatMap { $0.allValues }.compactMap { $0 as? String }
            return result
        } catch {
            logError(error)
            return nil
        }
    }
}

extension Migration: Persistable, UniqueIDConstraintKeyPath {
    public static var idKeyPath: WritableKeyPath<Migration, ManagedMigration.EntityID> {
        return \Migration.id
    }

    public static func count(groupID: String? = nil, using predicate: NSPredicate = .true, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Int {
        return ManagedMigration.count(groupID: groupID, using: predicate, sourceContext: sourceContext)
    }

    public static func get(entityID: ManagedMigration.EntityID, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Migration? {
        ManagedMigration.get(entityID: entityID, sourceContext: sourceContext)?.toPlainModel()
    }

    public static func get(groupID: String? = nil, using predicate: NSPredicate, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [Migration] {
        ManagedMigration.get(groupID: groupID, using: predicate, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func getAll(groupID: String? = nil, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [Migration] {
        ManagedMigration.getAll(groupID: groupID, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func create(groupID: String? = nil,
                              updateIfEntityExists: Bool,
                              updateClosure: @escaping (_ entity: inout Migration, _ context: NSManagedObjectContext) -> Void,
                              completeClosure: ((Result<Migration, PersistableError>) -> Void)?) {
                               ManagedMigration.create(groupID: groupID,
            updateIfEntityExists: updateIfEntityExists,
            updateClosure: { (entity, context) in
                var plainEntity: Migration = entity.toPlainModel()
                updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }, completeClosure: { result in
            switch result {
                case .success(let entity):
                    completeClosure?(.success(entity.toPlainModel()))

                case .failure(let error):
                    completeClosure?(.failure(error))
            }
        })
    }

    public static func createEntity(groupID: String? = nil, entityID: ManagedMigration.EntityID, context: NSManagedObjectContext) -> Migration? {
        ManagedMigration.createEntity(groupID: groupID, entityID: entityID, context: context)?.toPlainModel()
    }

    public static func createTemporary(groupID: String? = nil, updateClosure: @escaping (inout Migration, NSManagedObjectContext) -> Void) {
        ManagedMigration.createTemporary { (entity, context) in
            var plainEntity = entity.toPlainModel()
            updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }
    }

    public func createAndPopulate(groupID: String? = nil, updateIfEntityExists: Bool = true, insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<Migration, PersistableError>) -> Void)?) {
        ManagedMigration.createBatchAndPopulate(groupID: groupID, from: [self], insertionPolicy: insertionPolicy) { result in
            switch result {
            case .success(let response):
                guard let savedEntity = response.first else { completeClosure?(.failure(.failedToSaveEntityToStore)); return }
                completeClosure?(.success(savedEntity))
            case .failure(let error):
                completeClosure?(.failure(error))
            }
        }
    }

    public func update(updateClosure: @escaping (inout Migration, NSManagedObjectContext) -> Void, completeClosure: ((Migration) -> Void)?) {
        let managedEntity = ManagedMigration.get(entityID: self[keyPath: Self.idKeyPath])

        managedEntity?.update(updateClosure: { (entity, context) in
            var mutableSelf = self
            updateClosure(&mutableSelf, context)
            entity.populate(groupID: managedEntity?.lfCoreDataEntityGroupIdentifier, with: mutableSelf, context: context)

        }, completeClosure: { updatedEntity in
            completeClosure?(updatedEntity.toPlainModel())
        })
    }

    public func delete(sourceContext: NSManagedObjectContext = CoreDataStore.shared.newBackgroundContext, completeClosure: (() -> Void)?) {
        let managedEntity = ManagedMigration.get(entityID: self[keyPath: Self.idKeyPath], sourceContext: sourceContext)
        managedEntity?.delete(sourceContext: sourceContext, completeClosure: completeClosure)
    }

    public static func delete(with options: DeleteOptions = DeleteOptions(), completeClosure: (() -> Void)?) {
        ManagedMigration.delete(with: options, completeClosure: completeClosure)
    }

    public static func createBatchAndPopulate<PersistableType: Persistable & UniqueIDConstraintKeyPath>(groupID: String? = nil, from plainModels: [PersistableType], insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<[PersistableType], PersistableError>) -> Void)?) {
      ManagedMigration.createBatchAndPopulate(groupID: groupID, from: plainModels, insertionPolicy: insertionPolicy, completeClosure: completeClosure)
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        return ManagedMigration.getAllGroups(sourceContext: sourceContext)
    }
}

extension NestedEntity { static var managedModelName = "ManagedNestedEntity" }

@objc(ManagedNestedEntity)
final public class ManagedNestedEntity: PersistableManagedObject, KeyPathable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedNestedEntity> {
        return NSFetchRequest<ManagedNestedEntity>(entityName: "ManagedNestedEntity")
    }

    public static var idKeyPath: WritableKeyPath<ManagedNestedEntity, String> {
        return \ManagedNestedEntity.id
    }

    public static var groupIDKeyPath: WritableKeyPath<ManagedNestedEntity, String?> {
        return \ManagedNestedEntity.lfCoreDataEntityGroupIdentifier
    }

    @NSManaged @objc(lfCoreDataEntityIsPopulated) public var lfCoreDataEntityIsPopulated: NSNumber

    public var isPopulated: Bool {
        return lfCoreDataEntityIsPopulated as! Bool
    }

    @NSManaged @objc(lfCoreDataEntityGroupIdentifier) public var lfCoreDataEntityGroupIdentifier: String?

    @NSManaged public var id: String
    @NSManaged public var info: String

    var plainModel: NestedEntity?
    var plainCounter = 0
    public var isModelRecursive: Bool { return plainCounter > 5 }

    func toPlainModel(isRecursive: Bool = false) -> NestedEntity {
        plainCounter.increment(); defer { plainCounter.decrement() }
        if var model = self.plainModel {
            model.id = self.id
            model.info = self.info
        } else {
            let nestedEntity = NestedEntity(
            id: self.id,
            info: self.info
        )
        self.plainModel = nestedEntity
      }
        return plainModel!
    }

    override public func awakeFromInsert() {
      super.awakeFromInsert()
      self.id = .empty
      self.info = .empty
    }


    @discardableResult
    public func populate<T : Persistable>(groupID: String?, with plainModel: T, context: NSManagedObjectContext) -> Self {
        guard let plainModel = plainModel as? NestedEntity else { return self }
        lfCoreDataEntityIsPopulated = NSNumber(booleanLiteral: true)
        lfCoreDataEntityGroupIdentifier = groupID
        id = plainModel.id 
        info = plainModel.info 
        return self
    }

    public static func managedKeyPathFrom<EntityType, VariableType>(_ plainKeyPath: KeyPath<EntityType, VariableType>) -> String {
        switch plainKeyPath {
            case \NestedEntity.id: return "id"
            case \NestedEntity.info: return "info"
            default: return ""
        }
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        do {
            let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "ManagedNestedEntity")
            fetchRequest.returnsDistinctResults = true
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.propertiesToFetch = ["lfCoreDataEntityGroupIdentifier"]
            let result = try sourceContext.fetch(fetchRequest).flatMap { $0.allValues }.compactMap { $0 as? String }
            return result
        } catch {
            logError(error)
            return nil
        }
    }
}

extension NestedEntity: Persistable, UniqueIDConstraintKeyPath {
    public static var idKeyPath: WritableKeyPath<NestedEntity, ManagedNestedEntity.EntityID> {
        return \NestedEntity.id
    }

    public static func count(groupID: String? = nil, using predicate: NSPredicate = .true, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Int {
        return ManagedNestedEntity.count(groupID: groupID, using: predicate, sourceContext: sourceContext)
    }

    public static func get(entityID: ManagedNestedEntity.EntityID, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> NestedEntity? {
        ManagedNestedEntity.get(entityID: entityID, sourceContext: sourceContext)?.toPlainModel()
    }

    public static func get(groupID: String? = nil, using predicate: NSPredicate, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [NestedEntity] {
        ManagedNestedEntity.get(groupID: groupID, using: predicate, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func getAll(groupID: String? = nil, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [NestedEntity] {
        ManagedNestedEntity.getAll(groupID: groupID, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func create(groupID: String? = nil,
                              updateIfEntityExists: Bool,
                              updateClosure: @escaping (_ entity: inout NestedEntity, _ context: NSManagedObjectContext) -> Void,
                              completeClosure: ((Result<NestedEntity, PersistableError>) -> Void)?) {
                               ManagedNestedEntity.create(groupID: groupID,
            updateIfEntityExists: updateIfEntityExists,
            updateClosure: { (entity, context) in
                var plainEntity: NestedEntity = entity.toPlainModel()
                updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }, completeClosure: { result in
            switch result {
                case .success(let entity):
                    completeClosure?(.success(entity.toPlainModel()))

                case .failure(let error):
                    completeClosure?(.failure(error))
            }
        })
    }

    public static func createEntity(groupID: String? = nil, entityID: ManagedNestedEntity.EntityID, context: NSManagedObjectContext) -> NestedEntity? {
        ManagedNestedEntity.createEntity(groupID: groupID, entityID: entityID, context: context)?.toPlainModel()
    }

    public static func createTemporary(groupID: String? = nil, updateClosure: @escaping (inout NestedEntity, NSManagedObjectContext) -> Void) {
        ManagedNestedEntity.createTemporary { (entity, context) in
            var plainEntity = entity.toPlainModel()
            updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }
    }

    public func createAndPopulate(groupID: String? = nil, updateIfEntityExists: Bool = true, insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<NestedEntity, PersistableError>) -> Void)?) {
        ManagedNestedEntity.createBatchAndPopulate(groupID: groupID, from: [self], insertionPolicy: insertionPolicy) { result in
            switch result {
            case .success(let response):
                guard let savedEntity = response.first else { completeClosure?(.failure(.failedToSaveEntityToStore)); return }
                completeClosure?(.success(savedEntity))
            case .failure(let error):
                completeClosure?(.failure(error))
            }
        }
    }

    public func update(updateClosure: @escaping (inout NestedEntity, NSManagedObjectContext) -> Void, completeClosure: ((NestedEntity) -> Void)?) {
        let managedEntity = ManagedNestedEntity.get(entityID: self[keyPath: Self.idKeyPath])

        managedEntity?.update(updateClosure: { (entity, context) in
            var mutableSelf = self
            updateClosure(&mutableSelf, context)
            entity.populate(groupID: managedEntity?.lfCoreDataEntityGroupIdentifier, with: mutableSelf, context: context)

        }, completeClosure: { updatedEntity in
            completeClosure?(updatedEntity.toPlainModel())
        })
    }

    public func delete(sourceContext: NSManagedObjectContext = CoreDataStore.shared.newBackgroundContext, completeClosure: (() -> Void)?) {
        let managedEntity = ManagedNestedEntity.get(entityID: self[keyPath: Self.idKeyPath], sourceContext: sourceContext)
        managedEntity?.delete(sourceContext: sourceContext, completeClosure: completeClosure)
    }

    public static func delete(with options: DeleteOptions = DeleteOptions(), completeClosure: (() -> Void)?) {
        ManagedNestedEntity.delete(with: options, completeClosure: completeClosure)
    }

    public static func createBatchAndPopulate<PersistableType: Persistable & UniqueIDConstraintKeyPath>(groupID: String? = nil, from plainModels: [PersistableType], insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<[PersistableType], PersistableError>) -> Void)?) {
      ManagedNestedEntity.createBatchAndPopulate(groupID: groupID, from: plainModels, insertionPolicy: insertionPolicy, completeClosure: completeClosure)
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        return ManagedNestedEntity.getAllGroups(sourceContext: sourceContext)
    }
}

extension ParentNestedClass { static var managedModelName = "ManagedParentNestedClass" }

@objc(ManagedParentNestedClass)
final public class ManagedParentNestedClass: PersistableManagedObject, KeyPathable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedParentNestedClass> {
        return NSFetchRequest<ManagedParentNestedClass>(entityName: "ManagedParentNestedClass")
    }

    public static var idKeyPath: WritableKeyPath<ManagedParentNestedClass, String> {
        return \ManagedParentNestedClass.id
    }

    public static var groupIDKeyPath: WritableKeyPath<ManagedParentNestedClass, String?> {
        return \ManagedParentNestedClass.lfCoreDataEntityGroupIdentifier
    }

    @NSManaged @objc(lfCoreDataEntityIsPopulated) public var lfCoreDataEntityIsPopulated: NSNumber

    public var isPopulated: Bool {
        return lfCoreDataEntityIsPopulated as! Bool
    }

    @NSManaged @objc(lfCoreDataEntityGroupIdentifier) public var lfCoreDataEntityGroupIdentifier: String?

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var child: ManagedChildNestedClass?

    var plainModel: ParentNestedClass?
    var plainCounter = 0
    public var isModelRecursive: Bool { return plainCounter > 5 }

    func toPlainModel(isRecursive: Bool = false) -> ParentNestedClass {
        plainCounter.increment(); defer { plainCounter.decrement() }
        if let model = self.plainModel {
            model.id = self.id
            model.child = self.child?.toPlainModel(isRecursive: child?.isModelRecursive ?? false)
        } else {
            let parentNestedClass = ParentNestedClass(
            id: self.id,
            name: self.name,
            child: self.child?.toPlainModel(isRecursive: child?.isModelRecursive ?? false)
        )
        self.plainModel = parentNestedClass
      }
        return plainModel!
    }

    override public func awakeFromInsert() {
      super.awakeFromInsert()
      self.id = .empty
      self.name = .empty
    }


    @discardableResult
    public func populate<T : Persistable>(groupID: String?, with plainModel: T, context: NSManagedObjectContext) -> Self {
        guard let plainModel = plainModel as? ParentNestedClass else { return self }
        lfCoreDataEntityIsPopulated = NSNumber(booleanLiteral: true)
        lfCoreDataEntityGroupIdentifier = groupID
        id = plainModel.id 
        name = plainModel.name 
        if let child = plainModel.child {
            if let managedChild = ManagedChildNestedClass.get(entityID: child.uniqueIdValue, sourceContext: context) {
                self.child = managedChild
                return self
            }
        if let managedRelationship = ManagedChildNestedClass
                .createEntity(entityID: child.uniqueIdValue, context: context)?
                .populate(groupID: groupID, with: child, context: context) {
                  self.child = managedRelationship
        }
        }
        return self
    }

    public static func managedKeyPathFrom<EntityType, VariableType>(_ plainKeyPath: KeyPath<EntityType, VariableType>) -> String {
        switch plainKeyPath {
            case \ParentNestedClass.id: return "id"
            case \ParentNestedClass.name: return "name"
            case \ParentNestedClass.child?.id: return "child.id"
            case \ParentNestedClass.child?.name: return "child.name"
            default: return ""
        }
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        do {
            let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "ManagedParentNestedClass")
            fetchRequest.returnsDistinctResults = true
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.propertiesToFetch = ["lfCoreDataEntityGroupIdentifier"]
            let result = try sourceContext.fetch(fetchRequest).flatMap { $0.allValues }.compactMap { $0 as? String }
            return result
        } catch {
            logError(error)
            return nil
        }
    }
}

extension ParentNestedClass: Persistable, UniqueIDConstraintKeyPath {
    public static var idKeyPath: WritableKeyPath<ParentNestedClass, ManagedParentNestedClass.EntityID> {
        return \ParentNestedClass.id
    }

    public static func count(groupID: String? = nil, using predicate: NSPredicate = .true, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Int {
        return ManagedParentNestedClass.count(groupID: groupID, using: predicate, sourceContext: sourceContext)
    }

    public static func get(entityID: ManagedParentNestedClass.EntityID, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> ParentNestedClass? {
        ManagedParentNestedClass.get(entityID: entityID, sourceContext: sourceContext)?.toPlainModel()
    }

    public static func get(groupID: String? = nil, using predicate: NSPredicate, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [ParentNestedClass] {
        ManagedParentNestedClass.get(groupID: groupID, using: predicate, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func getAll(groupID: String? = nil, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [ParentNestedClass] {
        ManagedParentNestedClass.getAll(groupID: groupID, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func create(groupID: String? = nil,
                              updateIfEntityExists: Bool,
                              updateClosure: @escaping (_ entity: inout ParentNestedClass, _ context: NSManagedObjectContext) -> Void,
                              completeClosure: ((Result<ParentNestedClass, PersistableError>) -> Void)?) {
                               ManagedParentNestedClass.create(groupID: groupID,
            updateIfEntityExists: updateIfEntityExists,
            updateClosure: { (entity, context) in
                var plainEntity: ParentNestedClass = entity.toPlainModel()
                updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }, completeClosure: { result in
            switch result {
                case .success(let entity):
                    completeClosure?(.success(entity.toPlainModel()))

                case .failure(let error):
                    completeClosure?(.failure(error))
            }
        })
    }

    public static func createEntity(groupID: String? = nil, entityID: ManagedParentNestedClass.EntityID, context: NSManagedObjectContext) -> ParentNestedClass? {
        ManagedParentNestedClass.createEntity(groupID: groupID, entityID: entityID, context: context)?.toPlainModel()
    }

    public static func createTemporary(groupID: String? = nil, updateClosure: @escaping (inout ParentNestedClass, NSManagedObjectContext) -> Void) {
        ManagedParentNestedClass.createTemporary { (entity, context) in
            var plainEntity = entity.toPlainModel()
            updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }
    }

    public func createAndPopulate(groupID: String? = nil, updateIfEntityExists: Bool = true, insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<ParentNestedClass, PersistableError>) -> Void)?) {
        ManagedParentNestedClass.createBatchAndPopulate(groupID: groupID, from: [self], insertionPolicy: insertionPolicy) { result in
            switch result {
            case .success(let response):
                guard let savedEntity = response.first else { completeClosure?(.failure(.failedToSaveEntityToStore)); return }
                completeClosure?(.success(savedEntity))
            case .failure(let error):
                completeClosure?(.failure(error))
            }
        }
    }

    public func update(updateClosure: @escaping (inout ParentNestedClass, NSManagedObjectContext) -> Void, completeClosure: ((ParentNestedClass) -> Void)?) {
        let managedEntity = ManagedParentNestedClass.get(entityID: self[keyPath: Self.idKeyPath])

        managedEntity?.update(updateClosure: { (entity, context) in
            var mutableSelf = self
            updateClosure(&mutableSelf, context)
            entity.populate(groupID: managedEntity?.lfCoreDataEntityGroupIdentifier, with: mutableSelf, context: context)

        }, completeClosure: { updatedEntity in
            completeClosure?(updatedEntity.toPlainModel())
        })
    }

    public func delete(sourceContext: NSManagedObjectContext = CoreDataStore.shared.newBackgroundContext, completeClosure: (() -> Void)?) {
        let managedEntity = ManagedParentNestedClass.get(entityID: self[keyPath: Self.idKeyPath], sourceContext: sourceContext)
        managedEntity?.delete(sourceContext: sourceContext, completeClosure: completeClosure)
    }

    public static func delete(with options: DeleteOptions = DeleteOptions(), completeClosure: (() -> Void)?) {
        ManagedParentNestedClass.delete(with: options, completeClosure: completeClosure)
    }

    public static func createBatchAndPopulate<PersistableType: Persistable & UniqueIDConstraintKeyPath>(groupID: String? = nil, from plainModels: [PersistableType], insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<[PersistableType], PersistableError>) -> Void)?) {
      ManagedParentNestedClass.createBatchAndPopulate(groupID: groupID, from: plainModels, insertionPolicy: insertionPolicy, completeClosure: completeClosure)
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        return ManagedParentNestedClass.getAllGroups(sourceContext: sourceContext)
    }
}

extension ParentRecursiveClass { static var managedModelName = "ManagedParentRecursiveClass" }

@objc(ManagedParentRecursiveClass)
final public class ManagedParentRecursiveClass: PersistableManagedObject, KeyPathable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedParentRecursiveClass> {
        return NSFetchRequest<ManagedParentRecursiveClass>(entityName: "ManagedParentRecursiveClass")
    }

    public static var idKeyPath: WritableKeyPath<ManagedParentRecursiveClass, String> {
        return \ManagedParentRecursiveClass.id
    }

    public static var groupIDKeyPath: WritableKeyPath<ManagedParentRecursiveClass, String?> {
        return \ManagedParentRecursiveClass.lfCoreDataEntityGroupIdentifier
    }

    @NSManaged @objc(lfCoreDataEntityIsPopulated) public var lfCoreDataEntityIsPopulated: NSNumber

    public var isPopulated: Bool {
        return lfCoreDataEntityIsPopulated as! Bool
    }

    @NSManaged @objc(lfCoreDataEntityGroupIdentifier) public var lfCoreDataEntityGroupIdentifier: String?

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var child: ManagedChildRecursiveClass?

    var plainModel: ParentRecursiveClass?
    var plainCounter = 0
    public var isModelRecursive: Bool { return plainCounter > 5 }

    func toPlainModel(isRecursive: Bool = false) -> ParentRecursiveClass {
        plainCounter.increment(); defer { plainCounter.decrement() }
        if let model = self.plainModel {
            model.id = self.id
            model.child = self.child?.toPlainModel(isRecursive: child?.isModelRecursive ?? false)
        } else {
            let parentRecursiveClass = ParentRecursiveClass(
            id: self.id,
            name: self.name,
            child: self.child?.toPlainModel(isRecursive: child?.isModelRecursive ?? false)
        )
        self.plainModel = parentRecursiveClass
      }
        return plainModel!
    }

    override public func awakeFromInsert() {
      super.awakeFromInsert()
      self.id = .empty
      self.name = .empty
    }


    @discardableResult
    public func populate<T : Persistable>(groupID: String?, with plainModel: T, context: NSManagedObjectContext) -> Self {
        guard let plainModel = plainModel as? ParentRecursiveClass else { return self }
        lfCoreDataEntityIsPopulated = NSNumber(booleanLiteral: true)
        lfCoreDataEntityGroupIdentifier = groupID
        id = plainModel.id 
        name = plainModel.name 
        if let child = plainModel.child {
            if let managedChild = ManagedChildRecursiveClass.get(entityID: child.uniqueIdValue, sourceContext: context) {
                self.child = managedChild
                return self
            }
        if let managedRelationship = ManagedChildRecursiveClass
                .createEntity(entityID: child.uniqueIdValue, context: context)?
                .populate(groupID: groupID, with: child, context: context) {
                  self.child = managedRelationship
        }
        }
        return self
    }

    public static func managedKeyPathFrom<EntityType, VariableType>(_ plainKeyPath: KeyPath<EntityType, VariableType>) -> String {
        switch plainKeyPath {
            case \ParentRecursiveClass.id: return "id"
            case \ParentRecursiveClass.name: return "name"
            case \ParentRecursiveClass.child?.id: return "child.id"
            case \ParentRecursiveClass.child?.name: return "child.name"
            case \ParentRecursiveClass.child?.grandchild?.id: return "child.grandchild.id"
            case \ParentRecursiveClass.child?.grandchild?.name: return "child.grandchild.name"
            default: return ""
        }
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        do {
            let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "ManagedParentRecursiveClass")
            fetchRequest.returnsDistinctResults = true
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.propertiesToFetch = ["lfCoreDataEntityGroupIdentifier"]
            let result = try sourceContext.fetch(fetchRequest).flatMap { $0.allValues }.compactMap { $0 as? String }
            return result
        } catch {
            logError(error)
            return nil
        }
    }
}

extension ParentRecursiveClass: Persistable, UniqueIDConstraintKeyPath {
    public static var idKeyPath: WritableKeyPath<ParentRecursiveClass, ManagedParentRecursiveClass.EntityID> {
        return \ParentRecursiveClass.id
    }

    public static func count(groupID: String? = nil, using predicate: NSPredicate = .true, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Int {
        return ManagedParentRecursiveClass.count(groupID: groupID, using: predicate, sourceContext: sourceContext)
    }

    public static func get(entityID: ManagedParentRecursiveClass.EntityID, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> ParentRecursiveClass? {
        ManagedParentRecursiveClass.get(entityID: entityID, sourceContext: sourceContext)?.toPlainModel()
    }

    public static func get(groupID: String? = nil, using predicate: NSPredicate, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [ParentRecursiveClass] {
        ManagedParentRecursiveClass.get(groupID: groupID, using: predicate, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func getAll(groupID: String? = nil, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [ParentRecursiveClass] {
        ManagedParentRecursiveClass.getAll(groupID: groupID, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func create(groupID: String? = nil,
                              updateIfEntityExists: Bool,
                              updateClosure: @escaping (_ entity: inout ParentRecursiveClass, _ context: NSManagedObjectContext) -> Void,
                              completeClosure: ((Result<ParentRecursiveClass, PersistableError>) -> Void)?) {
                               ManagedParentRecursiveClass.create(groupID: groupID,
            updateIfEntityExists: updateIfEntityExists,
            updateClosure: { (entity, context) in
                var plainEntity: ParentRecursiveClass = entity.toPlainModel()
                updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }, completeClosure: { result in
            switch result {
                case .success(let entity):
                    completeClosure?(.success(entity.toPlainModel()))

                case .failure(let error):
                    completeClosure?(.failure(error))
            }
        })
    }

    public static func createEntity(groupID: String? = nil, entityID: ManagedParentRecursiveClass.EntityID, context: NSManagedObjectContext) -> ParentRecursiveClass? {
        ManagedParentRecursiveClass.createEntity(groupID: groupID, entityID: entityID, context: context)?.toPlainModel()
    }

    public static func createTemporary(groupID: String? = nil, updateClosure: @escaping (inout ParentRecursiveClass, NSManagedObjectContext) -> Void) {
        ManagedParentRecursiveClass.createTemporary { (entity, context) in
            var plainEntity = entity.toPlainModel()
            updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }
    }

    public func createAndPopulate(groupID: String? = nil, updateIfEntityExists: Bool = true, insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<ParentRecursiveClass, PersistableError>) -> Void)?) {
        ManagedParentRecursiveClass.createBatchAndPopulate(groupID: groupID, from: [self], insertionPolicy: insertionPolicy) { result in
            switch result {
            case .success(let response):
                guard let savedEntity = response.first else { completeClosure?(.failure(.failedToSaveEntityToStore)); return }
                completeClosure?(.success(savedEntity))
            case .failure(let error):
                completeClosure?(.failure(error))
            }
        }
    }

    public func update(updateClosure: @escaping (inout ParentRecursiveClass, NSManagedObjectContext) -> Void, completeClosure: ((ParentRecursiveClass) -> Void)?) {
        let managedEntity = ManagedParentRecursiveClass.get(entityID: self[keyPath: Self.idKeyPath])

        managedEntity?.update(updateClosure: { (entity, context) in
            var mutableSelf = self
            updateClosure(&mutableSelf, context)
            entity.populate(groupID: managedEntity?.lfCoreDataEntityGroupIdentifier, with: mutableSelf, context: context)

        }, completeClosure: { updatedEntity in
            completeClosure?(updatedEntity.toPlainModel())
        })
    }

    public func delete(sourceContext: NSManagedObjectContext = CoreDataStore.shared.newBackgroundContext, completeClosure: (() -> Void)?) {
        let managedEntity = ManagedParentRecursiveClass.get(entityID: self[keyPath: Self.idKeyPath], sourceContext: sourceContext)
        managedEntity?.delete(sourceContext: sourceContext, completeClosure: completeClosure)
    }

    public static func delete(with options: DeleteOptions = DeleteOptions(), completeClosure: (() -> Void)?) {
        ManagedParentRecursiveClass.delete(with: options, completeClosure: completeClosure)
    }

    public static func createBatchAndPopulate<PersistableType: Persistable & UniqueIDConstraintKeyPath>(groupID: String? = nil, from plainModels: [PersistableType], insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<[PersistableType], PersistableError>) -> Void)?) {
      ManagedParentRecursiveClass.createBatchAndPopulate(groupID: groupID, from: plainModels, insertionPolicy: insertionPolicy, completeClosure: completeClosure)
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        return ManagedParentRecursiveClass.getAllGroups(sourceContext: sourceContext)
    }
}

extension ParentStruct { static var managedModelName = "ManagedParentStruct" }

@objc(ManagedParentStruct)
final public class ManagedParentStruct: PersistableManagedObject, KeyPathable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedParentStruct> {
        return NSFetchRequest<ManagedParentStruct>(entityName: "ManagedParentStruct")
    }

    public static var idKeyPath: WritableKeyPath<ManagedParentStruct, String> {
        return \ManagedParentStruct.id
    }

    public static var groupIDKeyPath: WritableKeyPath<ManagedParentStruct, String?> {
        return \ManagedParentStruct.lfCoreDataEntityGroupIdentifier
    }

    @NSManaged @objc(lfCoreDataEntityIsPopulated) public var lfCoreDataEntityIsPopulated: NSNumber

    public var isPopulated: Bool {
        return lfCoreDataEntityIsPopulated as! Bool
    }

    @NSManaged @objc(lfCoreDataEntityGroupIdentifier) public var lfCoreDataEntityGroupIdentifier: String?

    @NSManaged public var id: String
    @NSManaged public var year: NSNumber
    @NSManaged public var tag: NSNumber
    @NSManaged public var childId: String
    @NSManaged public var child: ManagedChildStruct?

    var plainModel: ParentStruct?
    var plainCounter = 0
    public var isModelRecursive: Bool { return plainCounter > 5 }

    func toPlainModel(isRecursive: Bool = false) -> ParentStruct {
        plainCounter.increment(); defer { plainCounter.decrement() }
        if var model = self.plainModel {
            model.id = self.id
            model.child = self.child?.toPlainModel(isRecursive: child?.isModelRecursive ?? false)
        } else {
            let parentStruct = ParentStruct(
            id: self.id,
            year: self.year.intValue,
            tag: self.tag.intValue,
            childId: self.childId,
            child: self.child?.toPlainModel(isRecursive: child?.isModelRecursive ?? false)
        )
        self.plainModel = parentStruct
      }
        return plainModel!
    }

    override public func awakeFromInsert() {
      super.awakeFromInsert()
      self.id = .empty
      self.year = .empty
      self.tag = .empty
      self.childId = .empty
    }


    @discardableResult
    public func populate<T : Persistable>(groupID: String?, with plainModel: T, context: NSManagedObjectContext) -> Self {
        guard let plainModel = plainModel as? ParentStruct else { return self }
        lfCoreDataEntityIsPopulated = NSNumber(booleanLiteral: true)
        lfCoreDataEntityGroupIdentifier = groupID
        id = plainModel.id 
        year = plainModel.year as NSNumber
        tag = plainModel.tag as NSNumber
        childId = plainModel.childId 
        let childEntityID = childId
        if let managedRelationship = ManagedChildStruct
                .createEntity(entityID: childEntityID, context: context) {
                  self.child = managedRelationship
        }
        return self
    }

    public static func managedKeyPathFrom<EntityType, VariableType>(_ plainKeyPath: KeyPath<EntityType, VariableType>) -> String {
        switch plainKeyPath {
            case \ParentStruct.id: return "id"
            case \ParentStruct.year: return "year"
            case \ParentStruct.tag: return "tag"
            case \ParentStruct.childId: return "childId"
            case \ParentStruct.child?.id: return "child.id"
            case \ParentStruct.child?.name: return "child.name"
            case \ParentStruct.child?.age: return "child.age"
            case \ParentStruct.child?.child?.id: return "child.child.id"
            case \ParentStruct.child?.child?.firstName: return "child.child.firstName"
            case \ParentStruct.child?.child?.age: return "child.child.age"
            case \ParentStruct.child?.projects: return "child.projects"
            default: return ""
        }
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        do {
            let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "ManagedParentStruct")
            fetchRequest.returnsDistinctResults = true
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.propertiesToFetch = ["lfCoreDataEntityGroupIdentifier"]
            let result = try sourceContext.fetch(fetchRequest).flatMap { $0.allValues }.compactMap { $0 as? String }
            return result
        } catch {
            logError(error)
            return nil
        }
    }
}

extension ParentStruct: Persistable, UniqueIDConstraintKeyPath {
    public static var idKeyPath: WritableKeyPath<ParentStruct, ManagedParentStruct.EntityID> {
        return \ParentStruct.id
    }

    public static func count(groupID: String? = nil, using predicate: NSPredicate = .true, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Int {
        return ManagedParentStruct.count(groupID: groupID, using: predicate, sourceContext: sourceContext)
    }

    public static func get(entityID: ManagedParentStruct.EntityID, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> ParentStruct? {
        ManagedParentStruct.get(entityID: entityID, sourceContext: sourceContext)?.toPlainModel()
    }

    public static func get(groupID: String? = nil, using predicate: NSPredicate, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [ParentStruct] {
        ManagedParentStruct.get(groupID: groupID, using: predicate, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func getAll(groupID: String? = nil, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [ParentStruct] {
        ManagedParentStruct.getAll(groupID: groupID, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func create(groupID: String? = nil,
                              updateIfEntityExists: Bool,
                              updateClosure: @escaping (_ entity: inout ParentStruct, _ context: NSManagedObjectContext) -> Void,
                              completeClosure: ((Result<ParentStruct, PersistableError>) -> Void)?) {
                               ManagedParentStruct.create(groupID: groupID,
            updateIfEntityExists: updateIfEntityExists,
            updateClosure: { (entity, context) in
                var plainEntity: ParentStruct = entity.toPlainModel()
                updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }, completeClosure: { result in
            switch result {
                case .success(let entity):
                    completeClosure?(.success(entity.toPlainModel()))

                case .failure(let error):
                    completeClosure?(.failure(error))
            }
        })
    }

    public static func createEntity(groupID: String? = nil, entityID: ManagedParentStruct.EntityID, context: NSManagedObjectContext) -> ParentStruct? {
        ManagedParentStruct.createEntity(groupID: groupID, entityID: entityID, context: context)?.toPlainModel()
    }

    public static func createTemporary(groupID: String? = nil, updateClosure: @escaping (inout ParentStruct, NSManagedObjectContext) -> Void) {
        ManagedParentStruct.createTemporary { (entity, context) in
            var plainEntity = entity.toPlainModel()
            updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }
    }

    public func createAndPopulate(groupID: String? = nil, updateIfEntityExists: Bool = true, insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<ParentStruct, PersistableError>) -> Void)?) {
        ManagedParentStruct.createBatchAndPopulate(groupID: groupID, from: [self], insertionPolicy: insertionPolicy) { result in
            switch result {
            case .success(let response):
                guard let savedEntity = response.first else { completeClosure?(.failure(.failedToSaveEntityToStore)); return }
                completeClosure?(.success(savedEntity))
            case .failure(let error):
                completeClosure?(.failure(error))
            }
        }
    }

    public func update(updateClosure: @escaping (inout ParentStruct, NSManagedObjectContext) -> Void, completeClosure: ((ParentStruct) -> Void)?) {
        let managedEntity = ManagedParentStruct.get(entityID: self[keyPath: Self.idKeyPath])

        managedEntity?.update(updateClosure: { (entity, context) in
            var mutableSelf = self
            updateClosure(&mutableSelf, context)
            entity.populate(groupID: managedEntity?.lfCoreDataEntityGroupIdentifier, with: mutableSelf, context: context)

        }, completeClosure: { updatedEntity in
            completeClosure?(updatedEntity.toPlainModel())
        })
    }

    public func delete(sourceContext: NSManagedObjectContext = CoreDataStore.shared.newBackgroundContext, completeClosure: (() -> Void)?) {
        let managedEntity = ManagedParentStruct.get(entityID: self[keyPath: Self.idKeyPath], sourceContext: sourceContext)
        managedEntity?.delete(sourceContext: sourceContext, completeClosure: completeClosure)
    }

    public static func delete(with options: DeleteOptions = DeleteOptions(), completeClosure: (() -> Void)?) {
        ManagedParentStruct.delete(with: options, completeClosure: completeClosure)
    }

    public static func createBatchAndPopulate<PersistableType: Persistable & UniqueIDConstraintKeyPath>(groupID: String? = nil, from plainModels: [PersistableType], insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<[PersistableType], PersistableError>) -> Void)?) {
      ManagedParentStruct.createBatchAndPopulate(groupID: groupID, from: plainModels, insertionPolicy: insertionPolicy, completeClosure: completeClosure)
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        return ManagedParentStruct.getAllGroups(sourceContext: sourceContext)
    }
}

extension Person { static var managedModelName = "ManagedPerson" }

@objc(ManagedPerson)
final public class ManagedPerson: PersistableManagedObject, KeyPathable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedPerson> {
        return NSFetchRequest<ManagedPerson>(entityName: "ManagedPerson")
    }

    public static var idKeyPath: WritableKeyPath<ManagedPerson, String?> {
        return \ManagedPerson.id
    }

    public static var groupIDKeyPath: WritableKeyPath<ManagedPerson, String?> {
        return \ManagedPerson.lfCoreDataEntityGroupIdentifier
    }

    @NSManaged @objc(lfCoreDataEntityIsPopulated) public var lfCoreDataEntityIsPopulated: NSNumber

    public var isPopulated: Bool {
        return lfCoreDataEntityIsPopulated as! Bool
    }

    @NSManaged @objc(lfCoreDataEntityGroupIdentifier) public var lfCoreDataEntityGroupIdentifier: String?

    @NSManaged public var id: String?

    // ENUM: Activity
    @NSManaged public var sleepingActivity: String?
    @NSManaged public var workingActivityStringArrayWith: [String]?
    @NSManaged public var workingActivityWorkArrayAt: NSOrderedSet?
    @NSManaged public var walkingActivityString: String?
    @NSManaged public var runningActivityString0: String?
    @NSManaged public var runningActivityString1: String?
    @NSManaged public var drivingActivityCarVehicle: ManagedCar?
    @NSManaged public var flyingActivityAirplaneVehicle: ManagedAirplane?
    @NSManaged public var flyingActivityStringDescription: String?
    @NSManaged public var flyingActivityString2: String?

    var plainModel: Person?
    var plainCounter = 0
    public var isModelRecursive: Bool { return plainCounter > 5 }

    func toPlainModel(isRecursive: Bool = false) -> Person {
        plainCounter.increment(); defer { plainCounter.decrement() }
        if var model = self.plainModel {
            model.id = self.id
        } else {
            let person = Person(
            id: self.id,
            activity: {
            if sleepingActivity != nil {
                return .sleeping
            }
            if
            let associatedValueworkingActivityStringArrayWith = workingActivityStringArrayWith,
            let associatedValueworkingActivityWorkArrayAt = workingActivityWorkArrayAt { 
                    return .working(with: associatedValueworkingActivityStringArrayWith,
                    at: associatedValueworkingActivityWorkArrayAt.filter { ($0 as! ManagedWork).isPopulated }.compactMap{($0 as! ManagedWork).toPlainModel(isRecursive:isRecursive)})
            }
            if
            let associatedValuewalkingActivityString = walkingActivityString { 
                    return .walking(associatedValuewalkingActivityString)
            }
            if
            let associatedValuerunningActivityString0 = runningActivityString0,
            let associatedValuerunningActivityString1 = runningActivityString1 { 
                    return .running(associatedValuerunningActivityString0,
                    associatedValuerunningActivityString1)
            }
            if
            let associatedValuedrivingActivityCarVehicle = drivingActivityCarVehicle, associatedValuedrivingActivityCarVehicle.lfCoreDataEntityIsPopulated.boolValue { 
                    return .driving(vehicle: associatedValuedrivingActivityCarVehicle.toPlainModel())
            }
            if
            let associatedValueflyingActivityAirplaneVehicle = flyingActivityAirplaneVehicle, associatedValueflyingActivityAirplaneVehicle.lfCoreDataEntityIsPopulated.boolValue,
            let associatedValueflyingActivityStringDescription = flyingActivityStringDescription,
            let associatedValueflyingActivityString2 = flyingActivityString2 { 
                    return .flying(vehicle: associatedValueflyingActivityAirplaneVehicle.toPlainModel(),
                    description: associatedValueflyingActivityStringDescription,
                    associatedValueflyingActivityString2)
            }
            fatalError("There are no associated values from which an entity can be pulled")
          }()
        )
        self.plainModel = person
      }
        return plainModel!
    }

    override public func awakeFromInsert() {
      super.awakeFromInsert()
    }


    @discardableResult
    public func populate<T : Persistable>(groupID: String?, with plainModel: T, context: NSManagedObjectContext) -> Self {
        guard let plainModel = plainModel as? Person else { return self }
        lfCoreDataEntityIsPopulated = NSNumber(booleanLiteral: true)
        lfCoreDataEntityGroupIdentifier = groupID
        // Set autoID
        id = UUID().uuidString
        // Delete all enums before setting a new one
        sleepingActivity = nil
        workingActivityStringArrayWith = nil
        walkingActivityString = nil
        runningActivityString0 = nil
        runningActivityString1 = nil
        drivingActivityCarVehicle?.deleteWithoutCommiting(context: context)
        flyingActivityAirplaneVehicle?.deleteWithoutCommiting(context: context)
        flyingActivityStringDescription = nil
        flyingActivityString2 = nil
        switch plainModel.activity {
        case .sleeping: sleepingActivity = .empty 
        case .working(let withentitywith,let atentityat):
                workingActivityStringArrayWith = withentitywith
                let atentityatToManyRelationship = NSMutableOrderedSet()

                for element in atentityat {
                    if let managedRelationship = ManagedWork
                        .createEntity(entityID: element[keyPath: Work.idKeyPath], context: context)?
                        .populate(groupID: groupID, with: element, context: context) {
                    atentityatToManyRelationship.add(managedRelationship)
                    }
                }
                self.workingActivityWorkArrayAt = atentityatToManyRelationship
        case .walking(let entity):
            walkingActivityString = entity
        case .running(let entity0,let entity1):
            runningActivityString0 = entity0
            runningActivityString1 = entity1
        case .driving(let vehicleentity):
            drivingActivityCarVehicle = ManagedCar.createEntity(entityID: vehicleentity.uniqueIdValue, context: context)?.populate(groupID: groupID, with: vehicleentity, context: context)
        case .flying(let vehicleentityvehicle,let descriptionentitydescription,let entity2):
            flyingActivityAirplaneVehicle = ManagedAirplane.createEntity(entityID: vehicleentityvehicle.uniqueIdValue, context: context)?.populate(groupID: groupID, with: vehicleentityvehicle, context: context)
            flyingActivityStringDescription = descriptionentitydescription
            flyingActivityString2 = entity2
            }
        return self
    }

    public static func managedKeyPathFrom<EntityType, VariableType>(_ plainKeyPath: KeyPath<EntityType, VariableType>) -> String {
        switch plainKeyPath {
            case \Person.id: return "id"
            default: return ""
        }
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        do {
            let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "ManagedPerson")
            fetchRequest.returnsDistinctResults = true
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.propertiesToFetch = ["lfCoreDataEntityGroupIdentifier"]
            let result = try sourceContext.fetch(fetchRequest).flatMap { $0.allValues }.compactMap { $0 as? String }
            return result
        } catch {
            logError(error)
            return nil
        }
    }
}

extension Person: Persistable, UniqueIDConstraintKeyPath {
    public static var idKeyPath: WritableKeyPath<Person, ManagedPerson.EntityID> {
        return \Person.id
    }

    public static func count(groupID: String? = nil, using predicate: NSPredicate = .true, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Int {
        return ManagedPerson.count(groupID: groupID, using: predicate, sourceContext: sourceContext)
    }

    public static func get(entityID: ManagedPerson.EntityID, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Person? {
        ManagedPerson.get(entityID: entityID, sourceContext: sourceContext)?.toPlainModel()
    }

    public static func get(groupID: String? = nil, using predicate: NSPredicate, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [Person] {
        ManagedPerson.get(groupID: groupID, using: predicate, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func getAll(groupID: String? = nil, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [Person] {
        ManagedPerson.getAll(groupID: groupID, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func create(groupID: String? = nil,
                              updateIfEntityExists: Bool,
                              updateClosure: @escaping (_ entity: inout Person, _ context: NSManagedObjectContext) -> Void,
                              completeClosure: ((Result<Person, PersistableError>) -> Void)?) {
                               ManagedPerson.create(groupID: groupID,
            updateIfEntityExists: updateIfEntityExists,
            updateClosure: { (entity, context) in
                var plainEntity: Person = entity.toPlainModel()
                updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }, completeClosure: { result in
            switch result {
                case .success(let entity):
                    completeClosure?(.success(entity.toPlainModel()))

                case .failure(let error):
                    completeClosure?(.failure(error))
            }
        })
    }

    public static func createEntity(groupID: String? = nil, entityID: ManagedPerson.EntityID, context: NSManagedObjectContext) -> Person? {
        ManagedPerson.createEntity(groupID: groupID, entityID: entityID, context: context)?.toPlainModel()
    }

    public static func createTemporary(groupID: String? = nil, updateClosure: @escaping (inout Person, NSManagedObjectContext) -> Void) {
        ManagedPerson.createTemporary { (entity, context) in
            var plainEntity = entity.toPlainModel()
            updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }
    }

    public func createAndPopulate(groupID: String? = nil, updateIfEntityExists: Bool = true, insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<Person, PersistableError>) -> Void)?) {
        ManagedPerson.createBatchAndPopulate(groupID: groupID, from: [self], insertionPolicy: insertionPolicy) { result in
            switch result {
            case .success(let response):
                guard let savedEntity = response.first else { completeClosure?(.failure(.failedToSaveEntityToStore)); return }
                completeClosure?(.success(savedEntity))
            case .failure(let error):
                completeClosure?(.failure(error))
            }
        }
    }

    public func update(updateClosure: @escaping (inout Person, NSManagedObjectContext) -> Void, completeClosure: ((Person) -> Void)?) {
        let managedEntity = ManagedPerson.get(entityID: self[keyPath: Self.idKeyPath])

        managedEntity?.update(updateClosure: { (entity, context) in
            var mutableSelf = self
            updateClosure(&mutableSelf, context)
            entity.populate(groupID: managedEntity?.lfCoreDataEntityGroupIdentifier, with: mutableSelf, context: context)

        }, completeClosure: { updatedEntity in
            completeClosure?(updatedEntity.toPlainModel())
        })
    }

    public func delete(sourceContext: NSManagedObjectContext = CoreDataStore.shared.newBackgroundContext, completeClosure: (() -> Void)?) {
        let managedEntity = ManagedPerson.get(entityID: self[keyPath: Self.idKeyPath], sourceContext: sourceContext)
        managedEntity?.delete(sourceContext: sourceContext, completeClosure: completeClosure)
    }

    public static func delete(with options: DeleteOptions = DeleteOptions(), completeClosure: (() -> Void)?) {
        ManagedPerson.delete(with: options, completeClosure: completeClosure)
    }

    public static func createBatchAndPopulate<PersistableType: Persistable & UniqueIDConstraintKeyPath>(groupID: String? = nil, from plainModels: [PersistableType], insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<[PersistableType], PersistableError>) -> Void)?) {
      ManagedPerson.createBatchAndPopulate(groupID: groupID, from: plainModels, insertionPolicy: insertionPolicy, completeClosure: completeClosure)
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        return ManagedPerson.getAllGroups(sourceContext: sourceContext)
    }
}

extension Product { static var managedModelName = "ManagedProduct" }

@objc(ManagedProduct)
final public class ManagedProduct: PersistableManagedObject, KeyPathable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedProduct> {
        return NSFetchRequest<ManagedProduct>(entityName: "ManagedProduct")
    }

    public static var idKeyPath: WritableKeyPath<ManagedProduct, String> {
        return \ManagedProduct.id
    }

    public static var groupIDKeyPath: WritableKeyPath<ManagedProduct, String?> {
        return \ManagedProduct.lfCoreDataEntityGroupIdentifier
    }

    @NSManaged @objc(lfCoreDataEntityIsPopulated) public var lfCoreDataEntityIsPopulated: NSNumber

    public var isPopulated: Bool {
        return lfCoreDataEntityIsPopulated as! Bool
    }

    @NSManaged @objc(lfCoreDataEntityGroupIdentifier) public var lfCoreDataEntityGroupIdentifier: String?

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var serviceIds: [String]
    @NSManaged public var services: NSOrderedSet

    var plainModel: Product?
    var plainCounter = 0
    public var isModelRecursive: Bool { return plainCounter > 5 }

    func toPlainModel(isRecursive: Bool = false) -> Product {
        plainCounter.increment(); defer { plainCounter.decrement() }
        if var model = self.plainModel {
            model.id = self.id
            model.services = self.services.filter { ($0 as! ManagedService).isPopulated }.compactMap{($0 as! ManagedService).toPlainModel(isRecursive: ($0 as! ManagedService).isModelRecursive)}
        } else {
            let product = Product(
            id: self.id,
            name: self.name,
            serviceIds: self.serviceIds,
            services: self.services.filter { ($0 as! ManagedService).isPopulated }.compactMap{($0 as! ManagedService).toPlainModel(isRecursive: ($0 as! ManagedService).isModelRecursive)}
        )
        self.plainModel = product
      }
        return plainModel!
    }

    override public func awakeFromInsert() {
      super.awakeFromInsert()
      self.id = .empty
      self.name = .empty
      self.serviceIds = []
    }


    @discardableResult
    public func populate<T : Persistable>(groupID: String?, with plainModel: T, context: NSManagedObjectContext) -> Self {
        guard let plainModel = plainModel as? Product else { return self }
        lfCoreDataEntityIsPopulated = NSNumber(booleanLiteral: true)
        lfCoreDataEntityGroupIdentifier = groupID
        id = plainModel.id 
        name = plainModel.name 
        serviceIds = plainModel.serviceIds 
        let servicesToManyRelationship = NSMutableOrderedSet()

        serviceIds.forEach {
            if let managedRelationship = ManagedService.createEntity(entityID: $0, context: context) {
                  servicesToManyRelationship.add(managedRelationship)
            }
        }
        self.services = servicesToManyRelationship
        return self
    }

    public static func managedKeyPathFrom<EntityType, VariableType>(_ plainKeyPath: KeyPath<EntityType, VariableType>) -> String {
        switch plainKeyPath {
            case \Product.id: return "id"
            case \Product.name: return "name"
            case \Product.serviceIds: return "serviceIds"
            case \Product.services: return "services"
            default: return ""
        }
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        do {
            let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "ManagedProduct")
            fetchRequest.returnsDistinctResults = true
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.propertiesToFetch = ["lfCoreDataEntityGroupIdentifier"]
            let result = try sourceContext.fetch(fetchRequest).flatMap { $0.allValues }.compactMap { $0 as? String }
            return result
        } catch {
            logError(error)
            return nil
        }
    }
}

extension Product: Persistable, UniqueIDConstraintKeyPath {
    public static var idKeyPath: WritableKeyPath<Product, ManagedProduct.EntityID> {
        return \Product.id
    }

    public static func count(groupID: String? = nil, using predicate: NSPredicate = .true, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Int {
        return ManagedProduct.count(groupID: groupID, using: predicate, sourceContext: sourceContext)
    }

    public static func get(entityID: ManagedProduct.EntityID, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Product? {
        ManagedProduct.get(entityID: entityID, sourceContext: sourceContext)?.toPlainModel()
    }

    public static func get(groupID: String? = nil, using predicate: NSPredicate, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [Product] {
        ManagedProduct.get(groupID: groupID, using: predicate, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func getAll(groupID: String? = nil, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [Product] {
        ManagedProduct.getAll(groupID: groupID, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func create(groupID: String? = nil,
                              updateIfEntityExists: Bool,
                              updateClosure: @escaping (_ entity: inout Product, _ context: NSManagedObjectContext) -> Void,
                              completeClosure: ((Result<Product, PersistableError>) -> Void)?) {
                               ManagedProduct.create(groupID: groupID,
            updateIfEntityExists: updateIfEntityExists,
            updateClosure: { (entity, context) in
                var plainEntity: Product = entity.toPlainModel()
                updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }, completeClosure: { result in
            switch result {
                case .success(let entity):
                    completeClosure?(.success(entity.toPlainModel()))

                case .failure(let error):
                    completeClosure?(.failure(error))
            }
        })
    }

    public static func createEntity(groupID: String? = nil, entityID: ManagedProduct.EntityID, context: NSManagedObjectContext) -> Product? {
        ManagedProduct.createEntity(groupID: groupID, entityID: entityID, context: context)?.toPlainModel()
    }

    public static func createTemporary(groupID: String? = nil, updateClosure: @escaping (inout Product, NSManagedObjectContext) -> Void) {
        ManagedProduct.createTemporary { (entity, context) in
            var plainEntity = entity.toPlainModel()
            updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }
    }

    public func createAndPopulate(groupID: String? = nil, updateIfEntityExists: Bool = true, insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<Product, PersistableError>) -> Void)?) {
        ManagedProduct.createBatchAndPopulate(groupID: groupID, from: [self], insertionPolicy: insertionPolicy) { result in
            switch result {
            case .success(let response):
                guard let savedEntity = response.first else { completeClosure?(.failure(.failedToSaveEntityToStore)); return }
                completeClosure?(.success(savedEntity))
            case .failure(let error):
                completeClosure?(.failure(error))
            }
        }
    }

    public func update(updateClosure: @escaping (inout Product, NSManagedObjectContext) -> Void, completeClosure: ((Product) -> Void)?) {
        let managedEntity = ManagedProduct.get(entityID: self[keyPath: Self.idKeyPath])

        managedEntity?.update(updateClosure: { (entity, context) in
            var mutableSelf = self
            updateClosure(&mutableSelf, context)
            entity.populate(groupID: managedEntity?.lfCoreDataEntityGroupIdentifier, with: mutableSelf, context: context)

        }, completeClosure: { updatedEntity in
            completeClosure?(updatedEntity.toPlainModel())
        })
    }

    public func delete(sourceContext: NSManagedObjectContext = CoreDataStore.shared.newBackgroundContext, completeClosure: (() -> Void)?) {
        let managedEntity = ManagedProduct.get(entityID: self[keyPath: Self.idKeyPath], sourceContext: sourceContext)
        managedEntity?.delete(sourceContext: sourceContext, completeClosure: completeClosure)
    }

    public static func delete(with options: DeleteOptions = DeleteOptions(), completeClosure: (() -> Void)?) {
        ManagedProduct.delete(with: options, completeClosure: completeClosure)
    }

    public static func createBatchAndPopulate<PersistableType: Persistable & UniqueIDConstraintKeyPath>(groupID: String? = nil, from plainModels: [PersistableType], insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<[PersistableType], PersistableError>) -> Void)?) {
      ManagedProduct.createBatchAndPopulate(groupID: groupID, from: plainModels, insertionPolicy: insertionPolicy, completeClosure: completeClosure)
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        return ManagedProduct.getAllGroups(sourceContext: sourceContext)
    }
}

extension Project { static var managedModelName = "ManagedProject" }

@objc(ManagedProject)
final public class ManagedProject: PersistableManagedObject, KeyPathable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedProject> {
        return NSFetchRequest<ManagedProject>(entityName: "ManagedProject")
    }

    public static var idKeyPath: WritableKeyPath<ManagedProject, String> {
        return \ManagedProject.id
    }

    public static var groupIDKeyPath: WritableKeyPath<ManagedProject, String?> {
        return \ManagedProject.lfCoreDataEntityGroupIdentifier
    }

    @NSManaged @objc(lfCoreDataEntityIsPopulated) public var lfCoreDataEntityIsPopulated: NSNumber

    public var isPopulated: Bool {
        return lfCoreDataEntityIsPopulated as! Bool
    }

    @NSManaged @objc(lfCoreDataEntityGroupIdentifier) public var lfCoreDataEntityGroupIdentifier: String?

    @NSManaged public var id: String
    @NSManaged public var durationInMonths: NSNumber
    @NSManaged public var desc: String

    var plainModel: Project?
    var plainCounter = 0
    public var isModelRecursive: Bool { return plainCounter > 5 }

    func toPlainModel(isRecursive: Bool = false) -> Project {
        plainCounter.increment(); defer { plainCounter.decrement() }
        if var model = self.plainModel {
            model.id = self.id
        } else {
            let project = Project(
            id: self.id,
            durationInMonths: self.durationInMonths.intValue,
            description: self.desc
        )
        self.plainModel = project
      }
        return plainModel!
    }

    override public func awakeFromInsert() {
      super.awakeFromInsert()
      self.id = .empty
      self.durationInMonths = .empty
      self.desc = .empty
    }


    @discardableResult
    public func populate<T : Persistable>(groupID: String?, with plainModel: T, context: NSManagedObjectContext) -> Self {
        guard let plainModel = plainModel as? Project else { return self }
        lfCoreDataEntityIsPopulated = NSNumber(booleanLiteral: true)
        lfCoreDataEntityGroupIdentifier = groupID
        id = plainModel.id 
        durationInMonths = plainModel.durationInMonths as NSNumber
        desc = plainModel.description 
        return self
    }

    public static func managedKeyPathFrom<EntityType, VariableType>(_ plainKeyPath: KeyPath<EntityType, VariableType>) -> String {
        switch plainKeyPath {
            case \Project.id: return "id"
            case \Project.durationInMonths: return "durationInMonths"
            case \Project.description: return "description"
            default: return ""
        }
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        do {
            let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "ManagedProject")
            fetchRequest.returnsDistinctResults = true
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.propertiesToFetch = ["lfCoreDataEntityGroupIdentifier"]
            let result = try sourceContext.fetch(fetchRequest).flatMap { $0.allValues }.compactMap { $0 as? String }
            return result
        } catch {
            logError(error)
            return nil
        }
    }
}

extension Project: Persistable, UniqueIDConstraintKeyPath {
    public static var idKeyPath: WritableKeyPath<Project, ManagedProject.EntityID> {
        return \Project.id
    }

    public static func count(groupID: String? = nil, using predicate: NSPredicate = .true, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Int {
        return ManagedProject.count(groupID: groupID, using: predicate, sourceContext: sourceContext)
    }

    public static func get(entityID: ManagedProject.EntityID, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Project? {
        ManagedProject.get(entityID: entityID, sourceContext: sourceContext)?.toPlainModel()
    }

    public static func get(groupID: String? = nil, using predicate: NSPredicate, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [Project] {
        ManagedProject.get(groupID: groupID, using: predicate, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func getAll(groupID: String? = nil, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [Project] {
        ManagedProject.getAll(groupID: groupID, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func create(groupID: String? = nil,
                              updateIfEntityExists: Bool,
                              updateClosure: @escaping (_ entity: inout Project, _ context: NSManagedObjectContext) -> Void,
                              completeClosure: ((Result<Project, PersistableError>) -> Void)?) {
                               ManagedProject.create(groupID: groupID,
            updateIfEntityExists: updateIfEntityExists,
            updateClosure: { (entity, context) in
                var plainEntity: Project = entity.toPlainModel()
                updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }, completeClosure: { result in
            switch result {
                case .success(let entity):
                    completeClosure?(.success(entity.toPlainModel()))

                case .failure(let error):
                    completeClosure?(.failure(error))
            }
        })
    }

    public static func createEntity(groupID: String? = nil, entityID: ManagedProject.EntityID, context: NSManagedObjectContext) -> Project? {
        ManagedProject.createEntity(groupID: groupID, entityID: entityID, context: context)?.toPlainModel()
    }

    public static func createTemporary(groupID: String? = nil, updateClosure: @escaping (inout Project, NSManagedObjectContext) -> Void) {
        ManagedProject.createTemporary { (entity, context) in
            var plainEntity = entity.toPlainModel()
            updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }
    }

    public func createAndPopulate(groupID: String? = nil, updateIfEntityExists: Bool = true, insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<Project, PersistableError>) -> Void)?) {
        ManagedProject.createBatchAndPopulate(groupID: groupID, from: [self], insertionPolicy: insertionPolicy) { result in
            switch result {
            case .success(let response):
                guard let savedEntity = response.first else { completeClosure?(.failure(.failedToSaveEntityToStore)); return }
                completeClosure?(.success(savedEntity))
            case .failure(let error):
                completeClosure?(.failure(error))
            }
        }
    }

    public func update(updateClosure: @escaping (inout Project, NSManagedObjectContext) -> Void, completeClosure: ((Project) -> Void)?) {
        let managedEntity = ManagedProject.get(entityID: self[keyPath: Self.idKeyPath])

        managedEntity?.update(updateClosure: { (entity, context) in
            var mutableSelf = self
            updateClosure(&mutableSelf, context)
            entity.populate(groupID: managedEntity?.lfCoreDataEntityGroupIdentifier, with: mutableSelf, context: context)

        }, completeClosure: { updatedEntity in
            completeClosure?(updatedEntity.toPlainModel())
        })
    }

    public func delete(sourceContext: NSManagedObjectContext = CoreDataStore.shared.newBackgroundContext, completeClosure: (() -> Void)?) {
        let managedEntity = ManagedProject.get(entityID: self[keyPath: Self.idKeyPath], sourceContext: sourceContext)
        managedEntity?.delete(sourceContext: sourceContext, completeClosure: completeClosure)
    }

    public static func delete(with options: DeleteOptions = DeleteOptions(), completeClosure: (() -> Void)?) {
        ManagedProject.delete(with: options, completeClosure: completeClosure)
    }

    public static func createBatchAndPopulate<PersistableType: Persistable & UniqueIDConstraintKeyPath>(groupID: String? = nil, from plainModels: [PersistableType], insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<[PersistableType], PersistableError>) -> Void)?) {
      ManagedProject.createBatchAndPopulate(groupID: groupID, from: plainModels, insertionPolicy: insertionPolicy, completeClosure: completeClosure)
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        return ManagedProject.getAllGroups(sourceContext: sourceContext)
    }
}

extension SelfReferencedClass { static var managedModelName = "ManagedSelfReferencedClass" }

@objc(ManagedSelfReferencedClass)
final public class ManagedSelfReferencedClass: PersistableManagedObject, KeyPathable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedSelfReferencedClass> {
        return NSFetchRequest<ManagedSelfReferencedClass>(entityName: "ManagedSelfReferencedClass")
    }

    public static var idKeyPath: WritableKeyPath<ManagedSelfReferencedClass, String> {
        return \ManagedSelfReferencedClass.id
    }

    public static var groupIDKeyPath: WritableKeyPath<ManagedSelfReferencedClass, String?> {
        return \ManagedSelfReferencedClass.lfCoreDataEntityGroupIdentifier
    }

    @NSManaged @objc(lfCoreDataEntityIsPopulated) public var lfCoreDataEntityIsPopulated: NSNumber

    public var isPopulated: Bool {
        return lfCoreDataEntityIsPopulated as! Bool
    }

    @NSManaged @objc(lfCoreDataEntityGroupIdentifier) public var lfCoreDataEntityGroupIdentifier: String?

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var child: ManagedSelfReferencedClass?

    var plainModel: SelfReferencedClass?
    var plainCounter = 0
    public var isModelRecursive: Bool { return plainCounter > 5 }

    func toPlainModel(isRecursive: Bool = false) -> SelfReferencedClass {
        plainCounter.increment(); defer { plainCounter.decrement() }
        if let model = self.plainModel {
            model.id = self.id
        } else {
            let selfReferencedClass = SelfReferencedClass(
            id: self.id,
            name: self.name,
            child: isRecursive ? nil : self.child?.toPlainModel(isRecursive: child?.isModelRecursive ?? false)
        )
        self.plainModel = selfReferencedClass
      }
        return plainModel!
    }

    override public func awakeFromInsert() {
      super.awakeFromInsert()
      self.id = .empty
      self.name = .empty
    }


    @discardableResult
    public func populate<T : Persistable>(groupID: String?, with plainModel: T, context: NSManagedObjectContext) -> Self {
        guard let plainModel = plainModel as? SelfReferencedClass else { return self }
        lfCoreDataEntityIsPopulated = NSNumber(booleanLiteral: true)
        lfCoreDataEntityGroupIdentifier = groupID
        id = plainModel.id 
        name = plainModel.name 
        if let child = plainModel.child {
            if let managedChild = ManagedSelfReferencedClass.get(entityID: child.uniqueIdValue, sourceContext: context) {
                self.child = managedChild
                return self
            }
        if let managedRelationship = ManagedSelfReferencedClass
                .createEntity(entityID: child.uniqueIdValue, context: context)?
                .populate(groupID: groupID, with: child, context: context) {
                  self.child = managedRelationship
        }
        }
        return self
    }

    public static func managedKeyPathFrom<EntityType, VariableType>(_ plainKeyPath: KeyPath<EntityType, VariableType>) -> String {
        switch plainKeyPath {
            case \SelfReferencedClass.id: return "id"
            case \SelfReferencedClass.name: return "name"
            default: return ""
        }
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        do {
            let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "ManagedSelfReferencedClass")
            fetchRequest.returnsDistinctResults = true
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.propertiesToFetch = ["lfCoreDataEntityGroupIdentifier"]
            let result = try sourceContext.fetch(fetchRequest).flatMap { $0.allValues }.compactMap { $0 as? String }
            return result
        } catch {
            logError(error)
            return nil
        }
    }
}

extension SelfReferencedClass: Persistable, UniqueIDConstraintKeyPath {
    public static var idKeyPath: WritableKeyPath<SelfReferencedClass, ManagedSelfReferencedClass.EntityID> {
        return \SelfReferencedClass.id
    }

    public static func count(groupID: String? = nil, using predicate: NSPredicate = .true, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Int {
        return ManagedSelfReferencedClass.count(groupID: groupID, using: predicate, sourceContext: sourceContext)
    }

    public static func get(entityID: ManagedSelfReferencedClass.EntityID, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> SelfReferencedClass? {
        ManagedSelfReferencedClass.get(entityID: entityID, sourceContext: sourceContext)?.toPlainModel()
    }

    public static func get(groupID: String? = nil, using predicate: NSPredicate, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [SelfReferencedClass] {
        ManagedSelfReferencedClass.get(groupID: groupID, using: predicate, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func getAll(groupID: String? = nil, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [SelfReferencedClass] {
        ManagedSelfReferencedClass.getAll(groupID: groupID, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func create(groupID: String? = nil,
                              updateIfEntityExists: Bool,
                              updateClosure: @escaping (_ entity: inout SelfReferencedClass, _ context: NSManagedObjectContext) -> Void,
                              completeClosure: ((Result<SelfReferencedClass, PersistableError>) -> Void)?) {
                               ManagedSelfReferencedClass.create(groupID: groupID,
            updateIfEntityExists: updateIfEntityExists,
            updateClosure: { (entity, context) in
                var plainEntity: SelfReferencedClass = entity.toPlainModel()
                updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }, completeClosure: { result in
            switch result {
                case .success(let entity):
                    completeClosure?(.success(entity.toPlainModel()))

                case .failure(let error):
                    completeClosure?(.failure(error))
            }
        })
    }

    public static func createEntity(groupID: String? = nil, entityID: ManagedSelfReferencedClass.EntityID, context: NSManagedObjectContext) -> SelfReferencedClass? {
        ManagedSelfReferencedClass.createEntity(groupID: groupID, entityID: entityID, context: context)?.toPlainModel()
    }

    public static func createTemporary(groupID: String? = nil, updateClosure: @escaping (inout SelfReferencedClass, NSManagedObjectContext) -> Void) {
        ManagedSelfReferencedClass.createTemporary { (entity, context) in
            var plainEntity = entity.toPlainModel()
            updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }
    }

    public func createAndPopulate(groupID: String? = nil, updateIfEntityExists: Bool = true, insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<SelfReferencedClass, PersistableError>) -> Void)?) {
        ManagedSelfReferencedClass.createBatchAndPopulate(groupID: groupID, from: [self], insertionPolicy: insertionPolicy) { result in
            switch result {
            case .success(let response):
                guard let savedEntity = response.first else { completeClosure?(.failure(.failedToSaveEntityToStore)); return }
                completeClosure?(.success(savedEntity))
            case .failure(let error):
                completeClosure?(.failure(error))
            }
        }
    }

    public func update(updateClosure: @escaping (inout SelfReferencedClass, NSManagedObjectContext) -> Void, completeClosure: ((SelfReferencedClass) -> Void)?) {
        let managedEntity = ManagedSelfReferencedClass.get(entityID: self[keyPath: Self.idKeyPath])

        managedEntity?.update(updateClosure: { (entity, context) in
            var mutableSelf = self
            updateClosure(&mutableSelf, context)
            entity.populate(groupID: managedEntity?.lfCoreDataEntityGroupIdentifier, with: mutableSelf, context: context)

        }, completeClosure: { updatedEntity in
            completeClosure?(updatedEntity.toPlainModel())
        })
    }

    public func delete(sourceContext: NSManagedObjectContext = CoreDataStore.shared.newBackgroundContext, completeClosure: (() -> Void)?) {
        let managedEntity = ManagedSelfReferencedClass.get(entityID: self[keyPath: Self.idKeyPath], sourceContext: sourceContext)
        managedEntity?.delete(sourceContext: sourceContext, completeClosure: completeClosure)
    }

    public static func delete(with options: DeleteOptions = DeleteOptions(), completeClosure: (() -> Void)?) {
        ManagedSelfReferencedClass.delete(with: options, completeClosure: completeClosure)
    }

    public static func createBatchAndPopulate<PersistableType: Persistable & UniqueIDConstraintKeyPath>(groupID: String? = nil, from plainModels: [PersistableType], insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<[PersistableType], PersistableError>) -> Void)?) {
      ManagedSelfReferencedClass.createBatchAndPopulate(groupID: groupID, from: plainModels, insertionPolicy: insertionPolicy, completeClosure: completeClosure)
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        return ManagedSelfReferencedClass.getAllGroups(sourceContext: sourceContext)
    }
}

extension Service { static var managedModelName = "ManagedService" }

@objc(ManagedService)
final public class ManagedService: PersistableManagedObject, KeyPathable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedService> {
        return NSFetchRequest<ManagedService>(entityName: "ManagedService")
    }

    public static var idKeyPath: WritableKeyPath<ManagedService, String> {
        return \ManagedService.id
    }

    public static var groupIDKeyPath: WritableKeyPath<ManagedService, String?> {
        return \ManagedService.lfCoreDataEntityGroupIdentifier
    }

    @NSManaged @objc(lfCoreDataEntityIsPopulated) public var lfCoreDataEntityIsPopulated: NSNumber

    public var isPopulated: Bool {
        return lfCoreDataEntityIsPopulated as! Bool
    }

    @NSManaged @objc(lfCoreDataEntityGroupIdentifier) public var lfCoreDataEntityGroupIdentifier: String?

    @NSManaged public var id: String
    @NSManaged public var info: String
    @NSManaged public var type: String

    var plainModel: Service?
    var plainCounter = 0
    public var isModelRecursive: Bool { return plainCounter > 5 }

    func toPlainModel(isRecursive: Bool = false) -> Service {
        plainCounter.increment(); defer { plainCounter.decrement() }
        if var model = self.plainModel {
            model.id = self.id
        } else {
            let service = Service(
            id: self.id,
            info: self.info,
            type: self.type
        )
        self.plainModel = service
      }
        return plainModel!
    }

    override public func awakeFromInsert() {
      super.awakeFromInsert()
      self.id = .empty
      self.info = .empty
      self.type = .empty
    }


    @discardableResult
    public func populate<T : Persistable>(groupID: String?, with plainModel: T, context: NSManagedObjectContext) -> Self {
        guard let plainModel = plainModel as? Service else { return self }
        lfCoreDataEntityIsPopulated = NSNumber(booleanLiteral: true)
        lfCoreDataEntityGroupIdentifier = groupID
        id = plainModel.id 
        info = plainModel.info 
        type = plainModel.type 
        return self
    }

    public static func managedKeyPathFrom<EntityType, VariableType>(_ plainKeyPath: KeyPath<EntityType, VariableType>) -> String {
        switch plainKeyPath {
            case \Service.id: return "id"
            case \Service.info: return "info"
            case \Service.type: return "type"
            default: return ""
        }
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        do {
            let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "ManagedService")
            fetchRequest.returnsDistinctResults = true
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.propertiesToFetch = ["lfCoreDataEntityGroupIdentifier"]
            let result = try sourceContext.fetch(fetchRequest).flatMap { $0.allValues }.compactMap { $0 as? String }
            return result
        } catch {
            logError(error)
            return nil
        }
    }
}

extension Service: Persistable, UniqueIDConstraintKeyPath {
    public static var idKeyPath: WritableKeyPath<Service, ManagedService.EntityID> {
        return \Service.id
    }

    public static func count(groupID: String? = nil, using predicate: NSPredicate = .true, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Int {
        return ManagedService.count(groupID: groupID, using: predicate, sourceContext: sourceContext)
    }

    public static func get(entityID: ManagedService.EntityID, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Service? {
        ManagedService.get(entityID: entityID, sourceContext: sourceContext)?.toPlainModel()
    }

    public static func get(groupID: String? = nil, using predicate: NSPredicate, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [Service] {
        ManagedService.get(groupID: groupID, using: predicate, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func getAll(groupID: String? = nil, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [Service] {
        ManagedService.getAll(groupID: groupID, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func create(groupID: String? = nil,
                              updateIfEntityExists: Bool,
                              updateClosure: @escaping (_ entity: inout Service, _ context: NSManagedObjectContext) -> Void,
                              completeClosure: ((Result<Service, PersistableError>) -> Void)?) {
                               ManagedService.create(groupID: groupID,
            updateIfEntityExists: updateIfEntityExists,
            updateClosure: { (entity, context) in
                var plainEntity: Service = entity.toPlainModel()
                updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }, completeClosure: { result in
            switch result {
                case .success(let entity):
                    completeClosure?(.success(entity.toPlainModel()))

                case .failure(let error):
                    completeClosure?(.failure(error))
            }
        })
    }

    public static func createEntity(groupID: String? = nil, entityID: ManagedService.EntityID, context: NSManagedObjectContext) -> Service? {
        ManagedService.createEntity(groupID: groupID, entityID: entityID, context: context)?.toPlainModel()
    }

    public static func createTemporary(groupID: String? = nil, updateClosure: @escaping (inout Service, NSManagedObjectContext) -> Void) {
        ManagedService.createTemporary { (entity, context) in
            var plainEntity = entity.toPlainModel()
            updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }
    }

    public func createAndPopulate(groupID: String? = nil, updateIfEntityExists: Bool = true, insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<Service, PersistableError>) -> Void)?) {
        ManagedService.createBatchAndPopulate(groupID: groupID, from: [self], insertionPolicy: insertionPolicy) { result in
            switch result {
            case .success(let response):
                guard let savedEntity = response.first else { completeClosure?(.failure(.failedToSaveEntityToStore)); return }
                completeClosure?(.success(savedEntity))
            case .failure(let error):
                completeClosure?(.failure(error))
            }
        }
    }

    public func update(updateClosure: @escaping (inout Service, NSManagedObjectContext) -> Void, completeClosure: ((Service) -> Void)?) {
        let managedEntity = ManagedService.get(entityID: self[keyPath: Self.idKeyPath])

        managedEntity?.update(updateClosure: { (entity, context) in
            var mutableSelf = self
            updateClosure(&mutableSelf, context)
            entity.populate(groupID: managedEntity?.lfCoreDataEntityGroupIdentifier, with: mutableSelf, context: context)

        }, completeClosure: { updatedEntity in
            completeClosure?(updatedEntity.toPlainModel())
        })
    }

    public func delete(sourceContext: NSManagedObjectContext = CoreDataStore.shared.newBackgroundContext, completeClosure: (() -> Void)?) {
        let managedEntity = ManagedService.get(entityID: self[keyPath: Self.idKeyPath], sourceContext: sourceContext)
        managedEntity?.delete(sourceContext: sourceContext, completeClosure: completeClosure)
    }

    public static func delete(with options: DeleteOptions = DeleteOptions(), completeClosure: (() -> Void)?) {
        ManagedService.delete(with: options, completeClosure: completeClosure)
    }

    public static func createBatchAndPopulate<PersistableType: Persistable & UniqueIDConstraintKeyPath>(groupID: String? = nil, from plainModels: [PersistableType], insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<[PersistableType], PersistableError>) -> Void)?) {
      ManagedService.createBatchAndPopulate(groupID: groupID, from: plainModels, insertionPolicy: insertionPolicy, completeClosure: completeClosure)
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        return ManagedService.getAllGroups(sourceContext: sourceContext)
    }
}

extension Structs { static var managedModelName = "ManagedStructs" }

@objc(ManagedStructs)
final public class ManagedStructs: PersistableManagedObject, KeyPathable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedStructs> {
        return NSFetchRequest<ManagedStructs>(entityName: "ManagedStructs")
    }

    public static var idKeyPath: WritableKeyPath<ManagedStructs, String> {
        return \ManagedStructs.id
    }

    public static var groupIDKeyPath: WritableKeyPath<ManagedStructs, String?> {
        return \ManagedStructs.lfCoreDataEntityGroupIdentifier
    }

    @NSManaged @objc(lfCoreDataEntityIsPopulated) public var lfCoreDataEntityIsPopulated: NSNumber

    public var isPopulated: Bool {
        return lfCoreDataEntityIsPopulated as! Bool
    }

    @NSManaged @objc(lfCoreDataEntityGroupIdentifier) public var lfCoreDataEntityGroupIdentifier: String?

    @NSManaged public var id: String
    @NSManaged public var name: String

    var plainModel: Structs?
    var plainCounter = 0
    public var isModelRecursive: Bool { return plainCounter > 5 }

    func toPlainModel(isRecursive: Bool = false) -> Structs {
        plainCounter.increment(); defer { plainCounter.decrement() }
        if var model = self.plainModel {
            model.id = self.id
        } else {
            let structs = Structs(
            id: self.id,
            name: self.name
        )
        self.plainModel = structs
      }
        return plainModel!
    }

    override public func awakeFromInsert() {
      super.awakeFromInsert()
      self.id = .empty
      self.name = .empty
    }


    @discardableResult
    public func populate<T : Persistable>(groupID: String?, with plainModel: T, context: NSManagedObjectContext) -> Self {
        guard let plainModel = plainModel as? Structs else { return self }
        lfCoreDataEntityIsPopulated = NSNumber(booleanLiteral: true)
        lfCoreDataEntityGroupIdentifier = groupID
        id = plainModel.id 
        name = plainModel.name 
        return self
    }

    public static func managedKeyPathFrom<EntityType, VariableType>(_ plainKeyPath: KeyPath<EntityType, VariableType>) -> String {
        switch plainKeyPath {
            case \Structs.id: return "id"
            case \Structs.name: return "name"
            default: return ""
        }
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        do {
            let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "ManagedStructs")
            fetchRequest.returnsDistinctResults = true
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.propertiesToFetch = ["lfCoreDataEntityGroupIdentifier"]
            let result = try sourceContext.fetch(fetchRequest).flatMap { $0.allValues }.compactMap { $0 as? String }
            return result
        } catch {
            logError(error)
            return nil
        }
    }
}

extension Structs: Persistable, UniqueIDConstraintKeyPath {
    public static var idKeyPath: WritableKeyPath<Structs, ManagedStructs.EntityID> {
        return \Structs.id
    }

    public static func count(groupID: String? = nil, using predicate: NSPredicate = .true, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Int {
        return ManagedStructs.count(groupID: groupID, using: predicate, sourceContext: sourceContext)
    }

    public static func get(entityID: ManagedStructs.EntityID, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Structs? {
        ManagedStructs.get(entityID: entityID, sourceContext: sourceContext)?.toPlainModel()
    }

    public static func get(groupID: String? = nil, using predicate: NSPredicate, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [Structs] {
        ManagedStructs.get(groupID: groupID, using: predicate, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func getAll(groupID: String? = nil, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [Structs] {
        ManagedStructs.getAll(groupID: groupID, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func create(groupID: String? = nil,
                              updateIfEntityExists: Bool,
                              updateClosure: @escaping (_ entity: inout Structs, _ context: NSManagedObjectContext) -> Void,
                              completeClosure: ((Result<Structs, PersistableError>) -> Void)?) {
                               ManagedStructs.create(groupID: groupID,
            updateIfEntityExists: updateIfEntityExists,
            updateClosure: { (entity, context) in
                var plainEntity: Structs = entity.toPlainModel()
                updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }, completeClosure: { result in
            switch result {
                case .success(let entity):
                    completeClosure?(.success(entity.toPlainModel()))

                case .failure(let error):
                    completeClosure?(.failure(error))
            }
        })
    }

    public static func createEntity(groupID: String? = nil, entityID: ManagedStructs.EntityID, context: NSManagedObjectContext) -> Structs? {
        ManagedStructs.createEntity(groupID: groupID, entityID: entityID, context: context)?.toPlainModel()
    }

    public static func createTemporary(groupID: String? = nil, updateClosure: @escaping (inout Structs, NSManagedObjectContext) -> Void) {
        ManagedStructs.createTemporary { (entity, context) in
            var plainEntity = entity.toPlainModel()
            updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }
    }

    public func createAndPopulate(groupID: String? = nil, updateIfEntityExists: Bool = true, insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<Structs, PersistableError>) -> Void)?) {
        ManagedStructs.createBatchAndPopulate(groupID: groupID, from: [self], insertionPolicy: insertionPolicy) { result in
            switch result {
            case .success(let response):
                guard let savedEntity = response.first else { completeClosure?(.failure(.failedToSaveEntityToStore)); return }
                completeClosure?(.success(savedEntity))
            case .failure(let error):
                completeClosure?(.failure(error))
            }
        }
    }

    public func update(updateClosure: @escaping (inout Structs, NSManagedObjectContext) -> Void, completeClosure: ((Structs) -> Void)?) {
        let managedEntity = ManagedStructs.get(entityID: self[keyPath: Self.idKeyPath])

        managedEntity?.update(updateClosure: { (entity, context) in
            var mutableSelf = self
            updateClosure(&mutableSelf, context)
            entity.populate(groupID: managedEntity?.lfCoreDataEntityGroupIdentifier, with: mutableSelf, context: context)

        }, completeClosure: { updatedEntity in
            completeClosure?(updatedEntity.toPlainModel())
        })
    }

    public func delete(sourceContext: NSManagedObjectContext = CoreDataStore.shared.newBackgroundContext, completeClosure: (() -> Void)?) {
        let managedEntity = ManagedStructs.get(entityID: self[keyPath: Self.idKeyPath], sourceContext: sourceContext)
        managedEntity?.delete(sourceContext: sourceContext, completeClosure: completeClosure)
    }

    public static func delete(with options: DeleteOptions = DeleteOptions(), completeClosure: (() -> Void)?) {
        ManagedStructs.delete(with: options, completeClosure: completeClosure)
    }

    public static func createBatchAndPopulate<PersistableType: Persistable & UniqueIDConstraintKeyPath>(groupID: String? = nil, from plainModels: [PersistableType], insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<[PersistableType], PersistableError>) -> Void)?) {
      ManagedStructs.createBatchAndPopulate(groupID: groupID, from: plainModels, insertionPolicy: insertionPolicy, completeClosure: completeClosure)
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        return ManagedStructs.getAllGroups(sourceContext: sourceContext)
    }
}

extension Work { static var managedModelName = "ManagedWork" }

@objc(ManagedWork)
final public class ManagedWork: PersistableManagedObject, KeyPathable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedWork> {
        return NSFetchRequest<ManagedWork>(entityName: "ManagedWork")
    }

    public static var idKeyPath: WritableKeyPath<ManagedWork, String?> {
        return \ManagedWork.id
    }

    public static var groupIDKeyPath: WritableKeyPath<ManagedWork, String?> {
        return \ManagedWork.lfCoreDataEntityGroupIdentifier
    }

    @NSManaged @objc(lfCoreDataEntityIsPopulated) public var lfCoreDataEntityIsPopulated: NSNumber

    public var isPopulated: Bool {
        return lfCoreDataEntityIsPopulated as! Bool
    }

    @NSManaged @objc(lfCoreDataEntityGroupIdentifier) public var lfCoreDataEntityGroupIdentifier: String?

    @NSManaged public var id: String?
    @NSManaged public var name: String

    var plainModel: Work?
    var plainCounter = 0
    public var isModelRecursive: Bool { return plainCounter > 5 }

    func toPlainModel(isRecursive: Bool = false) -> Work {
        plainCounter.increment(); defer { plainCounter.decrement() }
        if var model = self.plainModel {
            model.id = self.id
        } else {
            let work = Work(
            id: self.id,
            name: self.name
        )
        self.plainModel = work
      }
        return plainModel!
    }

    override public func awakeFromInsert() {
      super.awakeFromInsert()
      self.name = .empty
    }


    @discardableResult
    public func populate<T : Persistable>(groupID: String?, with plainModel: T, context: NSManagedObjectContext) -> Self {
        guard let plainModel = plainModel as? Work else { return self }
        lfCoreDataEntityIsPopulated = NSNumber(booleanLiteral: true)
        lfCoreDataEntityGroupIdentifier = groupID
        // Set autoID
        id = UUID().uuidString
        name = plainModel.name 
        return self
    }

    public static func managedKeyPathFrom<EntityType, VariableType>(_ plainKeyPath: KeyPath<EntityType, VariableType>) -> String {
        switch plainKeyPath {
            case \Work.id: return "id"
            case \Work.name: return "name"
            default: return ""
        }
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        do {
            let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "ManagedWork")
            fetchRequest.returnsDistinctResults = true
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.propertiesToFetch = ["lfCoreDataEntityGroupIdentifier"]
            let result = try sourceContext.fetch(fetchRequest).flatMap { $0.allValues }.compactMap { $0 as? String }
            return result
        } catch {
            logError(error)
            return nil
        }
    }
}

extension Work: Persistable, UniqueIDConstraintKeyPath {
    public static var idKeyPath: WritableKeyPath<Work, ManagedWork.EntityID> {
        return \Work.id
    }

    public static func count(groupID: String? = nil, using predicate: NSPredicate = .true, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Int {
        return ManagedWork.count(groupID: groupID, using: predicate, sourceContext: sourceContext)
    }

    public static func get(entityID: ManagedWork.EntityID, sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> Work? {
        ManagedWork.get(entityID: entityID, sourceContext: sourceContext)?.toPlainModel()
    }

    public static func get(groupID: String? = nil, using predicate: NSPredicate, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [Work] {
        ManagedWork.get(groupID: groupID, using: predicate, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func getAll(groupID: String? = nil, comparisonClauses: [ComparisonClause] = [], sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [Work] {
        ManagedWork.getAll(groupID: groupID, comparisonClauses: comparisonClauses, sourceContext: sourceContext).map { $0.toPlainModel() }
    }

    public static func create(groupID: String? = nil,
                              updateIfEntityExists: Bool,
                              updateClosure: @escaping (_ entity: inout Work, _ context: NSManagedObjectContext) -> Void,
                              completeClosure: ((Result<Work, PersistableError>) -> Void)?) {
                               ManagedWork.create(groupID: groupID,
            updateIfEntityExists: updateIfEntityExists,
            updateClosure: { (entity, context) in
                var plainEntity: Work = entity.toPlainModel()
                updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }, completeClosure: { result in
            switch result {
                case .success(let entity):
                    completeClosure?(.success(entity.toPlainModel()))

                case .failure(let error):
                    completeClosure?(.failure(error))
            }
        })
    }

    public static func createEntity(groupID: String? = nil, entityID: ManagedWork.EntityID, context: NSManagedObjectContext) -> Work? {
        ManagedWork.createEntity(groupID: groupID, entityID: entityID, context: context)?.toPlainModel()
    }

    public static func createTemporary(groupID: String? = nil, updateClosure: @escaping (inout Work, NSManagedObjectContext) -> Void) {
        ManagedWork.createTemporary { (entity, context) in
            var plainEntity = entity.toPlainModel()
            updateClosure(&plainEntity, context)
            entity.populate(groupID: groupID, with: plainEntity, context: context)
        }
    }

    public func createAndPopulate(groupID: String? = nil, updateIfEntityExists: Bool = true, insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<Work, PersistableError>) -> Void)?) {
        ManagedWork.createBatchAndPopulate(groupID: groupID, from: [self], insertionPolicy: insertionPolicy) { result in
            switch result {
            case .success(let response):
                guard let savedEntity = response.first else { completeClosure?(.failure(.failedToSaveEntityToStore)); return }
                completeClosure?(.success(savedEntity))
            case .failure(let error):
                completeClosure?(.failure(error))
            }
        }
    }

    public func update(updateClosure: @escaping (inout Work, NSManagedObjectContext) -> Void, completeClosure: ((Work) -> Void)?) {
        let managedEntity = ManagedWork.get(entityID: self[keyPath: Self.idKeyPath])

        managedEntity?.update(updateClosure: { (entity, context) in
            var mutableSelf = self
            updateClosure(&mutableSelf, context)
            entity.populate(groupID: managedEntity?.lfCoreDataEntityGroupIdentifier, with: mutableSelf, context: context)

        }, completeClosure: { updatedEntity in
            completeClosure?(updatedEntity.toPlainModel())
        })
    }

    public func delete(sourceContext: NSManagedObjectContext = CoreDataStore.shared.newBackgroundContext, completeClosure: (() -> Void)?) {
        let managedEntity = ManagedWork.get(entityID: self[keyPath: Self.idKeyPath], sourceContext: sourceContext)
        managedEntity?.delete(sourceContext: sourceContext, completeClosure: completeClosure)
    }

    public static func delete(with options: DeleteOptions = DeleteOptions(), completeClosure: (() -> Void)?) {
        ManagedWork.delete(with: options, completeClosure: completeClosure)
    }

    public static func createBatchAndPopulate<PersistableType: Persistable & UniqueIDConstraintKeyPath>(groupID: String? = nil, from plainModels: [PersistableType], insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<[PersistableType], PersistableError>) -> Void)?) {
      ManagedWork.createBatchAndPopulate(groupID: groupID, from: plainModels, insertionPolicy: insertionPolicy, completeClosure: completeClosure)
    }

    public static func getAllGroups(sourceContext: NSManagedObjectContext = CoreDataStore.shared.mainContext) -> [String]? {
        return ManagedWork.getAllGroups(sourceContext: sourceContext)
    }
}


// MARK: - CoreDataEntity
struct CoreDataEntity {
    static func getAllCoreDataStoreInstances() -> [CoreDataStore] {
        return [
            CoreDataEntity.coreDataStore_v100
        ]
    }

    static func getAllVersions() -> [ModelVersion] {
        return [
            DataStoreVersion.v100
        ]
    }
}

// MARK: - CoreData Setup
struct CDG {
    static func setup() {
    // Setup and load entity descriptions for all different versions of data store
        CoreDataEntity.loadEntityDescriptions_v100()

        CoreDataStore.saveVersions(CoreDataEntity.getAllVersions())
        CoreDataStore.saveDataStoreVersions(CoreDataEntity.getAllCoreDataStoreInstances())
    }
}


func attributeType(for variableName: String, ofType type: Any.Type) -> NSAttributeType {
    if type is String.Type
        || type is String?.Type {
        return .stringAttributeType
    } else if type is Bool.Type
        || type is Bool?.Type {
        return .booleanAttributeType
    } else if type is Int.Type
        || type is Int?.Type {
        return .integer64AttributeType
    } else if type is Int64.Type
        || type is Int64?.Type {
        return .integer64AttributeType
    } else if type is Double.Type
        || type is Double?.Type {
        return .doubleAttributeType
    } else if type is Data.Type
        || type is Data?.Type {
        return .binaryDataAttributeType
    } else if type is Codable.Type
        || type is Dictionary<String, String>.Type
        || type is Array<String>.Type
        || type is [String]?.Type {
        return .transformableAttributeType
    } else {
        fatalError("Cannot resolve CoreData attribute type for \"\(variableName)\" of type \"\(String(describing: type))\"")
    }
}

private extension NSNumber {
    static let empty = NSNumber(0)
}
private extension Decimal {
    static let empty = NSNumber(0)
}
private extension Int {
    static let empty = NSNumber(0)

    mutating func increment(by: Int = 1) {
        self += by
    }

    mutating func decrement(by: Int = 1) {
        self -= by
    }
}
private extension TimeInterval {
    static let empty = NSNumber(0)
}
private extension Bool {
    static let empty = NSNumber(0)
}
private extension String {
    static let empty = ""
}

extension KeyPath where Value: Collection {
    func map<SubValue>(_ keyPath: KeyPath<Value.Element, SubValue>) -> KeyPath<Value.Element, SubValue> {
        return keyPath
    }
}

public extension Array where Element: Persistable & UniqueIDConstraintKeyPath {
    func createAndPopulate(groupID: String? = nil, updateIfEntityExists: Bool = true, insertionPolicy: BatchInsertionPolicy = .insertOrUpdate, completeClosure: ((Result<[Element], PersistableError>) -> Void)?) {
        Element.createBatchAndPopulate(groupID: groupID, from: self, insertionPolicy: insertionPolicy, completeClosure: completeClosure)
    }
}

extension CoreDataEntity {
    @discardableResult
    static func create(attribute: String, type: NSAttributeType, isOptional: Bool, defaultValue: Any? = nil) -> NSAttributeDescription {
        let description = NSAttributeDescription()
        description.name = attribute
        description.attributeType = type
        if description.attributeType == .transformableAttributeType { description.valueTransformerName = "NSSecureUnarchiveFromData" }
        description.isOptional = isOptional
        if let value = defaultValue { description.defaultValue = value }
        return description
    }
}

extension NSRelationshipDescription {
    func populate(with relationship: String, destination: NSEntityDescription, isArray: Bool, deleteRule: NSDeleteRule, inverseRelationship: NSRelationshipDescription) {
        self.name = relationship
        self.destinationEntity = destination
        if isArray {
            self.minCount = 0
            self.maxCount = 0
            self.isOrdered = true
        } else {
            self.maxCount = 1
        }
        self.deleteRule = deleteRule
        self.inverseRelationship = inverseRelationship
    }
}
