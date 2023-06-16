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
            Text(text)
                .font(.subheadline)
                .foregroundColor(isSelected ? CColors.MainThemeColor : .black)
                .padding()
        }
    }
}
