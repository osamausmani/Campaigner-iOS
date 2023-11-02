//
//  LoginScreenView.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/05/2023.
//

import SwiftUI
import Alamofire
import AlertToast

struct LoginScreenView: View {
    
    var isUserLogin = UserDefaults.standard.bool(forKey: Constants.IS_USER_LOGIN)
    
    @State private var isActive = false
    
    @State private var username = ""
    @State private var password = ""
    
    @State private var isRegisterScreenActive = false
    @State private var isForgotScreenActive = false
    @State private var isHomeScreenActive = false
    
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    
    @StateObject var alertService = AlertService()
    @State private var showToast = false
    @State private var isShowingLoader = false
    @StateObject var userData: UserData = UserData()
    
    var body: some View {
        
        NavigationView {
            ZStack {
                BaseView(alertService: alertService)
                MainBGView()
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        Image("logo")
                            .resizable()
                            .padding(.top,20)
                            .aspectRatio(contentMode: .fit)
                            .frame(
                                width: geometry.size.width * 0.6,
                                height: geometry.size.width * 0.6 * 0.75
                            )
                        VStack {
                            
                            
                            
                            CnicTextInput(placeholder: "CNIC or Mobile Number", text: $userData.username, imageName: "person")
                                .padding(.bottom,12)
                            
                            CustomTextInput(placeholder: "Password", text: $userData.password, imageName: "lock", isPasswordField: true)
                            
                            HStack{
                                Spacer()
                                NavigationLink(destination: ForgotPasswordHomeScreenView(), isActive: $isForgotScreenActive) {
                                    Button(action:{isForgotScreenActive.toggle()}){
                                        Text("Forgot Password?")
                                            .foregroundColor(.black)
                                    }.padding(.top,20)
                                    
                                }
                                
                            }
                            
                            MainButton(action: {
                                LoginAction()
                            }, label: "Login")
                            .padding(.horizontal,70)
                            .padding(3)
                            
                            LoginCustomDivider(labelText:"or connect using")
                                .padding(5)
                            HStack(spacing: 70){
                                Button(action: {
                                    // Action for Google
                                    print("Google tapped!")
                                }) {
                                    Image("google")
                                        .resizable()
                                        .frame(
                                            width: geometry.size.width * 0.18,
                                            height: geometry.size.width * 0.18
                                        )
                                }
                                
                                Button(action: {
                                    // Action for Facebook
                                    print("Facebook tapped!")
                                }) {
                                    Image("facebook")
                                        .resizable()
                                        .frame(
                                            width: geometry.size.width * 0.18,
                                            height: geometry.size.width * 0.18
                                        )
                                }
                            }
                            .padding()
                            HStack{
                                Text("Don't have an account?")
                                NavigationLink(destination: RegisterScreenView(), isActive: $isRegisterScreenActive) {
                                    Text("Sign Up Now")
                                        .bold()
                                        .underline(pattern:.solid)
                                }
                            }
                            
                            
                            
                            
                            
                            
                            
                            
                            NavigationLink(destination: HomeScreenTabedView(presentSideMenu: false), isActive: $isHomeScreenActive) {
                            }
                            
                            
                        }
                        .padding(32)
                        Spacer()
                        Spacer()
                        //
                        //                    Image("poweredby")
                        //                        .resizable()
                        //                        .aspectRatio(contentMode: .fit)
                        //                        .frame(width:120, height: 100)
                    }
                    //                .padding(.horizontal, geometry.size.width * 0.1)
                }
                
                if isShowingLoader {
                    Loader(isShowing: $isShowingLoader)
                        .edgesIgnoringSafeArea(.all)
                }
                
            }.offset(y: kGuardian.slide).animation(.easeInOut(duration: 1.0))
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }.toast(isPresenting: $showToast){
                    AlertToast(displayMode: .banner(.slide), type: .regular, title: Global.WelcomMessage)
                }
            
            
            
        }.navigationBarHidden(true)
            .accentColor(.black)
            .onAppear{
                
                if isUserLogin {
                    isHomeScreenActive.toggle()
                }
                
                
                
            }
        
    }
    
    
    
    
    
    func ForgotPassAction() {
        
    }
    
    func validateUsername() -> Bool {
        if userData.username.hasPrefix("0") {
            if userData.username.count != 12 {
                alertService.show(title: "Alert", message: "Phone number should be 11 digits.")
                return false
            } else {
                if userData.username.count != 15 {
                    alertService.show(title: "Alert", message: "CNIC should be 13 digits.")
                    return false
                }
            }
        }
        return true
    }
    
    
    func LoginAction() {
        
        //
        //                username = "82203-8631426-9"
        //                password = "12345678"
        //
        
        if !validateUsername() {
            return
        }
        
        if userData.username.isEmpty {
            alertService.show(title: "Alert", message: "CNIC/PHONE NO is required")
        }
        else if userData.password.isEmpty {
            alertService.show(title: "Alert", message: "Password is required")
        }
        
        else{
            isShowingLoader.toggle()
            
            let parameters: [String:Any] = [
                "plattype": Constants.PLAT_TYPE,
                "user_name": userData.username,
                "user_pass": userData.password,
                "os_type": Constants.OS_TYPE,
                "ios_version": Double((Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!)
            ]
            
            let loginViewModel = LoginViewModel()
            
            loginViewModel.loginRequest(parameters: parameters ) { result in
                isShowingLoader.toggle()
                
                switch result {
                    
                case .success(let loginResponse):
                    
                    if loginResponse.rescode == 1 {
                        showToast.toggle()
                        print(loginResponse.data![0])
                        let userData = loginResponse.data![0]
                        
                        UserDefaults.standard.set(true, forKey: Constants.IS_USER_LOGIN)
                        UserDefaults.standard.set(userData.cnic, forKey: Constants.USER_CNIC)
                        UserDefaults.standard.set(userData.name, forKey: Constants.USER_NAME)
                        UserDefaults.standard.set(userData.phone, forKey: Constants.USER_PHONE)
                        UserDefaults.standard.set(userData.token, forKey: Constants.USER_SESSION_TOKEN)
                        UserDefaults.standard.set(userData.user_gender, forKey: Constants.USER_GENDER)
                        UserDefaults.standard.set(userData.user_id, forKey: Constants.USER_ID)
                        UserDefaults.standard.set(userData.user_image, forKey: Constants.USER_IMAGE)
                        
                        isHomeScreenActive.toggle()
                        
                        
                        
                        
                    }else{
                        alertService.show(title: "Alert", message: loginResponse.message!)
                    }
                    
                case .failure(let error):
                    alertService.show(title: "Alert", message: error.localizedDescription)
                }
            }
        }
        
        
        
        
    }
    
    
    func RegisterAction() {
        print("Im clicked register.")
        
    }
    
}




struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView()
    }
}
