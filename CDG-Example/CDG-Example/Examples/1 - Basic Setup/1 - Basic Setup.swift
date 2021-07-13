//
//  1 - Basic Setup.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.

import SwiftUI
import CoreDataGenerator

// sourcery: ManagedObject
struct BasicStruct: Hashable, Identifiable {
    // sourcery: primaryKey
    var id: String
    let otherValue: Int
}

class ViewModel: ObservableObject {
    @Published var elements: [BasicStruct] = []
}

struct BasicSetupView: View {
    static var counter = 0
    @StateObject var state = ViewModel()

    var body: some View {
        VStack {
            HStack(spacing: 16.0) {
                Button("Insert 1 row") { insert1Row() }.buttonStyle(FilledButton())
                Button("Insert 3 rows") { insert3Rows() }.buttonStyle(FilledButton())
                Button("Remove all") { removeAllEntries() }.buttonStyle(FilledButton())
            }.padding([.leading, .trailing])
        }
        List(BasicStruct.getAll()) { element in
            VStack(alignment: .leading) {
                Text("ID: \(element.id)")
                Text("OtherValue: \(element.otherValue)")
            }
        }
        .padding(16.0)
        .onAppear {
            loadAllEntries()
        }
    }

    func insert1Row() {
        BasicStruct(id: UUID().uuidString, otherValue: BasicSetupView.counter)
            .createAndPopulate { result in
                BasicSetupView.counter += 1
                updateUIFromResult(result.map { [$0] })
            }
    }

    func insert3Rows() {
        [BasicStruct(id: UUID().uuidString, otherValue: BasicSetupView.counter),
         BasicStruct(id: UUID().uuidString, otherValue: BasicSetupView.counter + 1),
         BasicStruct(id: UUID().uuidString, otherValue: BasicSetupView.counter + 2)
        ].createAndPopulate { result in
            BasicSetupView.counter += 3
            updateUIFromResult(result)
        }
    }

    func removeAllEntries() {
        BasicStruct.delete(completeClosure: nil)
        loadAllEntries()
    }

    func loadAllEntries() {
        state.elements = BasicStruct.getAll()
    }

    func updateUIFromResult(_ result: Result<[BasicStruct], PersistableError>) {
        switch result {
        case .success(let insertedElements):
            state.elements.append(contentsOf: insertedElements)
        case .failure(let error):
            logError(error)
        }
    }
}
