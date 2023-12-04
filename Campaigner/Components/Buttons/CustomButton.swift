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
            HStack(spacing: 8) {
                Image(systemName: image)
                    .foregroundColor(.white)
                    .font(.system(size: 16))
               
                Text(text)
                    .foregroundColor(.white)
                    .font(.system(size: 10))
            }
            .frame(height: 10)
            
            .padding()
            .background(CColors.MainThemeColor)
            .cornerRadius(10)
        }
     
    }
}
