//
//  MandatoryField.swift
//  Campaigner
//
//  Created by Macbook  on 03/11/2023.
//


import SwiftUI

struct MandatoryField: View {
    var label: String
    var placeholder: String
    var isSecure = false
    var isNumberInput = false
    @Binding var text: String
    @State private var isPasswordVisible = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(label)
                Text("*")
                    .foregroundColor(.red)
            }
            
            if isSecure {
                ZStack(alignment: .trailing) {
                    SecureField(placeholder, text: $text)
                        .foregroundColor(.black)
                        .frame(maxHeight: 30)
                        .padding(10)
                        .font(.system(size: 16))
                        .keyboardType(isNumberInput ? .numberPad : .default)
                        .border(Color.black, width: 1)

                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.black)
                            .padding(.trailing, 10) // Adjust the padding as needed
                    }
                }
            } else {
                TextField(placeholder, text: $text)
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(5.0)
                    .border(Color.black, width: 1)
            }
        }
    }
}

struct MandatoryField_Previews: PreviewProvider {
    static var sample = Binding<String>.constant("")
    
    static var previews: some View {
        MandatoryField(label: "abc", placeholder: "abc", isSecure: true, isNumberInput: false, text: sample)
    }
}
