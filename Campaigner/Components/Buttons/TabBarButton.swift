//
//  TabBarButton.swift
//  Campaigner
//
//  Created by Macbook  on 02/06/2023.
//

import SwiftUI


struct TabBarButton: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack{
                Text(text)
                    .font(isSelected ? .system(size: 15).bold() : .system(size: 14))
                    .lineLimit(1)
                    .foregroundColor(isSelected ? CColors.MainThemeColor : .black)
                    .padding(0)
                
                HStack{
                    HStack{}.frame(maxWidth: .infinity).padding(1).background(isSelected ? CColors.MainThemeColor : .white)
                }.padding(2).padding(.leading,4).padding(.trailing,4).padding(.bottom,0)
               
            }
        }
    }
}



