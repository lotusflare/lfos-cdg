//
//  EnumsExample.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import SwiftUI
import CoreDataGenerator

/// sourcery: ManagedObject, autoId
struct Person: Identifiable {
    /// sourcery: primaryKey
    var id: String? = nil
    let activity: Activity
}

/// sourcery: ManagedObject, autoId
public struct Car: Identifiable {
    /// sourcery: primaryKey
    public var id: String? = nil
    let manufacturer: String
    let name: String
}

/// sourcery: ManagedObject, autoId
public struct Airplane: Identifiable {
    /// sourcery: primaryKey
    public var id: String? = nil
    let name: String
}

/// sourcery: ManagedObject, autoId
struct Work {
    /// sourcery: primaryKey
    public var id: String? = nil
    let name: String
}

enum Activity {
    case sleeping                                        // - Example of the case without associated value
    case working(with: [String], at: [Work])             // - Example of the case with primitive and custom array associated value with parameter name
    case walking(String)                                 // - Example of the case with associated value where there is no parameter name
    case running(String, String)                         // - Example of the case with more than one associated value where there is no parameter names
    case driving(vehicle: Car)                           // - Example of the case with associated value where there is a parameter name
    case flying(vehicle: Airplane, description: String, String)  // - Example of the case with more than one associated value where not all parameters have names

    func getDescription() -> String {
        switch self {
        case .working(let collegaues, let work):
            return "I'm working with: " + collegaues.joined(separator: ",") + " at \(work.map { $0.name }.joined(separator: ", "))"
        case .sleeping:
            return "Leave me alone, I'm sleeping!"
        case .walking(let description):
            return description
        case .driving(let car):
            return "Going for a ride in \(car.manufacturer) \(car.name)"
        case .flying(let vehicle, let airplane, let description):
            return "Flying with \(vehicle.name), \(airplane), \(description)"
        case .running(let description, let message):
            return description + message
        }
    }
}

// MARK: - ViewModel
class EnumsViewModel: ObservableObject {
    @Published var elements: [Person] = []
}

struct EnumsExample: View {
    static var counter = 0
    @StateObject var viewModel = EnumsViewModel()

    var body: some View {
        VStack {
            Text("Enums with associated values are supported by CDG. This is an example that they can be saved to CoreData. Please take a look at the code also.")

            Button("Create with sleeping activity") { insertRow(with: .sleeping) }.buttonStyle(FilledButton())
            Button("Create with working activity") { insertRow(with: .working(with: ["Jelena, Nikola, Mirko"], at: [Work(name: "LotusFlare")])) }.buttonStyle(FilledButton())
            Button("Create with walking activity") { insertRow(with: .walking("It is a nice day for a walk...")) }.buttonStyle(FilledButton())
            Button("Create with runing activity") { insertRow(with: .running("Yea, I am running", "I'm the best runner in the world!")) }.buttonStyle(FilledButton())
            Button("Create with driving activity") { insertRow(with: .driving(vehicle: Car(manufacturer: "Opel", name: "Vectra"))) }.buttonStyle(FilledButton())
            Button("Create with flying activity") { insertRow(with: .flying(vehicle: Airplane(name: "Mig 29"), description: "Nikola Tesla", "Belgrade")) }.buttonStyle(FilledButton())

            List(viewModel.elements) { element in
                VStack(alignment: .leading) {
                    HStack(spacing: 0) {
                        Text("ID: ")
                            .font(.subheadline)
                        Text(element.id ?? "")
                            .fontWeight(.bold)
                            .font(.caption)
                    }

                    Text("Activity: ")
                        .font(.subheadline)
                    +
                        Text(element.activity.getDescription())
                        .fontWeight(.bold)
                        .font(.caption)
                }
            }.overlay(Group {
                if viewModel.elements.isEmpty {
                    VStack(spacing: 4) {
                        Text("Currently, there are no rows in CoreData. Tapp on any button to create a sample row")
                            .fontWeight(.bold)
                        Text("⬆️⬆️⬆️")
                    }
                } else {
                    EmptyView()
                }
            })
        }
        .padding()
        .navigationBarTitle(Text("Enums"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            Work.delete(completeClosure: nil)
            ManagedCar.delete()
            Person.delete {
                loadAllEntries()
            }
        }, label: {
            Text("Clear data")
        }))
        .onAppear(perform: {
            loadAllEntries()
        })
    }

    func updateUIFromResult(_ result: Result<Person, PersistableError>) {
        switch result {
        case .success:
            loadAllEntries()
        case .failure(let error):
            logError(error)
        }
    }
}

// MARK: - Inserting rows
extension EnumsExample {
    func insertRow(with activity: Activity) {
        Person(activity: activity)
            .createAndPopulate { result in
                EnumsExample.counter += 1
                self.updateUIFromResult(result)
            }
    }
}

// MARK: - Fetching rows
extension EnumsExample {
    func loadAllEntries() {
        viewModel.elements = Person.getAll()
    }
}
