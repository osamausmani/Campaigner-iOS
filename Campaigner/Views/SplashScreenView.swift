//
//  SplashScreenView.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/05/2023.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var isActive = false
    
    var isUserLogin = UserDefaults.standard.bool(forKey: Constants.IS_USER_LOGIN)
    
    
    var body: some View {
        NavigationView {
            ZStack {
                MainBGView()
                VStack{
                    Spacer()
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 250)
                    Spacer()
                    Image("menu-powered-by")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:120, height: 100)
                }
            }.background(
                NavigationLink(destination: isUserLogin ? AnyView(HomeScreenTabedView(presentSideMenu:true)) : AnyView(LoginScreenView()), isActive: $isActive) {
                    EmptyView()
                }
            )
            
            
        }.navigationBarHidden(true)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isActive = true
            }
        }.preferredColorScheme(.light)
    }
    
    
    func navigateToScreen() {
        sleep(2)
        //        let secondView = LoginScreenView()
    }
    
    
    struct SplashScreenView_Previews: PreviewProvider {
        static var previews: some View {
            SplashScreenView()
        }
    }
}
