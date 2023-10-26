//
//  FormInputMandatory.swift
//  Campaigner
//
//  Created by Macbook  on 19/10/2023.
//

import SwiftUI

struct FormInputMandatory: View {
    var label: String
        var placeholder: String

        @Binding var text: String

        var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    Text(label)
                    
                        Text("*")
                            .foregroundColor(.red)
                    
                }
                TextField(placeholder, text: $text)
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(5.0)
                    .border(Color.black, width: 1)
            }
            
        }
    }



struct FormInputMandatory_Previews: PreviewProvider {
    static var sample = Binding<String>.constant("")
    static var previews: some View {
        FormInputMandatory(label: "abc", placeholder: "abc", text: sample)
    }
}
