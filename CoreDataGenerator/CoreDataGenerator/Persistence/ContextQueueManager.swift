//
//  ContextQueueManager.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import Foundation
import CoreData

/// `ContextQueueManager` is used to synchronize incoming parsing, a global queue is made and
/// every parse is must go through the queue to be saved in the `NSPersistantStore`.
/// This way we avoid an entity being parsed without the knowledge of all the `NSManagedContexts` which already contain
/// that entity, and will result in a conflict on save.
class ContextQueueManager {
    private init() {}

    static let shared: ContextQueueManager = ContextQueueManager()

    /// `OperationQueue` which guarantees that context are going to save one by one
    lazy private var operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .background
        return queue
    }()
    
    private let serialExecutionQueue = DispatchQueue(label: "ContextQueueManager.execution.queue")

    /// Method which adds a `NSManagedContext` to the queue. Closures are used to make changes to the context, and
    /// to notify that the context has finished saving.
    ///
    /// - Parameters:
    ///   - context: `NSManagedContext` to add to the queue.
    ///   - dataModificationClosure: Closure which will contain changes to the context.
    ///   - dataPersistedCompleteClosure: Closure which will be used to notify that the context has saved.
    func push(context: NSManagedObjectContext,
              dataModificationClosure: @escaping () -> Void,
              dataPersistedCompleteClosure: @escaping () -> Void) {
        
        serialExecutionQueue.sync {
            operationQueue.addOperation {
                context.refreshAllObjects()
                dataModificationClosure()
                if context.hasChanges {
                    do {
                        try context.save()

                    } catch {
                        logError("Context failed to save with error:\n\(error)\n\n")
                    }
                }
                dataPersistedCompleteClosure()
            }
        }
    }
}
