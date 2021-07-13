//
//  Results.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import CoreData

public class Results<EntityType: Persistable & UniqueIDConstraintKeyPath> {
    public private(set) var context: NSManagedObjectContext = CoreDataStore.shared.mainContext
    public private(set) var predicate: NSPredicate?
    public private(set) var sortDescriptors: [ComparisonClause] = [.ascending(EntityType.idKeyPath)]
    
    public internal(set) var objects: [EntityType] = []
    
    /// Initializer which fetches all entities of type `EntityType` and sorts them by `idKeyPath`
    /// - Parameter context: source context
    public init(context: NSManagedObjectContext = CoreDataStore.shared.mainContext) {
        self.context = context
        refetch()
    }
    
    /// Filters previously fetched results.
    /// - Parameter predicate: Predicate which defines rules for filtering
    /// - Example:
    /// ```Result().filterBy(\User.birthDate <= Date())```
    /// - Returns: Instance of Results.
    @discardableResult
    public func filterBy(_ predicate: NSPredicate, groupID: String? = nil) -> Self {
        self.predicate = predicate
        refetch(groupID: groupID)
        return self
    }
    
    /// Sorts previously fetched results.
    /// - Parameter comparisons: Instances of `ComparisonClause` which can be either `.ascending` or `.descending`
    /// - Example:
    /// ```Results().sortBy(.ascending(\User.firstName), .descending(\User.lastName))```
    /// - Returns: Instance of Results.
    @discardableResult
    public func sortBy(_ comparisons: ComparisonClause..., groupID: String? = nil) -> Self {
        self.sortDescriptors = comparisons
        refetch(groupID: groupID)
        return self
    }
    
    func refetch(groupID: String? = nil) {
        objects = EntityType.get(groupID: groupID, using: predicate ?? .true, comparisonClauses: sortDescriptors, sourceContext: context)
    }
}

/// Wrapper around `NSFetchedResultsController` which is used to group changes, and to build helper methods for the
/// `NSFetchedResultsController`. The changes are grouped and passed using `ResultsRefresher`
/// which is used as a `NSFetchedResultsController` delegate, using a closure
/// when a NSFetchedResultsDelegate has triggered `controllerDidChangeContent(_:)`
public class RefreshingResults<EntityType: PersistableManagedObject>: Results<EntityType> {
    public var fetchedResultsController: NSFetchedResultsController<EntityType>!
    public var refresher: ResultsRefresher<EntityType>?
    
    /// Used to register for changes which happen on `NSManagedObjectContext`  which is specified in Results init. When changes occur, `closure` is triggered and accumulated changes are passed.
    /// Changes contain a change `type` (insert, update, move, delete), `newIndexPath` which will be not nil in case of insert and move types, `indexPath` which will not be nil in case of update, move and delete, and object of type `EntityType`.
    /// - Important: If the Results instance is not saved outside of the scope it was instanced in, `ResultsRefresher` closure wil be deallocated with `Results`, and changes won't occur.
    /// - Parameters:
    ///     - closure: Closure which will be triggered when changes on context happen
    ///     - changes: Array of type `Change` defined in `ResultsRefresher` which contain  a change `type` (insert, update, move, delete), `newIndexPath` which will be not nil in case of insert and move types, `indexPath` which will not be nil in case of update, move and delete, and object of type `EntityType`.
    /// - Returns: Instance of Results.
    @discardableResult
    public func registerForChanges(closure: @escaping (_ changes: [ResultsRefresher<EntityType>.Change]) -> Void) -> Self{
        refresher = ResultsRefresher<EntityType>(results: self, accumulatedChanges: { (changes, _) in
            closure(changes)
        })
        
        fetchedResultsController.delegate = refresher
        return self
    }
    
    /// Converts results object to an array of `EntityType`
    public override var objects: [EntityType] {
        set {}
        get { fetchedResultsController.fetchedObjects ?? [] }
    }

    /// Flag which indicates if the collection is empty
    public var isEmpty: Bool {
        return numberOfSections == 0
    }

    /// Number of sections in the fetched results controller. Defaults to zero.
    public var numberOfSections: Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    /// Number of objects in first section
    public var numberOfObjectsInFirstSection: Int {
        return fetchedResultsController.sections?[0].objects?.count ?? 0
    }

    /// Objects in first section of fetched results controller
    public var objectsInFirstSection: [EntityType] {
        return objects(for: 0)
    }

    /// Number of objects for a certain section.
    ///
    /// - Parameter section: Specified which section's count should the function return.
    /// - Returns: Number of objects in a certain section. Defaults to zero.
    public func numberOfObjects(in section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections[section].objects?.count ?? 0
        }
        return 0
    }

    /// Returns an object specified by an `IndexPath`
    ///
    /// - Parameter indexPath: Location in `NSFetchedResultsController` which holds the entity
    /// - Returns: Entity instance on `indexPath`
    public func object(at indexPath: IndexPath) -> EntityType {
        return fetchedResultsController.object(at: indexPath)
    }

    /// Returns an array of object in a certain section
    ///
    /// - Parameter section: Section which defines which objects to return.
    /// - Returns: An array of objects for a `section`. Defaults to an empty array.
    public func objects(for section: Int) -> [EntityType] {
        if let sections = fetchedResultsController.sections, let objects = sections[section].objects as? [EntityType] {
            return objects
        }
        return []
    }
    
    override func refetch(groupID: String? = nil) {
        let fetchRequest = NSFetchRequest<EntityType>(entityName: "\(EntityType.self)")
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors.map { $0.sortDescriptor }
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: context,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        do {
            try fetchedResultsController.performFetch()

        } catch {
            logError("Results failed to fetch entities of type:\(EntityType.self)")
        }
    }
}
