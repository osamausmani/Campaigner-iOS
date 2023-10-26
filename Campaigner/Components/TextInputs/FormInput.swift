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
    var isCnic = false
    let maskCNIC = "XXXXX-XXXXXXX-X"
    var isSecure = false
    @State private var isPasswordVisible = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.system(size: 15))
                .padding(.bottom, 5)
            
            HStack {
                // For now, no icon is added but you can include it just like in CustomTextInput
                
                // Input Field
                if isCnic {
                    let textChangedBinding = Binding<String>(
                        get: { FilterCnic.format(with: self.maskCNIC, phone: self.text) },
                        set: { self.text = $0 }
                    )
                    TextField(placeholder, text: textChangedBinding)
                        .foregroundColor(.black)
                        .keyboardType(.numberPad)
                        .padding()
                } else if isSecure {
                    if isPasswordVisible {
                        TextField(placeholder, text: $text)
                            .foregroundColor(.black)
                            .keyboardType(isNumberInput ? .numberPad : .default)
                            .padding()
                    } else {
                        SecureField(placeholder, text: $text)
                            .foregroundColor(.black)
                            .keyboardType(isNumberInput ? .numberPad : .default)
                            .padding()
                    }
                } else {
                    TextField(placeholder, text: $text)
                        .foregroundColor(.black)
                        .keyboardType(isNumberInput ? .numberPad : .default)
                        .padding()
                }
                
                // Eye icon for password visibility
                if isSecure {
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.black)
                    }
                    .padding(.trailing, 20)
                }
            }
            .background(Color.white)
            .border(Color.black, width: 1)
            .cornerRadius(5)
        }
        .padding(.vertical, 5)
    }
}

struct FormInput_Previews: PreviewProvider {
    static var sample = Binding<String>.constant("")
    
    static var previews: some View {
        FormInput(label: "Password", placeholder: "Enter Password", text: sample, isSecure: true)
            .padding()
    }
}
