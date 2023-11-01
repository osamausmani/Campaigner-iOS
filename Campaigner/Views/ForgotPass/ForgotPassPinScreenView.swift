//
//  ForgotPassPinScreenView.swift
//  Campaigner
//
//  Created by Osama Usmani on 24/05/2023.
//


import SwiftUI

struct ForgotPassPinScreenView: View {
    
    
    @State private var token = "----"
    
    
    @State private var isForgotPassSetPassScreenView = false

    //new
    
    
    
    
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
                            
                            Text("Verification Code").foregroundColor(CColors.MainThemeColor).font(.system(size:30, weight: .regular)).padding(.top,20)
                            
                            
                          //  CustomTextInput(placeholder: "----", text: $username, imageName: "envelope")
                          //  PasscodeField
                          //  OTPInputView()
                            DesignTokenField(size: 4, token: $token)
                            
                            HStack{
                                Text("Didn't get verification code? ").foregroundColor(CColors.MainThemeColor).font(.system(size:16, weight: .regular)).padding(.top,20)
                                
                              
                                
                                Button(action:{ResendAction()}){
                                    Text("Resend Code").foregroundColor(CColors.MainThemeColor).font(.system(size:16, weight: .bold))
                                        
                                }.padding(.top,20)
                                
                                
                            }
                            
                            
                            NavigationLink(destination: ForgotPassSetPassScreenView(), isActive: $isForgotPassSetPassScreenView) {
                                MainButton(action: {
                                    isForgotPassSetPassScreenView = true
                                    
                                }, label: "Submit").frame(maxWidth: 200).padding(.top,20)
                            }
                            
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
            
        }.navigationBarHidden(false)
            .navigationTitle("")
    }
    
    
    // Add Other Swift Functions Below Here
    
    
    func ResendAction(){
        SubmitRequest()
    }
    
    
    
    
    
    func SubmitRequest(){
        isShowingLoader.toggle()
        
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_cnic": Global.userCNIC,
            
        ]
        
        let forgotPassViewModel = ForgotPassViewModel()
        
        forgotPassViewModel.SendVerifitcationCodeRequest(parameters: parameters ) { result in
            isShowingLoader.toggle()
            
            switch result {
                
            case .success(let loginResponse):
                
                if loginResponse.rescode == 1 {
                    
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

struct ForgotPassPinScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPassPinScreenView()
    }
}
