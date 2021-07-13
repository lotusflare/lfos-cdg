//
//  RecursiveClassesExample.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import SwiftUI
import CoreDataGenerator

/// sourcery: ManagedObject
final class ParentRecursiveClass: Identifiable {
    /// sourcery: primaryKey
    var id: String
    let name: String
    var child: ChildRecursiveClass?

    init(id: String, name: String, child: ChildRecursiveClass?) {
        self.id = id
        self.name = name
        self.child = child
    }
}

/// sourcery: ManagedObject
final class ChildRecursiveClass: Identifiable {
    /// sourcery: primaryKey
    var id: String
    let name: String
    var grandchild: GrandchildRecursiveClass?
    /// sourcery: recursive
    weak var parent: ParentRecursiveClass?

    init(id: String, name: String, grandchild: GrandchildRecursiveClass?, parent: ParentRecursiveClass?) {
        self.id = id
        self.name = name
        self.grandchild = grandchild
        self.parent = parent
    }
}

/// sourcery: ManagedObject
final class GrandchildRecursiveClass: Identifiable {
    /// sourcery: primaryKey
    var id: String
    let name: String
    /// sourcery: recursive
    var grandfather: ParentRecursiveClass?

    init(id: String, name: String, grandfather: ParentRecursiveClass?) {
        self.id = id
        self.name = name
        self.grandfather = grandfather
    }
}

// MARK: - ViewModel
class RecursiveClassViewModel: ObservableObject {
    @Published var parentElements: [ParentRecursiveClass] = []
    @Published var childElements: [ChildRecursiveClass] = []
    @Published var grandchildElements: [GrandchildRecursiveClass] = []
}

enum SceneState {
    case showParent
    case showChildFromParent
    case showChild
    case showGrandChilds
}

struct RecursiveClassExample: View {
    static var counter = 0
    @State var lastCreated: ParentRecursiveClass?
    @StateObject var viewModel = RecursiveClassViewModel()
    @State var sceneState = SceneState.showParent

    var body: some View {
        VStack {
            Text("The recursive cases in classes are supported by CDG. This is an example that they can be saved to CoreData. Have in mind that the annotation 'recursive' must be set on properties that produce the recursion. Please take a look at the code also. Currently, we are only supporting final classes!")
            Button("Create a row") { insertRow() }.buttonStyle(FilledButton())

            if let createdRow = lastCreated {
                RecursiveRow(name: createdRow.name, id: createdRow.id, childName: createdRow.child?.name, grandchildName: createdRow.child?.grandchild?.name ?? "Missing grandchild!")
            } else {
                Text("Hint: Tapp above button to create a row!⬆️⬆️⬆️")
                    .font(.subheadline)
                    .fontWeight(.bold)
            }

            VStack {
                HStack(spacing: 6) {
                    Button("Fetch parent rows") { sceneState = .showParent; loadParentEntries() }.buttonStyle(FilledButton())
                    Button("Fetch child from parent rows") { sceneState = .showChildFromParent; loadParentEntries() }.buttonStyle(FilledButton())
                }
                HStack(spacing: 6) {
                    Button("Fetch child rows directly") { sceneState = .showChild; loadChildEntries() }.buttonStyle(FilledButton())
                    Button("Fetch grand child rows directly") { sceneState = .showGrandChilds; loadGrandchildEntries() }.buttonStyle(FilledButton())
                }
            }

            switch sceneState {
            case .showParent:
                CustomList(viewModel.parentElements) { element in
                    RecursiveRow(name: element.name, id: element.id, childName: element.child?.name)
                } emptyListView: {
                    Text("Currently, there are no parent rows saved in CoreData.")
                }
            case .showChildFromParent:
                CustomList(viewModel.parentElements.compactMap { $0.child }) { element in
                    RecursiveRow(name: element.name, id: element.id, parentName: element.parent?.name ?? "Missing parent", grandchildName: element.grandchild?.name ?? "Missing grandchild!")
                } emptyListView: {
                    Text("Currently, there are no parents saved in CoreData, so we are not able to display child rows .")
                }
            case .showChild:
                CustomList(viewModel.childElements) { element in
                    RecursiveRow(name: element.name, id: element.id, parentName: element.parent?.name ?? "Missing parent", grandchildName: element.grandchild?.name ?? "Missing grandchild!")
                } emptyListView: {
                    Text("Currently, there are no child rows saved in CoreData.")
                }
            case .showGrandChilds:
                CustomList(viewModel.grandchildElements) { element in
                    RecursiveRow(name: element.name, id: element.id, parentName: element.grandfather?.name ?? "Missing grandfather")
                } emptyListView: {
                    Text("Currently, there are no grandchild rows saved in CoreData.")
                }
            }
        }
        .onAppear(perform: {
            loadParentEntries()
        })
        .padding()
        .navigationBarTitle(Text("Nested classes"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            GrandchildRecursiveClass.delete(completeClosure: nil)
            ChildRecursiveClass.delete(completeClosure: nil)
            ParentRecursiveClass.delete {
                viewModel.parentElements = []
                viewModel.childElements = []
                viewModel.grandchildElements = []
            }
        }, label: {
            Text("Clear data")
        }))

    }
}

// MARK: - Inserting rows
extension RecursiveClassExample {
    func insertRow() {
        let parent = ParentRecursiveClass(id: UUID().uuidString,
                                          name: "Parent class \(RecursiveClassExample.counter)",
                                          child: nil)

        let grandchild = GrandchildRecursiveClass(id: UUID().uuidString,
                                                  name: "Grandchild class \(RecursiveClassExample.counter + 2)",
                                                  grandfather: parent)

        let child = ChildRecursiveClass(id: UUID().uuidString,
                                        name: "Child class \(RecursiveClassExample.counter + 1)",
                                        grandchild: grandchild,
                                        parent: parent)

        parent.child = child

        parent.createAndPopulate { result in
            switch result {
            case .success(let model):
                RecursiveClassExample.counter += 3
                lastCreated = model
            case .failure(let error):
                logError(error)
            }
        }
    }
}

// MARK: - Fetching rows
extension RecursiveClassExample {
    func loadParentEntries() {
        withAnimation {
            viewModel.parentElements = ParentRecursiveClass.getAll()
        }
    }

    func loadChildEntries() {
        withAnimation {
            viewModel.childElements = ChildRecursiveClass.getAll()
        }
    }

    func loadGrandchildEntries() {
        withAnimation {
            viewModel.grandchildElements = GrandchildRecursiveClass.getAll()
        }
    }
}

// MARK: - Helpers
struct RecursiveRow: View {
    let name: String
    let id: String
    let parentName: String?
    let childName: String?
    let grandchildName: String?

    init(name: String, id: String, parentName: String? = nil, childName: String? = nil, grandchildName: String? = nil) {
        self.id = id
        self.name = name
        self.childName = childName
        self.parentName = parentName
        self.grandchildName = grandchildName
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
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

            if let parentName = parentName {
                HStack(spacing: 0) {
                    Text("Parent name: ")
                        .font(.subheadline)
                    Text(parentName)
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
            }

            if let childName = childName {
                HStack(spacing: 0) {
                    Text("Child name: ")
                        .font(.subheadline)
                    Text(childName)
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
            }

            if let grandchildName = grandchildName {
                HStack(spacing: 0) {
                    Text("Grandchild name: ")
                        .font(.subheadline)
                    Text(grandchildName)
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
            }
        }
    }
}
