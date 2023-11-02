//
//  ForgotPasswordScreenView.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/05/2023.
//

import SwiftUI

struct ForgotPasswordHomeScreenView: View {
    
    @State private var username = ""
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    @StateObject private var alertService = AlertService()
    @State private var isShowingLoader = false
    @State private var ForgotPassPinScreen = false
    @State private var isNavBarLinkActive = false
    var body: some View {
        
        NavigationView {
            
            ZStack {
             
                    
                    Image("splash_background")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
//
//                VStack{
//                    CustomNavBar(title: "Sign Up", destinationView: ForgotPassPinScreenView(), isActive: $isNavBarLinkActive)
//                        .edgesIgnoringSafeArea(.top)
//                    BaseView(alertService: alertService)
//                    Spacer()
//                }
                    ScrollView{
                       
                        
                        
                        VStack {
                            
                         
                       
                            Image("logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300, height: 250)
                                .padding(.top,50)
                            
                            Text("Enter CNIC").foregroundColor(CColors.MainThemeColor).font(.system(size:30, weight: .regular)).padding(.top,20)

                            
                            CnicTextInput(placeholder: "xxxxx-xxxxxxx-x", text: $username, imageName: "envelope")
                            
                          
                            
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
            .offset(y: kGuardian.slide).animation(.easeInOut(duration: 1.0))
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            
        }.navigationBarHidden(false)
            .navigationTitle("")
        NavigationLink(destination: ForgotPassPinScreenView(), isActive: $ForgotPassPinScreen) {
          
        }
    }
    
    
    // Add Other Swift Functions Below Here
    
    
    func ForgotAction(){
        ValidateInputs()
    }
    
    
    func ValidateInputs(){
        if(username.isEmpty){
            alertService.show(title: "Alert", message: "CNIC is required")
        }
        else{
            SubmitRequest()
        }
    }
    
    
    func SubmitRequest(){
        isShowingLoader.toggle()
        
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_cnic": username,
        ]
        
        let forgotPassViewModel = ForgotPassViewModel()
        
        forgotPassViewModel.SendForgotRequest(parameters: parameters ) { result in
            isShowingLoader.toggle()
            
            switch result {
                
            case .success(let loginResponse):
                
                if loginResponse.rescode == 1 {
                    
                    alertService.show(title: "Alert", message: loginResponse.message!)
                    
                    Global.userCNIC = username
                    
                    ForgotPassPinScreen = true
                    
                  
                    
                }else{
                    alertService.show(title: "Alert", message: loginResponse.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    
    
}

struct ForgotPasswordHomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordHomeScreenView()
    }
}
