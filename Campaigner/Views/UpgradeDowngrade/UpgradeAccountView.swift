//
//  UpgradeAccountView.swift
//  Campaigner
//
//  Created by Macbook  on 05/12/2023.
//

import SwiftUI

struct UpgradeAccountView: View {
    @State private var isProAccount:Bool=false
    @State private var ispresentMode:Bool=true
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationView {
            
            GeometryReader { geometry in
                ZStack {
                    Image("splash_background")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 20) {
                        Spacer()
                        
                        VStack(spacing: 20) {
                            ZStack {
                                Image("upgrade")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.4)
                                    .padding(.bottom, geometry.size.height * 0.05)
                                
                                VStack {
                                    Spacer()
                                    Text("halka Pro")
                                        .offset(y: -geometry.size.height * 0.0)
                                        .font(.title)
                                }
                            }
                            .frame(height: geometry.size.height * 0.2)
                            
                            VStack(alignment:.leading,spacing: 10) {
                                FeatureRow(icon: "tick", title: "Surveys:", description: "Create tailored surveys to acquire the exact unformation instantly.")
                                FeatureRow(icon: "tick", title: "Complaints:", description: "Learn about the latest problem that your constituents are facing as soon as they arise. Update the public as soon as you solve their problems.")
                                FeatureRow(icon: "tick", title: "Reports:", description: "Directly communicate the problems to your team members, and enable your team leads and members to communicate to you and identify outstanding issues.")
                                FeatureRow(icon: "tick", title: "Notifications:", description: "Send out instant notifications to your constituents and keep them engagged before and after your election campaigns.")
                            }
                            .padding(.vertical)
                            
                            
                        }
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                        
                        VStack {
                            
                            Text("Upgrade and Utilize the complete scope of halka pro Services.")
                                .bold()
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                    
                                MainButton(action: {
                                    isProAccount = true
                                    self.presentationMode.wrappedValue.dismiss()
                                }, label: "Upgrade account now")
                            
                            .padding(.horizontal,50)                        }
                       Spacer()
                    }
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity,
                           alignment: .center)
                    
                }
            }
            
            
        }
        .navigationBarHidden(true)
    }
}
