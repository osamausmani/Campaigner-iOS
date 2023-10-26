//
//  TabBarView.swift
//  Campaigner
//
//  Created by Macbook  on 02/06/2023.
//

import SwiftUI

struct TabBarView: View {
    @Binding var selectedTab: Int
    var tabNames: [String]
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geometry in
                HStack(spacing: 20) {
                    Spacer()
                    
                    ForEach(0..<tabNames.count) { index in
                        TabBarButton(text: tabNames[index], isSelected: selectedTab == index) {
                            // Do nothing here, since direct tab switching is disabled
                        }
                        Spacer()
                    }
                }
                .frame(width: geometry.size.width, height: 50)
                .background(Color.white)
            }
        }
    }
}



struct TabBarView_Previews: PreviewProvider {
    @State static var selectedTabIndex = 0
    
    static var previews: some View {
        VStack {
            TabBarView(selectedTab: $selectedTabIndex, tabNames: ["Basic Information", "Audience"])
            Spacer()
            Button("Next") {
                selectedTabIndex += 1
            }
        }
    }
}
