//
//  ShowNotification.swift
//  Campaigner
//
//  Created by Macbook  on 19/10/2023.
//

import SwiftUI

struct ShowNotificationView: View {
    @State private var items: [String] = []
    @State private var isNavBarLinkActive = false
    @State private var isPresentNode:Bool=false
    @State private var showCreateNotification = false

    var body: some View {
        NavigationView {
            ZStack {
                // Background Condition
                if items.isEmpty {
                    Image("Emptybox")
                } else {
                    Image("logo")
                        .opacity(0.09)
                }
                
                VStack {
                    CustomNavBar(title: "Create Notification", destinationView: HomeScreenView(presentSideMenu: $isPresentNode), isActive: $isNavBarLinkActive)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()

                    // Content
                    if items.isEmpty {
                        VStack {
                            Text("No notification found")
                                .padding(.top, 100)
                            Text("Press + button to create notifications")
                        }
                        Spacer()
                    } else {
//                        List(items, id: \.self) { item in
//                            NavigationLink(destination: Text(item)) {
//                                Text(item)
//                            }
//                        }
//                        .background(
//                            Image("logo")
//                                .resizable()
//                                .opacity(0.09)
//
//                                .scaledToFill()
//                                .edgesIgnoringSafeArea(.all)
//                        )
                    }
                }
                VStack {

                         
                    Spacer()
                    HStack {
                        Spacer()
                        AddButton(action: {
                            self.showCreateNotification.toggle()
                        }, label: "Add")
                        .padding()
                    }
                }
                NavigationLink("", destination: CreateNotificationView(), isActive: $showCreateNotification)
                    .hidden()


            }
            .navigationTitle("")
        }
            
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear{
            listNotification()
        }
    }
}



struct ShowNotification_Previews: PreviewProvider {
    static var previews: some View {
        ShowNotificationView()
    }
}
func listNotification(){
    
    
}

