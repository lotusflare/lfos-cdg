//
//  MenuItem.swift
//  KMN Examples
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import Foundation
import SwiftUI

struct MenuItem {
    let id: Int
    let title: String
    let view: AnyView
}

let menuItems = [
    MenuItem(id: 1, title: "1 - Basic Setup", view: AnyView(BasicSetupView())),
    MenuItem(id: 2, title: "2 - Filtering", view: AnyView(FilteringView())),
    MenuItem(id: 3, title: "3 - Grouping into buckets using groupID", view: AnyView(GroupingIntoBuckets())),
    MenuItem(id: 4, title: "4 - Classes VS Structs", view: AnyView(ClassesVSStructs())),
    MenuItem(id: 5, title: "5 - Automatic relationship resolving", view: AnyView(RelationshipResolvingView())),
    MenuItem(id: 6, title: "6 - Enum with associated values", view: AnyView(EnumsExample())),
    MenuItem(id: 7, title: "7 - Migration example", view: AnyView(MigrationExample()))
]
