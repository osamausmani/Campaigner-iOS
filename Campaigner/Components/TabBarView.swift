//
//  TabBarView.swift
//  Campaigner
//
//  Created by Macbook  on 02/06/2023.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geometry in
                HStack(spacing: 20) {
                    Spacer()
                    
                    TabBarButton(text: "Tab 1", isSelected: selectedTab == 0) {
                        selectedTab = 0
                    }
                    
                    Spacer()
                    
                    TabBarButton(text: "Tab 2", isSelected: selectedTab == 1) {
                        selectedTab = 1
                    }
                    
                    Spacer()
                }
                .frame(width: geometry.size.width, height: 50)
                .background(Color.gray.opacity(0.2))
            }
            
//            TabView(selection: $selectedTab) {
//                Text("Tab 1 Content")
//                    .tabItem {
//                        Label("Tab 1", systemImage: "1.circle")
//                    }
//                    .tag(0)
//
//                Text("Tab 2 Content")
//                    .tabItem {
//                        Label("Tab 2", systemImage: "2.circle")
//                    }
//                    .tag(1)
//            }
        }
       // .ignoresSafeArea(.container, edges: .top)
    }
}


struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
