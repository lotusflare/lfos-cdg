//
//  ClassesVSStructs.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import SwiftUI

struct ClassesVSStructs: View {
    var body: some View {
        List {
            NavigationLink("Self referenced classes", destination: SelfReferencedClassExample())
            NavigationLink("Nested classes", destination: NestedClassExample())
            NavigationLink("Recursive classes", destination: RecursiveClassExample())
            NavigationLink("Structs", destination: StructsExample())
        }
        .background(Image("logo_with_text").opacity(0.1))
        .navigationBarTitle(Text("Structs vs Classes"), displayMode: .inline)
    }
}
