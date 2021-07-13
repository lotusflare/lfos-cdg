//
//  NestedClassExample.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import SwiftUI
import CoreDataGenerator

/// sourcery: ManagedObject
final class ParentNestedClass: Identifiable {
    /// sourcery: primaryKey
    var id: String
    let name: String
    var child: ChildNestedClass?

    init(id: String, name: String, child: ChildNestedClass?) {
        self.id = id
        self.name = name
        self.child = child
    }
}

/// sourcery: ManagedObject
final class ChildNestedClass: Identifiable {
    /// sourcery: primaryKey
    var id: String
    let name: String

    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

// MARK: - ViewModel
class NestedClassViewModel: ObservableObject {
    @Published var mainElements: [ParentNestedClass] = []
    @Published var nestedElements: [ChildNestedClass] = []
}

struct NestedClassExample: View {
    static var counter = 0
    @State var lastCreated: ParentNestedClass?
    @StateObject var viewModel = NestedClassViewModel()
    @State var showMain: Bool = true

    var body: some View {
        VStack {
            Text("Nested classes are supported by CDG. This is an example that they can be saved to CoreData. Currently, we are only supporting final classes! Please take a look at the code also.")

            Button("Create a row") { insertRow() }.buttonStyle(FilledButton())

            if let createdRow = lastCreated {
                DetailsRow(name: createdRow.name, id: createdRow.id, childName: createdRow.child?.name ?? "Missing child!", parentName: nil)
            } else {
                Text("Hint: Tapp above button to create a row!⬆️⬆️⬆️")
                    .font(.subheadline)
                    .fontWeight(.bold)
            }

            HStack(spacing: 6) {
                Button("Show parent rows") { showMain = true; loadMainEntries() }.buttonStyle(FilledButton())
                Button("Show nested rows") { showMain = false; loadNestedEntries() }.buttonStyle(FilledButton())
            }

            if showMain {
                CustomList(viewModel.mainElements) { element in
                    DetailsRow(name: element.name, id: element.id, childName: element.child?.name ?? "Missing child!", parentName: nil)
                } emptyListView: {
                    Text("Currently, there are no parent rows saved in CoreData.")
                }
            } else {
                CustomList(viewModel.nestedElements) { element in
                    DetailsRow(name: element.name, id: element.id, childName: nil)
                } emptyListView: {
                    Text("Currently, there are no nested rows saved in CoreData.")
                }
                
            }
        }
        .onAppear(perform: {
            loadMainEntries()
        })
        .padding()
        .navigationBarTitle(Text("Nested classes"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            ChildNestedClass.delete(completeClosure: nil)
            ParentNestedClass.delete {
                viewModel.mainElements = []
                viewModel.nestedElements = []
            }
        }, label: {
            Text("Clear data")
        }))
    }
}

// MARK: - Inserting rows
extension NestedClassExample {
    func insertRow() {
        ParentNestedClass(id: UUID().uuidString,
                          name: "parent class \(NestedClassExample.counter)",
                          child: ChildNestedClass(id: UUID().uuidString,
                                                  name: "Nested class \(NestedClassExample.counter + 1)"))
            .createAndPopulate { result in
                switch result {
                case .success(let model):
                    NestedClassExample.counter += 2
                    lastCreated = model
                case .failure(let error):
                    logError(error)
                }
            }
    }
}

// MARK: - Fetching rows
extension NestedClassExample {
    func loadMainEntries() {
        withAnimation {
            viewModel.mainElements = ParentNestedClass.getAll()
        }
    }

    func loadNestedEntries() {
        withAnimation {
            viewModel.nestedElements = ChildNestedClass.getAll()
        }
    }
}

// MARK: - Helpers
struct DetailsRow: View {
    let name: String
    let id: String
    let childName: String?
    let parentName: String?

    init(name: String, id: String, childName: String? = nil, parentName: String? = nil) {
        self.id = id
        self.name = name
        self.childName = childName
        self.parentName = parentName
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                Text("Row name: ")
                    .font(.subheadline)
                Text(name)
                    .fontWeight(.bold)
                    .font(.caption)
            }

            HStack(spacing: 0) {
                Text("ID: ")
                    .font(.subheadline)
                Text(id)
                    .fontWeight(.bold)
                    .font(.caption)
            }

            if let childName = childName {
                HStack(spacing: 0) {
                    Text("Nested class name: ")
                        .font(.subheadline)
                    Text(childName)
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
            }

            if let parentName = parentName {
                HStack(spacing: 0) {
                    Text("parent name: ")
                        .font(.subheadline)
                    Text(parentName)
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
            }
        }
    }
}
