//
//  GroupingIntoBuckets.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import SwiftUI
import CoreDataGenerator

// sourcery: ManagedObject
struct GroupStruct: Hashable, Identifiable {
    // sourcery: primaryKey
    var id: String
    let group: String
}

struct GroupingIntoBuckets: View {
    @State var groupdID: String = ""
    @State var showOnlyWithGroupID: Bool = false
    @State var showAlert: Bool = false
    @StateObject var viewModel = GroupingViewModel()

    var body: some View {
        Group {
            VStack {
                Text("We can group new rows by a groupID, so we can, later on, fetch them all together by groupID value.")
                    .padding()

                TextField("Enter groupID", text: $groupdID)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.blue, lineWidth: 1)
                    )
                    .onChange(of: groupdID, perform: { value in
                        self.refreshData(withGroup: self.showOnlyWithGroupID)
                    })

                HStack(spacing: 8) {
                    Button("Insert with groupID") {
                        if groupdID.isEmpty {
                            showAlert.toggle()
                        } else {
                            insertRow(with: self.groupdID)
                        }
                    }.buttonStyle(FilledButton())

                    Button("Insert without groupID") { insertRow(with: nil) }.buttonStyle(FilledButton())
                }

                Toggle("Show rows with groupID", isOn: $showOnlyWithGroupID)
                    .padding([.top])
                    .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                    .onChange(of: showOnlyWithGroupID, perform: { value in
                        self.refreshData(withGroup: value)
                    })
            }.padding([.leading, .trailing])

            List(viewModel.elements) { element in
                VStack(alignment: .leading) {
                    Text("ID: \(element.id)")
                    HStack(spacing: 0) {
                        Text("GroupID: ")
                        Text("\(!element.group.isEmpty ? element.group : "---")")
                            .fontWeight(.bold)
                    }

                }
            }
            .padding(16.0)
            .overlay(Group {
                let isViewModelEmpty = viewModel.elements.isEmpty
                switch (isViewModelEmpty, showOnlyWithGroupID) {
                case (false, _):
                    EmptyView()
                case (true, true) where groupdID.isEmpty:
                    Text("Hint: To display out rows by groupID in the list, first enter the groupID in the text field above.⬆️⬆️⬆️")
                        .fontWeight(.bold)
                        .padding()
                case (true, true):
                    Text("Currently, there are no rows in CoreData for groupID: \(groupdID)")
                        .fontWeight(.bold)
                        .padding()
                case (true, false):
                    Text("Currently, there are no rows in CoreData, please insert a new row")
                        .fontWeight(.bold)
                        .padding()
                }
            })
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Warnign"),
                  message: Text("To create a row with groupID please enter one first in the input field"),
                  dismissButton: .default(Text("Got it!")))
        }
        .onAppear {
            loadAllEntries()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {
            GroupStruct.delete(completeClosure: nil)
            loadAllEntries()
        }, label: {
            Text("Clear data")
        }))

    }
}

// MARK: - Inserting rows
extension GroupingIntoBuckets {
    func insertRow(with groupID: String?) {
        GroupStruct(id: UUID().uuidString, group: groupID ?? "")
            .createAndPopulate(groupID: groupID) { result in
                updateUIFromResult(result)
            }
    }
}

// MARK: - Fetching rows
extension GroupingIntoBuckets {
    func loadAllEntries() {
        viewModel.elements = GroupStruct.getAll()
    }

    func loadEntitiesWithGroupID() {
        guard !self.groupdID.isEmpty else {
            viewModel.elements = []
            return
        }
        // If the empty string or nil value is passed as an argument, then all rows will be returned as a result.
        viewModel.elements = GroupStruct.getAll(groupID: self.groupdID)
    }
}

// MARK: - Helpers
extension GroupingIntoBuckets {
    func updateUIFromResult(_ result: Result<GroupStruct, PersistableError>) {
        switch result {
        case .success:
            refreshData(withGroup: self.showOnlyWithGroupID)
        case .failure(let error):
            logError(error)
        }
    }

    func refreshData(withGroup: Bool) {
        withGroup ? loadEntitiesWithGroupID() : loadAllEntries()
    }
}

class GroupingViewModel: ObservableObject {
    @Published var elements: [GroupStruct] = []
}
