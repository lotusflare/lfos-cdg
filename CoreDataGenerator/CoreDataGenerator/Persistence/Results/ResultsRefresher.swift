//
//  ResultsRefresher.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import Foundation

import CoreData

/// An override of CoreData's ChangeType, so that upper level parts of the application doesn't have to import CoreData
///
/// - insert: Entity was inserted
/// - delete: Entity was deleted
/// - move: Entity has moved
/// - update: Entity was updated
public enum ChangeType: UInt {
    case insert
    case delete
    case move
    case update
}

public typealias ChangesBlock<ObjectType: PersistableManagedObject>
    = ([ResultsRefresher<ObjectType>.Change], RefreshingResults<ObjectType>?) -> Void

/// ResultsRefresher is a `NSFetchedResultsControllerDelegate` which accumulates changes, and instead of firing
/// those changes sequentially it triggers a closure with all the changes that were made.
public class ResultsRefresher<EntityType: PersistableManagedObject>: NSObject, NSFetchedResultsControllerDelegate {

    /// Change struct which contains all the information about a single change
    public struct Change {

        /// Change type
        public var type: ChangeType

        /// Index path used for deletion, update, or it's a source of move
        public var indexPath: IndexPath?

        /// Destination of insertion or move
        public var newIndexPath: IndexPath?

        /// Changed entity
        public var object: EntityType
    }

    /// Array which holds the changes. Reset on `controllerWillChangeContent(_:)`.
    private var changes: [Change] = []

    /// Closure which will be triggered on `controllerDidChangeContent(_:)`.
    private var accumulatedChanges: ([Change], RefreshingResults<EntityType>) -> Void

    weak var results: RefreshingResults<EntityType>?

    /// Init where `accumulatedChanges` closure is passed
    ///
    /// - Parameters:
    ///     - results: Results reference which will hold a new state when changes occur.
    ///     - accumulatedChanges: Closure which will be triggered on `controllerDidChangeContent(_:)`.
    init(results: RefreshingResults<EntityType>,
         accumulatedChanges: @escaping ([Change], RefreshingResults<EntityType>) -> Void) {
        self.accumulatedChanges = accumulatedChanges
        self.results = results
    }

    public func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        changes = []
    }

    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let results = results else { return }
        accumulatedChanges(changes, results)
    }

    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                           didChange anObject: Any,
                           at indexPath: IndexPath?,
                           for type: NSFetchedResultsChangeType,
                           newIndexPath: IndexPath?) {

        let changeType: ChangeType
        switch type {
        case .insert: changeType = .insert
        case .delete: changeType = .delete
        case .move: changeType = .move
        case .update: changeType = .update
        @unknown default: changeType = .update
        }

        if let object = anObject as? EntityType {
            changes.append(Change(type: changeType,
                                  indexPath: indexPath,
                                  newIndexPath: newIndexPath,
                                  object: object))
        }
    }
}
