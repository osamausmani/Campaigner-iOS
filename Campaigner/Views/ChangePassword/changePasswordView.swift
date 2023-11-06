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
    @State private var currentPassword: String=""
    @State private var newPaasword: String=""
    @State private var reEnterPaasword: String=""
    @StateObject private var alertService = AlertService()
    @State private var isShowingLoader = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationView{
        GeometryReader { geometry in
            ZStack {
                BaseView(alertService: alertService)
                VStack(spacing: 0) {
                    //                        CustomNavBar(title: "Change Password", destinationView: HomeScreenView(presentSideMenu: $isPresentHome), isActive: $isActive)
                    //                            .edgesIgnoringSafeArea(.top)
                    
                    Text("Enter current password. Then enter the new password and re-enter the password for confirmation")
                        .font(.system(size: 14))
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                        
                    MandatoryField(label: "Current Password", placeholder: "Current Password", isSecure: true, text: $currentPassword)
                        .padding(10)
                    MandatoryField(label: "New Password", placeholder: "New Password", isSecure: true, text: $newPaasword)
                        .padding(10)
                    MandatoryField(label: "Re-enter New Password", placeholder: "Re-enter New Password", isSecure: true, text: $reEnterPaasword)
                        .padding(10)
                    MainButton(action: {
                        ChangePassAction()
                    }, label: "Submit")
                    .frame(width: geometry.size.width - 180)
                    
                }
                .padding()
              
                
                
            }
            .background(Color("CardBGColor"))
            
            
        }
      
        
        
        
    }
        .navigationTitle("Change Password")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(false)
    }

    func ChangePassAction(){
        validateInputs()
    }
    
    
    func validateInputs()
    {
      
        
      if(currentPassword.isEmpty){
            alertService.show(title: "Alert", message: "Current Password is required")
        }
        
        else if(newPaasword.isEmpty){
            alertService.show(title: "Alert", message: "New Password is required")
        }
        
        else if(reEnterPaasword.isEmpty){
            alertService.show(title: "Alert", message: "Please Re-Enter your password")
        }
        


        else {
            doChange()
             }
    }
    
    
    func doChange(){
        isShowingLoader.toggle()
        var parameters: [String: Any] = [
            "plattype": Global.PlatType,
            "old_password": currentPassword,
            "new_password": newPaasword,
            "confirm_password": reEnterPaasword,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!
        ]

        if let userCNIC = UserDefaults.standard.string(forKey: Constants.USER_CNIC) {
            parameters["user_cnic"] = userCNIC
        } else {
            parameters["user_cnic"] = UserDefaults.standard.string(forKey: Constants.USER_PHONE)!
        }

        
        let changePasswordViewModel = ChangePasswordViewModel()
        
        changePasswordViewModel.ChangePasswordRequest(parameters: parameters ) { result in
            isShowingLoader.toggle()
            
            switch result {
                
            case .success(let inviteResponse):
                
                if inviteResponse.rescode == 1 {
                    
                    alertService.show(title: "Alert", message: inviteResponse.message!)
                    
                    self.presentationMode.wrappedValue.dismiss()
                    
                }else{
                    alertService.show(title: "Alert", message: inviteResponse.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }

}

struct changePasswordView_Previews: PreviewProvider {
    static var sample = Binding<String>.constant("")
    static var previews: some View {
        changePasswordView()
    }
}
