//
//  changePasswordView.swift
//  Campaigner
//
//  Created by Macbook  on 03/11/2023.
//

import SwiftUI

struct changePasswordView: View {
    @State private var isActive = false
    @State private var isPresentHome = false
    @Binding var currentPassword:String
    @Binding var newPaasword:String
    @Binding var reEnterPaasword:String
    var body: some View {
        ZStack{
            
            VStack{
                CustomNavBar(title: "Change Password", destinationView: HomeScreenView( presentSideMenu: $isPresentHome), isActive: $isActive).edgesIgnoringSafeArea(.top)
                
                Text("Enter current password. Then enter the new password and re-enter the password for confirmation")
                    .font(.system(size: 14))
                    .padding()
                    
                Spacer()
            }
          
            VStack{
                MandatoryField(label: "Current Password", placeholder: "Current Password", isSecure: true, text: $currentPassword)
                    .padding(10)
                MandatoryField(label: "New Password", placeholder: "New Password",isSecure: true, text: $newPaasword)
                    .padding(10)
                MandatoryField(label: "Re-enter New Password", placeholder: "Re-enter New Password",isSecure: true, text: $reEnterPaasword)
                    .padding(10)
                MainButton(action: {
                    
                }, label: "Submit")
                .padding(.horizontal,100)
               
            }
        }.background(Color("BackgroundColorTheme"))
    }
}

struct changePasswordView_Previews: PreviewProvider {
    static var sample = Binding<String>.constant("")
    static var previews: some View {
        changePasswordView(currentPassword: sample,newPaasword: sample,reEnterPaasword: sample)
    }
}
