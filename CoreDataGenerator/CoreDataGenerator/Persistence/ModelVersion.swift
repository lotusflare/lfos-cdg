//
//  Version.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import Foundation

public enum DataStoreVersion {
    public static let v100 = ModelVersion(major: 1, minor: 0, patch: 0)
}

public struct ModelVersion: Comparable, Codable {
    let major: Int
    let minor: Int
    let patch: Int

    public init(major: Int, minor: Int, patch: Int) {
        self.major = major
        self.minor = minor
        self.patch = patch
    }

    public init(string: String) throws {
        let splited = string.split(separator: ".").compactMap { Int($0) }
        guard splited.count == 3 else { throw VersionError.invalidFormat }
        self.major = splited[0]
        self.minor = splited[1]
        self.patch = splited[2]
    }

    enum VersionError: Error {
        case invalidFormat
    }

    func getFormatted() -> String {
        return "\(major).\(minor).\(patch)"
    }

    public static func < (lhs: ModelVersion, rhs: ModelVersion) -> Bool {
        guard lhs.major == rhs.major else {
            return lhs.major < rhs.major
        }

        guard lhs.minor == rhs.minor else {
            return lhs.major < rhs.major
        }

        guard lhs.patch == rhs.patch else {
            return lhs.major < rhs.major
        }

        return false
    }

    func nextVersion() -> ModelVersion? {
        let allCases = CoreDataStore.allVersions
        guard let index = allCases.firstIndex(of: self) else { return nil }
        let nextIndex = index + 1
        guard allCases.count > nextIndex else { return nil }
        return allCases[nextIndex]
    }
}
