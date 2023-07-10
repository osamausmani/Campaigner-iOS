//
//  SimpleAlertView.swift
//  Campaigner
//
//  Created by Macbook  on 26/06/2023.
//

import SwiftUI

struct SimpleAlertView: View {
    @Binding var isPresented: Bool
    let title: String
    let message: String
    let onDismiss: (() -> Void)?
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            
            Text(message)
                .font(.subheadline)
                .multilineTextAlignment(.center)
            
            Button("Dismiss") {
                isPresented = false
                onDismiss?()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
        .frame(maxWidth: 300)
    }
}

struct SimpleAlertView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleAlertView(isPresented: .constant(true), title: "Alert", message: "This is a simple alert view.") {}
    }
}
