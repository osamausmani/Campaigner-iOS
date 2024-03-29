//
//  CnicTextInput.swift
//  Campaigner
//
//  Created by Osama Usmani on 21/05/2023.
//

import Foundation
import SwiftUI
struct CnicTextInput: View {
    var placeholder: String
    @Binding var text: String
    var backgroundColor = CColors.TextInputBgColor
    var foregroundColor: Color = .black
    var imageName: String?
    
    var body: some View {
        let mask: String
        if text.hasPrefix("0") {
            mask = "XXXXXXXXXXX"
        } else {
            mask = "XXXXX-XXXXXXX-X"
        }
        
        let formattedText = formatCnicPhone(text, with: mask)
        
        return HStack {
            if let imageName = imageName {
                Image(systemName: imageName)
                    .foregroundColor(foregroundColor)
                    .frame(width: 24, height: 24)
            }
            
            TextField(placeholder, text: $text)
                .foregroundColor(foregroundColor)
                .keyboardType(.numberPad)
                .onAppear {
                    self.text = formattedText
                }
                .onChange(of: text) { newValue in
                    text = formatCnicPhone(newValue, with: mask)
                }
        }
        .frame(maxHeight: 40)
        .frame(minHeight: 30)
        .padding(10)
        .background(backgroundColor)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: 1)
        )
  
    }
    struct CnicTextInput_Previews: PreviewProvider {
        static var previews: some View {
            PreviewWrapper()
        }
        
        struct PreviewWrapper: View {
            @State private var sampleText: String = ""
            
            var body: some View {
                CnicTextInput(placeholder: "xxx-xx-xxx", text: $sampleText)
            }
        }
    }
}
