//
//  Logging.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import Foundation

/**
 ### **Controls the amount and frequency of logging messages.**

 | LoggerVerbosityLevel |                   Description                  |
 |:--------------------:|------------------------------------------------|
 |         none         | Nothing will be logged                         |
 |         error        | Log only errors                                |
 |        warning       | Log errors and warnings                        |
 |         debug        | Log errors, warnings and useful debugging info |
 |        verbose       | Log almost each and every action               |
 */
public enum LoggerVerbosityLevel: Int {
    /// Nothing will be logged
    case none
    /// Log only errors
    case error
    /// Log errors and warnings
    case warning
    /// Log errors, warnings and useful debugging info
    case debug
    /// Log almost each and every action
    case verbose
}

enum MessageLevel: String {
    case debug = "🟢🟢🟢"
    case verbose = "🔵🔵🔵"
    case warning = "🟠🟠🟠"
    case error = "🔴🔴🔴"
}

public typealias LogVerbosity = LoggerVerbosityLevel
public typealias DestinationLogHandler = (String, LogVerbosity) -> Void

public protocol Logger {
    func log(_ message: String)
}

public class DefaultLogger: Logger {
    public static let shared = DefaultLogger()

    private init() { }


    public func log(_ message: String) {
        print(message)
    }
}

public class Logging {

    // MARK: Data definitions

    public struct Destinations: OptionSet, Hashable {
        public let rawValue: Int
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
    /**
     Adding new destinations should be done through extensions and should look like the following:
     public extension Logging.Destinations {
     static let randomDestinationFirst = Logging.Destinations(rawValue: 1 << 0)
     static let randomDestinationSecond = Logging.Destinations(rawValue: 1 << 1)
     }
     * Pay attention to the right shift operator. Make sure it is unique throughout all of the extensions.
     */

    // MARK: Properties

    fileprivate static let UninitializedErrorMessage = "Logging was not initialized before invoking logging functions. Please initialize logging by calling `Logger.setup(loggerVerbosityLevel: LoggerVerbosityLevel)`"
    static var loggerVerbosityLevel: LoggerVerbosityLevel!
    public static var defaultLogDestinations: Destinations = []
    static var logDestinationDict: [Destinations: DestinationLogHandler] = [:]
    static var logger: Logger!

    // MARK: Methods

    public static func setup(loggerVerbosityLevel: LoggerVerbosityLevel, logger: Logger = DefaultLogger.shared) {
        Logging.loggerVerbosityLevel = loggerVerbosityLevel
        Logging.logger = logger


    }

    public static func addDestination(destination: Logging.Destinations, destinationLogHandler: @escaping DestinationLogHandler) {
        logDestinationDict[destination] = destinationLogHandler
    }
}

// MARK: - Public Logging Functions

public func logError(_ error: Error, sender: Any? = nil, file: String = #file, line: Int = #line, function: String = #function, logDestinations: Logging.Destinations = Logging.defaultLogDestinations) {
    guard Logging.loggerVerbosityLevel != nil else { die(); return }
    guard Logging.loggerVerbosityLevel.rawValue >= LoggerVerbosityLevel.error.rawValue else { return }
    let formattedMessage = format(messageLevel: .error, message: String(describing: error), sender: sender, file: file, line: line, function: function)
    Logging.logger.log(formattedMessage)
    logToDestinations(logDestinations, .error, formattedMessage)
}

public func logError(_ message: String, sender: Any? = nil, file: String = #file, line: Int = #line, function: String = #function, logDestinations: Logging.Destinations = Logging.defaultLogDestinations) {
    guard Logging.loggerVerbosityLevel != nil else { die(); return }
    guard Logging.loggerVerbosityLevel.rawValue >= LoggerVerbosityLevel.error.rawValue else { return }
    let formattedMessage = format(messageLevel: .error, message: message, sender: sender, file: file, line: line, function: function)
    Logging.logger.log(formattedMessage)
    logToDestinations(logDestinations, .error, formattedMessage)
}

public func logWarning(_ message: String, sender: Any? = nil, file: String = #file, line: Int = #line, function: String = #function, logDestinations: Logging.Destinations = Logging.defaultLogDestinations) {
    guard Logging.loggerVerbosityLevel != nil else { die(); return }
    guard Logging.loggerVerbosityLevel.rawValue >= LoggerVerbosityLevel.warning.rawValue else { return }
    let formattedMessage = format(messageLevel: .warning, message: message, sender: sender, file: file, line: line, function: function)
    Logging.logger.log(formattedMessage)
    logToDestinations(logDestinations, .warning, formattedMessage)
}

public func logDebug(_ message: String, sender: Any? = nil, file: String = #file, line: Int = #line, function: String = #function, logDestinations: Logging.Destinations = Logging.defaultLogDestinations) {
    guard Logging.loggerVerbosityLevel != nil else { die(); return }
    guard Logging.loggerVerbosityLevel.rawValue >= LoggerVerbosityLevel.debug.rawValue else { return }
    let formattedMessage = format(messageLevel: .debug, message: message, sender: sender, file: file, line: line, function: function)
    Logging.logger.log(formattedMessage)
    logToDestinations(logDestinations, .debug, formattedMessage)
}

public func logVerbose(_ message: String, sender: Any? = nil, file: String = #file, line: Int = #line, function: String = #function, logDestinations: Logging.Destinations = Logging.defaultLogDestinations) {
    guard Logging.loggerVerbosityLevel != nil else { die(); return }
    guard Logging.loggerVerbosityLevel.rawValue >= LoggerVerbosityLevel.verbose.rawValue else { return }
    let formattedMessage = format(messageLevel: .verbose, message: message, sender: sender, file: file, line: line, function: function)
    Logging.logger.log(formattedMessage)
    logToDestinations(logDestinations, .verbose, formattedMessage)
}

// MARK: - Private Functions

private func format(messageLevel: MessageLevel, message: String, sender: Any?, file: String, line: Int, function: String) -> String {
    var callerString = ""
    if let sender = sender {
        callerString = "[\(String(describing: sender))]"
    }
    return "{\(file):\(line) - \(function)}\n\(messageLevel.rawValue) \(callerString) \(message) \(messageLevel.rawValue)"
}

private func logToDestinations(_ destinations: Logging.Destinations, _ logVerbosity: LogVerbosity, _ message: String) {
    guard destinations.rawValue > 0 else { return }

    for destination in destinations.containedElements {
        Logging.logDestinationDict[destination]?(message, logVerbosity)
    }
}

private func die() {
    print(Logging.UninitializedErrorMessage)
}

