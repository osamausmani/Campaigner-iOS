//
//  MultilineInputMandatory.swift
//  Campaigner
//
//  Created by Macbook  on 27/11/2023.
//

import SwiftUI


struct MultilineInputMandatory: View {
    var label: String
       var placeholder: String
       var isMandatory: Bool = true
       @Binding var text: String
       
       var body: some View {
           VStack(alignment: .leading) {
               HStack {
                   Text(label)
                       .font(.system(size: 15))
                   if isMandatory {
                       Text("*")
                           .foregroundColor(.red)
                   }
               }
               
               ZStack(alignment: .topLeading) {
                   TextEditor(text: $text)
                       .frame(height: 100)
                       .padding(.horizontal, 0)
                       .font(.system(size: 16))
                       .foregroundColor(.black)
                       .keyboardType(.default)
                       .disableAutocorrection(true)
                       .background(Color.clear)
                       .overlay(
                           RoundedRectangle(cornerRadius: 0)
                               .stroke(Color.black, lineWidth: 1)
                       )
                   
                   if text.isEmpty {
                       Text(placeholder)
                           .foregroundColor(.gray)
                           .font(.system(size: 16))
                           .padding(.all, 8) // Adjust the padding if necessary
                   }
               }
           }
       }
}
#Preview {
    MultilineFormInput(label: "Description", placeholder: "Type description here", text: .constant(""))
}
