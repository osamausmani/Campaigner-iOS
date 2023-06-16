//
//  NotificationScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 06/06/2023.
//

import SwiftUI

struct NotificationScreenView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack {
                Text("No New Notification!")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
                
                List {
                    // Your table view data here
                }
                .listStyle(GroupedListStyle())
            }
            .navigationBarTitle("Notifications", displayMode: .inline)
            .navigationBarItems(leading: backButton, trailing: EmptyView())
        }
        
    }
    
    private var backButton: some View {
        Button(action: {
            // Handle back button action here
            self.presentationMode.wrappedValue.dismiss()
            
        }) {
            Image(systemName: "chevron.left")
                .imageScale(.large)
                .foregroundColor(.green)
        }
    }
    
    struct NotificationScreenView_Previews: PreviewProvider {
        static var previews: some View {
            NotificationScreenView()
        }
    }
}
