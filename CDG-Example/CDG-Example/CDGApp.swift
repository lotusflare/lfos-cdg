//
//  CDGApp.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import SwiftUI
import CoreDataGenerator

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        Logging.setup(loggerVerbosityLevel: .warning)
        CDG.setup()

        /*
         --- Step 5 ---
         While performing manual migration we have an option to make changes to the mapping model.
         Below is an example of how we can set entityMigrationPolicyClassName to our model so we can migrate data.
         This is just an example for our case, you will have to determine what changes should be made for your case...

         As you can see we are setting closure to v200, meaning that this mapping model will be used when migrating from v100 to v200...
        */

//        CoreDataEntity.coreDataStore_v200.mappingModel = { mappingModel in
//            // Find model `Migration` model
//            let migrationModel = mappingModel
//                .entityMappings
//                .filter { $0.sourceEntityName == Migration.managedModelName }
//                .first
//
//            // Set the entity migration policy
//            migrationModel?.entityMigrationPolicyClassName = MigrationEntityMigrationPolicy.className
//        }

        /*
         --- Step 6 ---
         We have two ways to perform the migration.
         - recreateStoreOnHeavyWeightMigration (It will delete ALL current data, then the migration is not needed)
         - resolveMigrationManually (Manually migrate data)

         By default 'recreateStoreOnHeavyWeightMigration' is set, so first, we need to change that. Just uncomment bellow part.
        */
//        CoreDataStore.shared.setup(with: CoreDataConfig(repositoryType: .sqlite,
//                                                        modelType: .defaultModel,
//                                                        migrationPolicy: .resolveMigrationManually))

        /*
         --- Step 7 ---
         Just run the app and that is it! Good luck...
        */
        return true
    }
}

@main
struct CDGApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            MainMenuView()
        }
    }
}

    /*
     --- Step 4 ---
     Introduce a new model version, also set it as a target model version that should be in use. Just add annotation 'targetModelVersion'. Have in mind that annotation should be set to only one version!

     After this, run the 'Generate' scheme. This will generate the necessary code for the updated model.
    */
//extension DataStoreVersion {
//    /// sourcery: targetModelVersion
//    public static let v200 = ModelVersion(major: 2, minor: 0, patch: 0)
//}
