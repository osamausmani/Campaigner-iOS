//
//  CustomButton.swift
//  Campaigner
//
//  Created by Macbook  on 12/06/2023.
//

import SwiftUI

struct CustomButton: View {
    
    var text : String
    var image : String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) { // Use the passed-in action here
            HStack(spacing: 15) {
                Image(systemName: image)
                    .foregroundColor(.white)
                    .font(.system(size: 24))
               
                Text(text)
                    .foregroundColor(.white)
                    .font(.headline)
            }
            .padding()
            .background(CColors.MainThemeColor)  
            .cornerRadius(10)
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .top)
    }
}


