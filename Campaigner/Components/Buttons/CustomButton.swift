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
    var body: some View {
            Button(action: {
                // Handle button action
            }) {
                HStack(spacing: 5) {
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

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(text: "Testing", image: "paperclip")
    }
}
