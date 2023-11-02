//
//  MobileNoTextField.swift
//  Campaigner
//
//  Created by Macbook  on 02/11/2023.
//

import SwiftUI

struct MobileNoTextField: View {
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
            mask = "XXXX-XXXXXXX"
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
                        .onAppear {
                            self.text = formattedText
                        }
                        .onChange(of: text) { newValue in
                            text = formatCnicPhone(newValue, with: mask)
                        }
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
            .border(Color.black)
        }
    }
}
