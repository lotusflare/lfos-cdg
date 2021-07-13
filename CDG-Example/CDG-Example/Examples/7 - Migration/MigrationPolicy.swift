//
//  MigrationPolicy.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import CoreData
import CoreDataGenerator

// MARK: - MigrationEntityMigrationPolicy
class MigrationEntityMigrationPolicy: NSEntityMigrationPolicy {

    override func createDestinationInstances(forSource source: NSManagedObject,
                                             in mapping: NSEntityMapping,
                                             manager: NSMigrationManager) throws {

        try super.createDestinationInstances(forSource: source, in: mapping, manager: manager)
        let key = "otherValue" // Name of newly added property

        // Get object from destination model and set the default value
        if let destinationModel = manager.destinationInstances(forEntityMappingName: mapping.name, sourceInstances: [source]).first {
            // If the value is already set, just return. There is no need to set the default value
            guard (destinationModel.value(forKey: key) as? Int) == nil else { return }
            destinationModel.setValue(44444, forKey: key)
            logDebug("Model with ID: \(destinationModel.value(forKey: "id") as? String) successfully migrated")
        }
    }
}
