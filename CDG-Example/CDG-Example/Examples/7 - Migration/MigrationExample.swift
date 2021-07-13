//
//  MigrationExample.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import SwiftUI
import CoreDataGenerator

/*
 --- Step 2 ---
 For the second step uncomment 'otherValue' property in the Migration model. This will induce a migration later on
 */

/// sourcery: ManagedObject
struct Migration: Hashable, Identifiable {
    /// sourcery: primaryKey
    var id: String = UUID().uuidString
//    var otherValue: Int = 0
}

class MigrationViewModel: ObservableObject {
    @Published var elements: [Migration] = []
}

struct MigrationExample: View {
    static var counter = 0
    @StateObject var viewModel = MigrationViewModel()

    var body: some View {
        Group {
            VStack {
                Text("--- Step 1 ---")
                    .bold()
                    .multilineTextAlignment(.center)

                Text("To show how to perform a hevyweight migration, you will need to follow couple of steps and make some changes in the code.\nFirst of all feel free to insert couple of rows in the CoreData, after that go to ")
                +
                Text("'MigrationExample'")
                    .bold()
                    +
                Text(" file and follow next steps...")
                Button("Insert row") { insertRow() }.buttonStyle(FilledButton())

            }.padding([.top, .leading, .trailing])
            List(viewModel.elements) { element in
                VStack(alignment: .leading) {
                    Text("ID: ")
                        .font(.subheadline)
                        +
                    Text(element.id)
                        .fontWeight(.bold)
                        .font(.caption)
                    /*
                     --- Step 3 ---
                     Uncomment below lines so we can see later on in the app if the data was successfully migrated
                    */

//                    Text("otherValue: ")
//                        .font(.subheadline)
//                        +
//                    Text("\(element.otherValue)")
//                        .fontWeight(.bold)
//                        .font(.caption)
                }
            }
        }
        .navigationBarTitle("Migration", displayMode: .inline)
        .onAppear { loadAllEntries() }
        .navigationBarItems(trailing: Button(action: {
            Migration.delete {
                viewModel.elements.removeAll()
            }
        }, label: {
            Text("Clear data")
        }))
    }

    func insertRow() {
        Migration()
            .createAndPopulate { result in
                updateUIFromResult(result.map { [$0] })
            }
    }

    func removeAllEntries() {
        Migration.delete(completeClosure: nil)
        loadAllEntries()
    }

    func loadAllEntries() {
        viewModel.elements = Migration.getAll()
    }

    func updateUIFromResult(_ result: Result<[Migration], PersistableError>) {
        switch result {
        case .success:
            loadAllEntries()
        case .failure(let error):
            logError(error)
        }
    }
}
