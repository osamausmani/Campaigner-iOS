//
//  DowngradeAccountView.swift
//  Campaigner
//
//  Created by Macbook  on 05/12/2023.
//

import SwiftUI

struct DowngradeAccountView: View {
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Image("splash_background")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 20) {
                        
                        
                        VStack(spacing: 20) {
                            ZStack {
                                Image("downgrade")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.4)
                                    .padding(.bottom, geometry.size.height * 0.05)
                                
                                VStack {
                                    Spacer()
                                    Text("halka")
                                        .offset(y: -geometry.size.height * 0.0)
                                        .font(.title)
                                }
                            }
                            .frame(height: geometry.size.height * 0.2)
                            
                            VStack(alignment:.leading,spacing: 10) {
                                FeatureRow(icon: "tick", title: "Surveys:", description: "New surveys cannot be conducted.")
                                FeatureRow(icon: "tick", title: "Complaints:", description: "Complaints of the constituents are not accessible directly.")
                                FeatureRow(icon: "tick", title: "Reports:", description: "Reports submitted by the team leads and members will not be accessible.")
                                FeatureRow(icon: "tick", title: "Notifications:", description: "Option of sending out notifications will not remain available.")
                            }
                            .padding(.vertical)
                        }
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                        
                        VStack {
                            
                            MainButton(action: {
                            } ,label: "Swicth to halka Basic account?")
                            .padding(.horizontal,50)
                        }
                        .padding(.top, 10)
                    }
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity,
                           alignment: .center)
                    
                }
            }
        }
    }
}

struct DowngradeAccountView_Previews: PreviewProvider {
    static var previews: some View {
        DowngradeAccountView()
    }
}
