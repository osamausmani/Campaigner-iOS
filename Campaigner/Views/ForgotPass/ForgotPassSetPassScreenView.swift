//
//  ForgotPassSetPassScreenView.swift
//  Campaigner
//
//  Created by Osama Usmani on 24/05/2023.
//


import SwiftUI

struct ForgotPassSetPassScreenView: View {
    
    
    @State private var password = ""
    @State private var confirmPassword = ""
    private var verificationCode = ""
    private var cnic = ""
    
    
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    
    @StateObject private var alertService = AlertService()
    @State private var isShowingLoader = false
    

    var body: some View {
        
        NavigationView {
            
            ZStack {
                BaseView(alertService: alertService)
                
                ZStack{
                    
                    Image("splash_background")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    
                    ScrollView{
                        
                        VStack {
                            
                            
                            Image("logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300, height: 250)
                                .padding(.top,50)
                            
                            Text("Set Password ").foregroundColor(CColors.MainThemeColor).font(.system(size:30, weight: .regular)).padding(.top,20)

                            
                            CustomTextInput(placeholder: "Password", text: $password, imageName: "lock", isPasswordField: true)
                            
                            CustomTextInput(placeholder: "Confirm Password", text: $confirmPassword, imageName: "lock", isPasswordField: true)
                            
                            MainButton(action: {
                                ForgotAction()
                            }, label: "Submit").padding(.top,20).frame(width: 200)
                            
                            
                        }.padding(16)
                        
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
            
        }.navigationBarHidden(true)
            .navigationTitle("")
    }
    
    
    // Add Other Swift Functions Below Here
    
    
    func ForgotAction(){
        ValidateInputs()
    }
    
    
    func ValidateInputs(){
        if(password.isEmpty){
            alertService.show(title: "Alert", message: "Pasword is required")
        }
        
        else if(confirmPassword.isEmpty){
            alertService.show(title: "Alert", message: "Confirm Pasword is required")
        }
        
        else if(password != confirmPassword){
            alertService.show(title: "Alert", message: "Password/Confirm Pasword dosen't matched")
        }
        
        else{
            SubmitRequest()
        }
    }
    
    
    func SubmitRequest(){
       
        isShowingLoader.toggle()
        
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_cnic": Global.userCNIC,
            "verification_code": Global.Verification_Code,
            "new_password": password,
            "confirm_password": confirmPassword

        ]
        print(parameters)
        print(Global.userCNIC)
        let forgotPassViewModel = ForgotPassViewModel()
        
        forgotPassViewModel.ForgotPasswordChangeRequest(parameters: parameters ) { result in
            isShowingLoader.toggle()
            
            switch result {
                
            case .success(let loginResponse):
                
                if loginResponse.rescode == 1 {
                    password=""
                    confirmPassword=""
                    
                    alertService.show(title: "Alert", message: loginResponse.message!)
                    
                    
                }else{
                    alertService.show(title: "Alert", message: loginResponse.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    
    
}
//
//struct ForgotPassSetPassScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForgotPassSetPassScreenView()
//    }
//}
