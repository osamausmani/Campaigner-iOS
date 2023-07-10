//
//  AlertView.swift
//  Campaigner
//
//  Created by Macbook  on 26/06/2023.
//

import SwiftUI

struct AlertView: View {
    var title: String
    var message: String
    var dismissAction: (() -> Void)? = nil
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .bold()
            //Spacer()
                .padding()
            Text(message)
                .font(.body)
            //Spacer()
                .padding(5)
            Button("OK") {
                dismissAction?()
            }
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
        .frame(maxWidth: 300)
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(title: "Alert", message: "This is an alert message.")
    }
}
