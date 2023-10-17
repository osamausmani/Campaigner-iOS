//
//  ConfirmationAlert.swift
//  Campaigner
//
//  Created by Macbook  on 07/07/2023.
//

import SwiftUI

struct ConfirmationAlert: View {
    @Binding var showAlert: Bool
    var onConfirm: () -> Void
    var title: String
    var message: String

    var body: some View {
        VStack {
            Button("Show Alert") {
                showAlert = true
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(title),
                message: Text(message),
                primaryButton: .default(Text("Yes"), action: {
                    onConfirm() // Call the provided closure when Yes is tapped
                }),
                secondaryButton: .cancel(Text("No"))
            )
        }
    }
}
