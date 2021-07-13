//
//  StructsExample.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import SwiftUI
import CoreDataGenerator

// MARK: - Example of struct
/// sourcery: ManagedObject
struct Structs: Identifiable {
    static func == (lhs: Structs, rhs: Structs) -> Bool {
        return lhs.name == rhs.name
    }
    /// sourcery: primaryKey
    var id: String
    let name: String
}

// MARK: - ViewModel
class StructsViewModel: ObservableObject {
    @Published var elements: [Structs] = []
}

struct StructsExample: View {
    static var counter = 0
    @StateObject var viewModel = StructsViewModel()

    var body: some View {
        VStack {
            Text("Structs are supported by CDG. This is an example that they can be saved to CoreData. Please take a look at the code also.")

            Button("Create a row") { insertRow() }.buttonStyle(FilledButton())

            List(viewModel.elements) { element in
                VStack(alignment: .leading) {
                    HStack(spacing: 0) {
                        Text("Row name: ")
                            .font(.subheadline)
                        Text(element.name)
                            .fontWeight(.bold)
                            .font(.caption)
                    }

                    HStack(spacing: 0) {
                        Text("ID: ")
                            .font(.subheadline)
                        Text(element.id)
                            .fontWeight(.bold)
                            .font(.caption)
                    }
                }
            }.overlay(Group {
                if viewModel.elements.isEmpty {
                    Text("Currently, there are no rows in CoreData.")
                        .fontWeight(.bold)
                } else {
                    EmptyView()
                }
            })
        }
        .padding()
        .navigationBarTitle(Text("Structs"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            Structs.delete {
                loadAllEntries()
            }
        }, label: {
            Text("Clear data")
        }))
        .onAppear(perform: {
            loadAllEntries()
        })

    }

    func updateUIFromResult(_ result: Result<Structs, PersistableError>) {
        switch result {
        case .success:
            loadAllEntries()
        case .failure(let error):
            logError(error)
        }
    }
}

// MARK: - Inserting rows
extension StructsExample {
    func insertRow() {
        Structs(id: UUID().uuidString, name: "Struct \(StructsExample.counter)")
            .createAndPopulate { result in
                StructsExample.counter += 1
                self.updateUIFromResult(result)
            }
    }
}

// MARK: - Fetching rows
extension StructsExample {
    func loadAllEntries() {
        viewModel.elements = Structs.getAll()
    }
}
