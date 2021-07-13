//
//  2 - Filtering.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import SwiftUI
import CoreDataGenerator

// sourcery: ManagedObject
struct ParentStruct: Hashable, Identifiable {
    // sourcery: primaryKey
    var id: String
    let year: Int
    let tag: Int
    // sourcery: relationshipIdentifier = "child"
    let childId: String
    public internal(set) var child: ChildStruct? = nil
}

// sourcery: ManagedObject
struct ChildStruct: Hashable, Identifiable {
    // sourcery: primaryKey
    var id: String
    let name: String
    let age: Int
    let child: GrandChild?
    let projects: [Project]?
}

// sourcery: ManagedObject
struct GrandChild: Hashable, Identifiable {
    // sourcery: primaryKey
    var id: String
    let firstName: String
    let age: Int
}

// sourcery: ManagedObject
struct Project: Hashable, Identifiable {
    // sourcery: primaryKey
    var id: String
    let durationInMonths: Int
    // sourcery: managedPropertyName = "desc"
    let description: String
}

class FilteringViewModel: ObservableObject {
    @Published var elements: [ParentStruct] = []
}

struct FilteringView: View {
    @StateObject var state = FilteringViewModel()
    
    var body: some View {
        VStack(spacing: 6.0) {
            Text("Filtering parent entities")
            HStack(spacing: 6.0) {
                Button("tag <= 3") { filterById() }.buttonStyle(FilledButton())
                Button("year >= 2002") { filterByYear() }.buttonStyle(FilledButton())
            }
            
            Text("Filtering parent entities based on child property:")
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .lineLimit(3)
            HStack(spacing: 6.0) {
                Button("age <= 53") { filterChildrenByAge() }.buttonStyle(FilledButton())
                Button("name == 'Ana'") { filterChildrenByName() }.buttonStyle(FilledButton())
            }
            
            Text("Filtering parent entities based on grand child property:").fontWeight(.light)
            HStack(spacing: 6.0) {
                Button("age <= 3") { filterGrandChildrenByAge() }.buttonStyle(FilledButton())
                Button("name == 'Oliver'") { filterGrandChildrenByName() }.buttonStyle(FilledButton())
            }

            Text("Filtering parent entities based on child collection:").fontWeight(.light)
            HStack(spacing: 6.0) {
                Button("durationInMonths == 6") { filterChildrenByProject() }.buttonStyle(FilledButton())
            }

            Text("Sorting:")
            HStack(spacing: 6.0) {
                Button("by id asc") { sortByIdAsc() }.buttonStyle(FilledButton())
                Button("by id desc") { sortByIdDesc() }.buttonStyle(FilledButton())
                Button("by year asc,\n by id desc") { combinedSort() }.buttonStyle(FilledButton())
            }
        }
        List(getEntities()) {
            element in
            VStack(alignment: .leading) {
                Text("PARENT").foregroundColor(.accentColor)
                Text("id: \(element.id)")
                Text("tag: \(element.tag)")
                Text("childId: \(element.childId)")
                Text("year: \(element.year)")
                VStack(alignment: .leading) {
                    Text("CHILD").foregroundColor(.accentColor)
                    Text("id: \(element.childId)")
                    Text("name: \(element.child?.name ?? "N/A")")
                    Text("age: \(element.child?.age ?? 0)")
                    VStack(alignment: .leading) {
                        ForEach(element.child?.projects ?? [], content: { project in
                            Text("duration: \(project.durationInMonths)")
                        })
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("GRAND CHILD").foregroundColor(.accentColor)
                    Text("id: \(element.child?.child?.id ?? "N/A")")
                    Text("first name: \(element.child?.child?.firstName ?? "N/A")")
                    Text("age: \(element.child?.child?.age ?? 0)")
                }
            }
        }
        .padding(16.0)
        .navigationBarItems(trailing: Button(action: {
            displayAllEntities()
        }, label: {
            Text("Reset")
        }))
        .onAppear() {
            populateCoreData()
        }
    }
    
    func displayAllEntities() {
        let result = ParentStruct.getAll()
        state.elements.removeAll()
        state.elements.append(contentsOf: result)
    }
    
    func filterById() {
        let result = Results<ParentStruct>().filterBy(\ParentStruct.tag <= 3).objects
        state.elements.removeAll()
        state.elements.append(contentsOf: result)
    }
    
    func filterByYear() {
        let result = Results<ParentStruct>().filterBy(\ParentStruct.year >= 2002).objects
        state.elements.removeAll()
        state.elements.append(contentsOf: result)
    }
    
    func filterChildrenByAge() {
        let result = Results<ParentStruct>().filterBy(\ParentStruct.child?.age <= 53).objects
        state.elements.removeAll()
        state.elements.append(contentsOf: result)
    }
    
    func filterChildrenByName() {
        let result = Results<ParentStruct>().filterBy(\ParentStruct.child?.name == "Ana").objects
        state.elements.removeAll()
        state.elements.append(contentsOf: result)
    }

    func filterChildrenByProject() {
        let compoundKeyPath = CompoundKeyPath<ParentStruct>(rootKeyPath: \ParentStruct.child?.projects, relationshipKeyPath: \Project.durationInMonths, modifier: .any)
        let result = Results<ParentStruct>().filterBy(compoundKeyPath == 6).objects
        state.elements.removeAll()
        state.elements.append(contentsOf: result)
    }

    func filterGrandChildrenByAge() {
        let result = Results<ParentStruct>().filterBy(\ParentStruct.child?.child?.age <= 3).objects
        state.elements.removeAll()
        state.elements.append(contentsOf: result)
    }
    
    func filterGrandChildrenByName() {
        let result = Results<ParentStruct>().filterBy(\ParentStruct.child?.child?.firstName == "Oliver").objects
        state.elements.removeAll()
        state.elements.append(contentsOf: result)
    }
    
    func sortByIdAsc() {
        let result = Results<ParentStruct>().sortBy(.ascending(\ParentStruct.id)).objects
        state.elements.removeAll()
        state.elements.append(contentsOf: result)
    }
    
    func sortByIdDesc() {
        let result = Results<ParentStruct>().sortBy(.descending(\ParentStruct.id)).objects
        state.elements.removeAll()
        state.elements.append(contentsOf: result)
    }
    
    func combinedSort() {
        let result = Results<ParentStruct>().sortBy(.ascending(\ParentStruct.year), .descending(\ParentStruct.id)).objects
        state.elements.removeAll()
        state.elements.append(contentsOf: result)
    }
    
    func getEntities() -> [ParentStruct] {
        return state.elements
    }
    
    func updateUIFromResult(_ result: Result<[ParentStruct], PersistableError>) {
        switch result {
        case .success(let result):
            state.elements.append(contentsOf: result)
        case .failure(let error):
            logError(error)
        }
    }
    
    func populateCoreData() {
        let parent1 = ParentStruct(id: "1", year: 2001, tag: 1, childId: "CHILD1" )
        let parent2 = ParentStruct(id: "2", year: 2001, tag: 2, childId: "CHILD2" )
        let parent3 = ParentStruct(id: "3", year: 2003, tag: 3, childId: "CHILD3" )
        let parent4 = ParentStruct(id: "4", year: 2004, tag: 4, childId: "CHILD4" )

        let project1 = Project(id: "p1", durationInMonths: 6, description: "Project 1")
        let project2 = Project(id: "p2", durationInMonths: 12, description: "Project 2")

        let child1 = ChildStruct(id: "CHILD1", name: "Ana", age: 51, child: GrandChild(id: "345", firstName: "Liam", age: 3), projects: nil)
        let child2 = ChildStruct(id: "CHILD2", name: "Ted", age: 52, child: GrandChild(id: "346", firstName: "Noah", age: 14), projects: nil)
        let child3 = ChildStruct(id: "CHILD3", name: "Alis", age: 53, child: GrandChild(id: "347", firstName: "Oliver", age: 2), projects: [project1])
        let child4 = ChildStruct(id: "CHILD4", name: "Sarah", age: 54, child: GrandChild(id: "348", firstName: "William", age: 6), projects: [project1, project2])

        let parentBatch = [parent1, parent2, parent3, parent4]
        let childrenBatch = [child1, child2, child3, child4]
        
        childrenBatch.createAndPopulate { _ in
            parentBatch.createAndPopulate { result in
                self.updateUIFromResult(result)
            }
        }
    }
}

