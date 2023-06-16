//
//  AlertControlled.swift
//  Campaigner
//
//  Created by Macbook  on 06/06/2023.
//

import SwiftUI

struct AlertControlled: View {
    @State private var showingAlert = false

    var title : String
    var message : String
    var yesBtn : String
    var noBtn : String
    var action: () -> Void
    
    
    var body: some View {
        Button("Show Alert") {
            showingAlert = true
        }
        .alert(isPresented:$showingAlert) {
            Alert(
                title: Text("Are you sure you want to delete this?"),
                message: Text("There is no undo"),
                primaryButton: .destructive(Text("Delete")) {
                    print("Deleting...")
                    action()
                },
                secondaryButton: .cancel()
            )
        }
    }
}
