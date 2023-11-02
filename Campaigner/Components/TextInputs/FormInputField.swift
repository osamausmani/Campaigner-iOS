//
//  FormInputField.swift
//  Campaigner
//
//  Created by Macbook  on 02/11/2023.
//

import SwiftUI

struct FormInputField: View {
    var label: String
    var placeholder: String
    @Binding var text: String
    
    var isNumberInput = false
    var isSecure = false
    var body: some View {
        VStack {
            
            Text(label).alignmentGuide(.leading) { _ in 0 }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 15))
            
            HStack{
                if (isSecure){
                    SecureField(placeholder, text: $text)
                        .foregroundColor(.black)
                        .frame(maxHeight: 30)
                        .padding(10)
                        .font(.system(size: 16))
                        .keyboardType(isNumberInput ? .numberPad : .default)
                }
                else{
                    TextField(placeholder, text: $text)
                        .foregroundColor(.black)
                        .frame(maxHeight: 30)
                        .padding(10)
                        .font(.system(size: 16))
                        .keyboardType(isNumberInput ? .numberPad : .default)
                }
                
                
                
            }.border(Color.black)
            
            
            
            
        }
    }
}
