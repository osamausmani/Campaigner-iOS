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
    
    var body: some View {
        HStack {
            if let imageName = imageName {
                Image(systemName: imageName)
                    .foregroundColor(.black)
                    .frame(width: 24, height: 24)
            }
            if (isPasswordField){
                SecureField(placeholder, text: $text)
            }
            else{
                TextField(placeholder, text: $text)
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(CColors.TextInputBgColor)
        .cornerRadius(8)
    }
}
