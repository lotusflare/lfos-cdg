//
//  SelfReferencedClassExample.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import SwiftUI
import CoreDataGenerator

// MARK: - Example of self referenced class
/// sourcery: ManagedObject
final class SelfReferencedClass: Identifiable {
    /// sourcery: primaryKey
    var id: String
    let name: String
    /// sourcery: recursive
    let child: SelfReferencedClass?

    init(id: String, name: String, child: SelfReferencedClass?) {
        self.id = id
        self.name = name
        self.child = child
    }
}

// MARK: - ViewModel
class SelfReferencedClassViewModel: ObservableObject {
    @Published var elements: [SelfReferencedClass] = []
}

struct SelfReferencedClassExample: View {
    static var counter = 0
    @StateObject var viewModel = SelfReferencedClassViewModel()

    var body: some View {
        VStack {
            Text("The self-references in classes are supported by CDG. This is an example that they can be saved to CoreData. Please take a look at the code also. Currently, we are only supporting final classes!")

            HStack(spacing: 6) {
                Button("Create a self\nreferenced row") { insertSelfReferencedRow() }.buttonStyle(FilledButton())
                Button("Create a regular\nrow") { insertRegularRow() }.buttonStyle(FilledButton())
            }

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

                    if let childName = element.child?.name {
                        HStack(spacing: 0) {
                            Text("self-referenced class name: ")
                                .font(.subheadline)
                            Text(childName)
                                .font(.subheadline)
                                .fontWeight(.bold)
                        }
                    } else {
                        Text("Missing self referenced class!")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                }
            }.onAppear(perform: {
                loadAllEntries()
            })
            .overlay(Group {
                if viewModel.elements.isEmpty {
                    Text("Currently, there are no rows in CoreData.")
                        .fontWeight(.bold)
                } else {
                    EmptyView()
                }
            })
        }
        .padding()
        .navigationBarTitle(Text("Self Referenced Class"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            SelfReferencedClass.delete {
                loadAllEntries()
            }
        }, label: {
            Text("Clear data")
        }))

    }

    func updateUIFromResult(_ result: Result<SelfReferencedClass, PersistableError>) {
        switch result {
        case .success:
            loadAllEntries()
        case .failure(let error):
            logError(error)
        }
    }
}

// MARK: - Inserting rows
extension SelfReferencedClassExample {
    func insertSelfReferencedRow() {
        SelfReferencedClass(id: UUID().uuidString,
                            name: "Class \(SelfReferencedClassExample.counter)",
                            child: SelfReferencedClass(id: UUID().uuidString,
                                                       name: "Child class \(SelfReferencedClassExample.counter + 1)",
                                                       child: nil))
            .createAndPopulate { result in
                SelfReferencedClassExample.counter += 2
                self.updateUIFromResult(result)
            }

    }

    func insertRegularRow() {
        SelfReferencedClass(id: UUID().uuidString,
                            name: "Class \(SelfReferencedClassExample.counter)",
                            child: nil)
            .createAndPopulate { result in
                SelfReferencedClassExample.counter += 1
                self.updateUIFromResult(result)
            }
    }
}

// MARK: - Fetching rows
extension SelfReferencedClassExample {
    func loadAllEntries() {
        viewModel.elements = SelfReferencedClass.getAll()
    }
}
