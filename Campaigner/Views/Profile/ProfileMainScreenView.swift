//
//  ProfileMainScreen.swift
//  Campaigner
//
//  Created by Osama Usmani on 24/05/2023.
//

import Foundation
import SwiftUI
import Alamofire


struct ProfileMainScreenView: View {
    
    @State private var username = ""
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    @StateObject private var alertService = AlertService()
    @State private var isShowingLoader = false
    @State private var ForgotPassPinScreen = false
    
    @State var tabIndex = 0

    
    var body: some View {
        NavigationView {
            ZStack {
                BaseView(alertService: alertService)
                ZStack{
                    Image("splash_background")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack{
                        VStack{
                            HStack {
                                // Left Subview with Image
                                Image("default_large_image")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(50) // Apply radius to make it circular
                                
                                // Right Subview with Labels and Icon
                                VStack(alignment: .leading) {
                                    Text(UserDefaults.standard.string(forKey: Constants.USER_NAME) ?? "UserName")
                                        .font(.headline)
                                    HStack {
                                        Image(systemName: "phone.fill") // Replace with your icon name
                                        Text(UserDefaults.standard.string(forKey: Constants.USER_PHONE) ?? "UserPhone")
                                    }.padding(.top,1)
                                }
                                .padding(.leading, 10)
                                Spacer()
                            }
                            
                            HStack{
                                Button(action: {
                                    // Handle button tap action here
                                }) {
                                    Image(systemName: "plus.circle")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .background(CColors.MainThemeColor)
                                        .clipShape(Circle())
                                    
                                }.frame(width: 24, height: 24)
                                    .padding(.trailing,1)
                                Text("Referral ID")
                                Spacer()
                            }.padding(.top,2)
                            
                        }.padding(.leading,30).padding(.trailing,30).padding(.bottom,16)
                        
                        HStack(spacing: 4) {
                            Button(action: { tabIndex = 0 }) {
                                Text("Profile")
                                    .padding()
                                    .frame(height: 40)

                                    .font(.system(size: 14))
                                    .background(tabIndex == 0 ? CColors.MainThemeColor : CColors.SecondaryColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(4)
                            }
                            
                            Button(action: { tabIndex = 1 }) {
                                Text("Electoral Experience")
                                    .font(.system(size: 14))
                                    
                                    .padding()
                                    .frame(height: 40)

                                    .background(tabIndex == 1 ? CColors.MainThemeColor : CColors.SecondaryColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(4)
                            }
                            
                            Button(action: { tabIndex = 2 }) {

                                Text("Political Career")
                                    .font(.system(size: 14))
                                    .padding()
                                    .frame(height: 40)

                                    .background(tabIndex == 2 ? CColors.MainThemeColor : CColors.SecondaryColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(4)
                            }
                        }
                        
                        VStack{
        
                        tabIndex == 0 ? ProfileSection(): nil
                        tabIndex == 1 ? ElectoralSection(): nil
                        tabIndex == 2 ? PoliticalSection(): nil
                        }.padding(10)

                        Spacer()
                        
                    }
                    if isShowingLoader {
                        Loader(isShowing: $isShowingLoader)
                            .edgesIgnoringSafeArea(.all)
                    }
                }
                
                
            }
            .offset(y: kGuardian.slide).animation(.easeInOut(duration: 1.0))
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            
        }.navigationBarHidden(false)
            .navigationTitle("Profile")
        NavigationLink(destination: ForgotPassPinScreenView(), isActive: $ForgotPassPinScreen) {
            
        }
        
    }
    
    


}

struct ProfileMainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMainScreenView()
    }
}
