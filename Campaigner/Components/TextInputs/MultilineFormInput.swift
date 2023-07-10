//
//  MultilineFormInput.swift
//  Campaigner
//
//  Created by Macbook  on 07/07/2023.
//

import SwiftUI

struct MultilineFormInput: View {
    var label: String
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.system(size: 15))
            
            TextEditor(text: $text)
                .frame(height: 100)
                .border(Color.black)
                .padding(.horizontal, 10)
                .font(.system(size: 16))
                .foregroundColor(.black)
                .keyboardType(.default)
                .disableAutocorrection(true)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
        }
    }

}

struct MultilineFormInput_Previews: PreviewProvider {
    static var previews: some View {
        MultilineFormInput(label: "Description", placeholder: "Type description here", text: .constant(""))
    }
}
