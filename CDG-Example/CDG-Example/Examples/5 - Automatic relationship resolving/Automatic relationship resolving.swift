//
//  Automatic relationship resolving.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import SwiftUI

// Automatic relationship resolving from the same object example
/// sourcery: ManagedObject
struct MainEntity: Identifiable {
    /// sourcery: primaryKey
    var id: String
    var details: String
    var nestedField: NestedEntity
}

/// sourcery: ManagedObject
struct NestedEntity: Identifiable {
    /// sourcery: primaryKey
    var id: String
    var info: String
}

// Automatic relationship resolving from the external object example
/// sourcery: ManagedObject
struct Product: Hashable, Identifiable {
    /// sourcery: primaryKey
    public var id: String
    let name: String
    /// sourcery: relationshipIdentifier = "services"
    let serviceIds: [String]
    public internal(set) var services: [Service]? = nil
}

/// sourcery: ManagedObject
struct Service: Hashable, Identifiable {
    // sourcery: primaryKey
    var id: String
    let info: String
    let type: String
}

struct RelationshipResolvingView: View {
    @State var leftBoxResult: String = ""
    @State var rightBoxResult: String = ""
    
    var body: some View {
        VStack(spacing: 4.0){
            Text("Automatic relationship resolving is supported by CDG. For better understanding please take a look at the code and documentation.")
                .padding()
                .font(.system(size: 14))
            HStack{
                Text("From the same object")
                    .font(.system(size: 14))
                    .bold()
                Text("From the external object")
                    .font(.system(size: 14))
                    .bold()
            }
            Divider()
            HStack(spacing: 4.0) {
                VStack(alignment: .trailing ) {
                    ScrollView(.vertical) {
                        VStack(spacing: 4) {
                            Text("In this case, both the main entity and the nested one are known at the moment of creation.")
                                .padding()
                                .font(.system(size: 14))
                        }
                    }
                    
                    Button("Save main entity"){ saveMainEntity() }.buttonStyle(FilledButton())
                        .font(.system(size: 14))
                    Button("Get main entity"){ getMainEntities() }.buttonStyle(FilledButton())
                        .font(.system(size: 14))
                    Button("Get nested entity"){ getNestedEntities() }.buttonStyle(FilledButton())
                        .font(.system(size: 14))
                    
                    Text("Result:")
                    ScrollView(.vertical) {
                        VStack(spacing: 4) {
                            Text(leftBoxResult).padding()
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                }
                Divider()
                VStack(alignment: .leading) {
                    ScrollView(.vertical) {
                        VStack(spacing: 4) {
                            Text("The order of saving the main entity and the nested one doesn’t matter because of automatic relationship resolving.\nAt the moment of creation, the main object (Product) only has the id values (serviceIds) of the dependent objects (Services).\nLater, after the dependent objects (Services) are saved, they will also be added to  the main object (Product).")
                                .padding()
                                .font(.system(size: 14))
                        }
                    }
                    
                    Button("Save main entity"){ saveProductWithServiceIds() }
                        .buttonStyle(FilledButton())
                        .font(.system(size: 14))
                    Button("Save nested entities"){ saveServices() }
                        .buttonStyle(FilledButton())
                        .font(.system(size: 14))
                    Button("Get main entity"){ getProducts() }
                        .buttonStyle(FilledButton())
                        .font(.system(size: 14))
                    
                    Text("Result:")
                    ScrollView(.vertical) {
                        VStack(spacing: 4) {
                            Text(rightBoxResult).padding()
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }.padding()
        .navigationBarTitle(Text("Automatic relationship resolving"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            clearData()
        }, label: {
            Text("Clear data")
        }))
    }
    
    // Automatic relationship resolving from the same object
    func saveMainEntity() {
        let mainEntity = MainEntity(id: "m123", details: "test-details", nestedField: NestedEntity(id: "1111", info: "test info"))
        MainEntity.createBatchAndPopulate(from: [mainEntity]) { result in
            switch result {
            case .success(let elements):
                leftBoxResult = "✅\(elements)"
            case .failure(let error):
                leftBoxResult = "❌\(error)"
            }
        }
    }
    
    // Automatic relationship resolving from the external object
    func saveProductWithServiceIds() {
        let product = Product(id: "p123", name: "p-1", serviceIds: ["1234", "1235"])
        Product.createBatchAndPopulate(from: [product]) { result in
            switch result {
            case .success(let elements):
                rightBoxResult = "✅\(elements)"
            case .failure(let error):
                rightBoxResult = "❌\(error)"
            }
        }
    }
    
    // Automatic relationship resolving from the external object
    func saveServices() {
        let service1 = Service(id: "1234", info: "info 1", type: "T-1")
        let service2 = Service(id: "1235", info: "info 2", type: "T-1")
        Service.createBatchAndPopulate(from: [service1, service2]) {
            result in
            switch result {
            case .success(let elements):
                rightBoxResult = "✅\(elements)"
            case .failure(let error):
                rightBoxResult = "❌\(error)"
            }
        }
    }
    
    func getMainEntities() {
        let mainEntities = MainEntity.getAll()
        leftBoxResult = "\(mainEntities)"
    }
    
    func getNestedEntities() {
        let nestedEntities = NestedEntity.getAll()
        leftBoxResult = "\(nestedEntities)"
    }
    
    func getProducts() {
        let products = Product.getAll()
        rightBoxResult = "\(products)"
    }
    
    func clearData() {
        MainEntity.delete(){}
        NestedEntity.delete(){}
        Product.delete(){}
        Service.delete(){}
        leftBoxResult = ""
        rightBoxResult = ""
    }
}

