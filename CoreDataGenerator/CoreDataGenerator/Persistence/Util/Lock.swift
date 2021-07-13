//
//  Lock.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import Foundation

// MARK: Public API

/**
 Locks on the passed object and executes given closure.
 The lock persists following the lifetime (scope) of the closure and is automatically released after the closure has finished executing.
 */
public func lock(_ sender: AnyObject, _ closure: () -> Void) {
    let (lock, didLock) = LockManager.shared.lock(sender)
    defer {
        if didLock {
            LockManager.shared.unlock(lock)
        }
    }
    closure()
}

/**
 Locks on the passed object and executes given closure.
 The lock persists following the lifetime (scope) of the closure and is automatically released after the closure has finished executing.
*/
public func lock<T>(_ sender: AnyObject, _ closure: () -> (T)) -> T {
    let (lock, didLock) = LockManager.shared.lock(sender)
    defer {
        if didLock {
            LockManager.shared.unlock(lock)
        }
    }
    let result = closure()
    return result
}

// MARK: Implementation

fileprivate class Lock {
    let semaphore: DispatchSemaphore
    let pointer: UnsafeRawPointer
    let threadHandle: UnsafeMutablePointer<_opaque_pthread_t>

    init(semaphore: DispatchSemaphore, pointer: UnsafeRawPointer, threadHandle: UnsafeMutablePointer<_opaque_pthread_t>) {
        self.semaphore = semaphore
        self.pointer = pointer
        self.threadHandle = threadHandle
    }
}

fileprivate class LockManager {
    let metaLockSemaphore = DispatchSemaphore(value: 1)
    var locks: [UnsafeRawPointer: Lock] = [:]

    subscript(_ pointer: UnsafeRawPointer) -> Lock? {
        get {
            return locks[pointer]
        }
        set {
            locks[pointer] = newValue
        }
    }

    static let shared = LockManager()

    func lock(_ object: AnyObject) -> (Lock, Bool) {
        metaLockSemaphore.wait()
        let (lock, shouldLock) = getLock(for: object)
        metaLockSemaphore.signal()

        if shouldLock {
            lock.semaphore.wait()
        }
        return (lock, shouldLock)
    }

    func unlock(_ lock: Lock) {
        let lockCount = lock.semaphore.signal()
        if lockCount == 0 {
            metaLockSemaphore.wait()
            locks[lock.pointer] = nil
            metaLockSemaphore.signal()
        }
    }

    private func getLock(for object: AnyObject) -> (Lock, Bool) {
        let pointer = Unmanaged.passUnretained(object).toOpaque()
        let lockManager = LockManager.shared
        var shouldLock = true
        if lockManager[pointer] == nil {
            lockManager[pointer] = Lock(semaphore: DispatchSemaphore(value: 1), pointer: pointer, threadHandle: currentThreadHandle())
        } else {
            if currentThreadHandle() == lockManager[pointer]!.threadHandle {
                shouldLock = false
                let debugMessage = "(❗) Attempted to acquire lock twice from same thread (❗) Follow call stack for more info."
                let stackTrace = Thread.callStackSymbols.joined(separator: "\n")
                logDebug("\(debugMessage)\n\(stackTrace)")
            }
        }
        return (lockManager[pointer]!, shouldLock)
    }

    private func currentThreadHandle() -> UnsafeMutablePointer<_opaque_pthread_t> {
        return pthread_self()
    }
}
