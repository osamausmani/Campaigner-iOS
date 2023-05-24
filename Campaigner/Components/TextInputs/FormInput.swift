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
    
    var body: some View {
        VStack {
            
            Text(label).alignmentGuide(.leading) { _ in 0 }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 15))
            
            HStack{
                
                if (isCnic){
                    let textChangedBinding = Binding<String>(
                        get: {
                            FilterCnic.format(with: self.maskCNIC, phone: self.text)},
                        
                        set: { self.text = $0
                        })
                    TextField(placeholder, text: textChangedBinding)
                        .frame(maxHeight: 30)
                        .padding(10)
                        .foregroundColor(.black).keyboardType(.numberPad).foregroundColor(.black)
                }
                else if (isSecure){
                    SecureField(placeholder, text: $text)
                        .foregroundColor(.black).frame(maxHeight: 30)
                        .padding(10)
                        .font(.system(size: 16))
                        .keyboardType(isNumberInput ? .numberPad : .default)
                }
                else{
                    TextField(placeholder, text: $text)
                        .foregroundColor(.black).frame(maxHeight: 30)
                        .padding(10)
                        .font(.system(size: 16))
                        .keyboardType(isNumberInput ? .numberPad : .default)
                }
                
                
                
            }.border(Color.black)
            
            
            
            
        }
        //        .padding(.horizontal, 16)
        //        .padding(.vertical, 12)
        //        .cornerRadius(8)
    }
}
