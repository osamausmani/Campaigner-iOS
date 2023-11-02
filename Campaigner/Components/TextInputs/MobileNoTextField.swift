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
    
    @State private var isInvalidInput = false
    
    var body: some View {
        let mask: String
        if text.hasPrefix("0") {
            mask = "XXXXXXXXXXX"
        } else {
            mask = "X"
            isInvalidInput = true
        }
        
        return VStack {
            Text(label)
                .alignmentGuide(.leading) { _ in 0 }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 15))
            
            HStack {
                let formattedText = formatCnicPhone(text, with: mask)
                
                TextField(placeholder, text: $text)
                    .foregroundColor(.black)
                    .frame(maxHeight: 30)
                    .padding(10)
                    .font(.system(size: 16))
                    .keyboardType(isNumberInput ? .numberPad : .default)
                    .onChange(of: text) { newValue in
                        if !newValue.isEmpty {
                            if newValue.first != "0" {
                                self.text = String(newValue.prefix(1))
                                isInvalidInput = true
                            } else {
                                isInvalidInput = false
                            }
                        }
                        text = formatCnicPhone(newValue, with: mask)
                    }
                
            }
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isInvalidInput ? Color.red : Color.black, lineWidth: 1)
            )
            .alignmentGuide(.leading) { _ in 0 }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if isInvalidInput {
                Text("Please enter phone number in a valid format")
                    .foregroundColor(.red)
                    .font(.system(size: 12))
            }
        }
    }
}
