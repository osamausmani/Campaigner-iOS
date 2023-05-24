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
    
    let maskPhone  = "XXXXX-XXXXXXX-X"
    
    var body: some View {
        HStack {
            if let imageName = imageName {
                Image(systemName: imageName)
                    .foregroundColor(foregroundColor)
                    .frame(width: 24, height: 24)
            }
            
            let textChangedBinding = Binding<String>(
                get: {
                    FilterCnic.format(with: self.maskPhone, phone: self.text)},
                
                set: { self.text = $0
                })
            
            TextField(placeholder, text: textChangedBinding)
                .foregroundColor(foregroundColor).keyboardType(.numberPad)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(backgroundColor)
        
        .cornerRadius(8)
    }
}
