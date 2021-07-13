//
//  MenuItemView.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import SwiftUI

struct MenuItemView: View {
    
    let menuItem: MenuItem
    
    var body: some View {
        HStack {
            Text(menuItem.title)
            Spacer()
        }
    }
}

#if DEBUG
struct MenuItemView_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemView(menuItem: menuItems[0]).previewLayout(.fixed(width: 400, height: 80))
    }
}
#endif
