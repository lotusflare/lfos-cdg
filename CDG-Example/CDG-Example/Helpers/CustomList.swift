//
//  CustomList.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import SwiftUI

public struct CustomList<Items: RandomAccessCollection,
                         ListRowView: View,
                         EmptyListView: View>: View where Items.Element: Identifiable {

    private var items: Items
    private var listRowView: (Items.Element) -> ListRowView
    private let emptyListView: () -> EmptyListView

    /// - Parameters:
    ///   - items: Source data for List. Item must implement Identifiable protocol
    ///   - listRowView: View displayed for each source Item
    ///   - emptyListView: View displayed when the items collection isEmpty
    public init(_ items: Items,
         @ViewBuilder listRowView: @escaping (Items.Element) -> ListRowView,
         @ViewBuilder emptyListView: @escaping () -> EmptyListView) {
        self.items = items
        self.listRowView = listRowView
        self.emptyListView = emptyListView

    }

    public var body: some View {
        Group {
            if !items.isEmpty {
                List(items) { item in
                    self.listRowView(item)
                }

            } else {
                Spacer()
                emptyListView()
                Spacer()
            }
        }
    }
}
