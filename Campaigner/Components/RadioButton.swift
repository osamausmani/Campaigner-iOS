//
//  RadioButton.swift
//  Campaigner
//
//  Created by Macbook  on 13/06/2023.
//

import SwiftUI

struct RadioButton: View {
    var option: String
    @Binding var selectedOption: String
    
    var body: some View {
        Button(action: {
            selectedOption = option
        }) {
            HStack(spacing: 10) {
                Image(systemName: selectedOption == option ? "largecircle.fill.circle" : "circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text(option)
            }.foregroundColor(.black)
            //.frame(maxWidth: .infinity, maxHeight: .infinity,  alignment: .top)
        }
    }
}




//struct RadioButton_Previews: PreviewProvider {
//    static var previews: some View {
//        RadioButton(option: <#String#>, selectedOption: <#Binding<String>#>)
//    }
//}
