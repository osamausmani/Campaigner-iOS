//
//  CustomTextInput.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/05/2023.
//

import SwiftUI

struct CustomTextInput: View {
    var placeholder: String
    @Binding var text: String
    
    var imageName: String?
    var isPasswordField = false
    @State private var isPasswordVisible = false
    
    var body: some View {
        HStack {
            // Left image icon
            if let imageName = imageName {
                Image(systemName: imageName)
                    .foregroundColor(.black)
                    .frame(width: 24, height: 24)
            }
            
            Spacer()
            
            // Text input
            if isPasswordField {
                if isPasswordVisible {
                    TextField(placeholder, text: $text)
                    
                        .foregroundColor(.black)
                } else {
                    SecureField(placeholder, text: $text)
                }
            } else {
                TextField(placeholder, text: $text)
                    .foregroundColor(.black)
            }
            
            // Right eye icon for password visibility
            if isPasswordField {
                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.black)
                        .padding(.leading, 5)
                }
            }
        }
        .frame(maxHeight: 50)
        .frame(minHeight: 30)
        .padding(10)
        .background(CColors.TextInputBgColor)
        .border(Color.black, width: 1)
        .cornerRadius(5)
    }
}
