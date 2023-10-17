//
//  SubscribePopUpScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 16/06/2023.
//

import SwiftUI

struct SubscribePopUpScreenView: View
{
    @State private var isLoading = false
    @StateObject private var alertService = AlertService()
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    var body: some View {
        
        NavigationView {
            
            ZStack {
                BaseView(alertService: alertService)
             
                    Image("splash_background")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                
                ZStack{
                    ScrollView{
                        headerView(heading: "Subscription") {
   
                        }
                        VStack {
                            Spacer()
                            Spacer()
                        Text("Confirmation")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                            Spacer()
                            Text("Are you sure you want to continue?")
                                .font(.title)
                                .foregroundColor(Color(red: 0.412, green: 0.412, blue: 0.412))
                                .multilineTextAlignment(.center)
                                
                                
                            Spacer()
                            Spacer()
                            Spacer()
                            Divider()
   
                                
                        }.padding(15)
                        HStack(spacing: 20){
                            Button("Yes")
                            {
                                
                            }
                            .padding(.horizontal, 40)
                            .padding(.vertical, 7)
                            .background(CColors.MainThemeColor)
                            .foregroundColor(.white)
                            
                            Button("No")
                            {
                                
                            }
                            .padding(.horizontal, 40)
                            .padding(.vertical, 7)
                            .background(Color(red: 0.204, green: 0.204, blue: 0.204))
                            .foregroundColor(.white)
                        }
                    }
            
                }
                
                
            }
            .offset(y: kGuardian.slide).animation(.easeInOut(duration: 1.0))
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            
        }.navigationBarHidden(false)
            .navigationTitle("Search Elections")
        
            .overlay(
                        Group {
                            if isLoading {
                                ProgressHUDView()
                            }
                        }
            )
        
    }
}

struct SubscribePopUpScreenView_Previews: PreviewProvider {
    static var previews: some View
    {
        SubscribePopUpScreenView()
    }
}
