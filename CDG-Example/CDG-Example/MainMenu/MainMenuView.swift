//
//  MainMenuView.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import SwiftUI

struct MainMenuView: View {
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            List(menuItems, id: \.id) { menuItem in
                NavigationLink(destination: menuItem.view) {
                    MenuItemView(menuItem: menuItem)
                }
            }
            .background(Image("logo_with_text").opacity(0.1))
            .navigationBarTitle(Text("CDG Examples"), displayMode: .large)
        }
    }
}

#if DEBUG
struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
#endif
