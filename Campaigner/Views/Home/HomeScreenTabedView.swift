//
//  HomeScreenTabedView.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/05/2023.
//

import Foundation
import SwiftUI

struct HomeScreenTabedView: View {
    
    @State var presentSideMenu = true
    @State var selectedSideMenuTab = 0
    
    var body: some View {
        ZStack{
            
            TabView(selection: $selectedSideMenuTab) {
                HomeScreenView(presentSideMenu: $presentSideMenu)
                    .tag(0)
                HomeScreenView(presentSideMenu: $presentSideMenu)
                    .tag(1)
                HomeScreenView(presentSideMenu: $presentSideMenu)
                    .tag(2)
                HomeScreenView(presentSideMenu: $presentSideMenu)
                    .tag(3)
            }
            
            SideMenu(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)))
        }
    }
}

struct HomeScreenTabedView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenTabedView()
    }
}
