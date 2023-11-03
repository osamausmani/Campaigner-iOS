//
//  FormInput.swift
//  Campaigner
//
//  Created by Osama Usmani on 22/05/2023.
//

import SwiftUI

struct FormInput: View {
    var label: String
    var placeholder: String
    @Binding var text: String

    var isNumberInput = false
    var isSecure = false
    
    var body: some View {
        let mask: String
        if text.hasPrefix("0") {
            mask = "XXXX-XXXXXXX"
        } else {
            mask = "XXXXX-XXXXXXX-X"
        }
        
        return VStack {
            Text(label).alignmentGuide(.leading) { _ in 0 }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 15))
            
            HStack {
                let formattedText = formatCnicPhone(text, with: mask)
                
                if isSecure {
                    SecureField(placeholder, text: $text)
                        .foregroundColor(.black)
                        .frame(maxHeight: 30)
                        .padding(10)
                        .font(.system(size: 16))
                        .keyboardType(isNumberInput ? .numberPad : .default)
                      
                } else {
                    TextField(placeholder, text: $text)
                        .foregroundColor(.black)
                        .frame(maxHeight: 30)
                        .padding(10)
                        .font(.system(size: 16))
                        .keyboardType(isNumberInput ? .numberPad : .default)
                        .onAppear {
                            self.text = formattedText
                        }
                        .onChange(of: text) { newValue in
                            text = formatCnicPhone(newValue, with: mask)
                        }
                       
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 1)
            )
            .alignmentGuide(.leading) { _ in 0 }
            .frame(maxWidth: .infinity, alignment: .leading)
          
        }
    }
}
