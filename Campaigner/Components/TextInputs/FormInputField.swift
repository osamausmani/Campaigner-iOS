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
    var isMandatory = false
    var isDisabled = false

    @Binding var text: String
    
    var isNumberInput = false
    var isSecure = false
    var body: some View {
        VStack {
            HStack{
                Text(label).alignmentGuide(.leading) { _ in 0 }
                    .font(.system(size: 15))
                isMandatory ? Text("*").foregroundColor(.red) :nil
                Spacer()
            }
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
                        .keyboardType(isNumberInput ? .numberPad : .default).disabled(isDisabled)
                    
                    
                }
                
                
                
            }  .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 1)
            )
        }
    }
}
