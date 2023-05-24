//
//  MainButton.swift
//  Campaigner
//
//  Created by Osama Usmani on 22/05/2023.
//

import SwiftUI


struct MainButton : View{
    
    var action: () -> Void
    var label: String
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .frame(maxWidth: .infinity)
                .padding()
                .background(CColors.MainThemeColor)
                .foregroundColor(.white)
                .font(.headline)
                .cornerRadius(10)
        }
        .frame(height: 50)
    }
}
