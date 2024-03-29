//
//  SecondaryButton.swift
//  Campaigner
//
//  Created by Macbook  on 15/06/2023.
//

import SwiftUI



struct SecondaryButton : View{
    
    var action: () -> Void
    var label: String
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .frame(maxWidth: 100,maxHeight: 30)
               // .padding()
                .background(Color(red: 0.892, green: 0.578, blue: 0.052))
                .foregroundColor(.white)
               // .font(.headline)
                .cornerRadius(10)
        }//.frame(maxWidth: 120,maxHeight: 120,alignment: .top)
        
            
//        .frame(height: 60)
//        .padding(.horizontal, 80)
//        .padding(.vertical, 40)
    }
}


struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton(action: {}, label: "Pay now")
    }
}
