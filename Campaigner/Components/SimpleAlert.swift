//
//  SimpleAlert.swift
//  Campaigner
//
//  Created by Macbook  on 26/06/2023.
//

import SwiftUI

struct SimpleAlert: View {
    @State private var showAlert = false

        var body: some View {
            Button("Show Alert") {
                showAlert = true
            }
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Alert"), message: Text("This is an alert"), dismissButton: .default(Text("OK"), action: handleAlertDismiss))
            })
        }

        func handleAlertDismiss() {
            print("Alert dismissed")
            // Perform additional actions or logic here
        }
    
}

struct SimpleAlert_Previews: PreviewProvider {
    static var previews: some View {
        SimpleAlert()
    }
}
