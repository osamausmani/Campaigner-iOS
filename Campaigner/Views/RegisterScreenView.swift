//
//  RegisterScreenView.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/05/2023.
//

import SwiftUI

struct RegisterScreenView: View {
    @State private var CNIC=""
    @State private var Mobile_Number=""
    @State private var fvCnic = ""
    @State private var fvName = ""
    @State private var fvMobileNetwork = DropDownModel()
    @State private var fvMobileNumber = ""
    @State private var fvPassword = ""
    @State private var signupType =  "1"
    @State private var fvConfirmPassword = ""
    
    @State private var selectedOption: String = RadioOption.CNIC.rawValue
    
    @State private var showRegisterScreen = false
    @State private var isShowingLoader = false
    
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    @State var showStoreDropDown: Bool = false
    
    @StateObject private var alertService = AlertService()
    @State private var isNavBarLinkActive = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    enum RadioOption: String {
        case CNIC = "CNIC"
        case MobileNumber = "Mobile Number"
    }
    
    
    
    private let networkOptions: [DropDownModel] = [
        DropDownModel(id: "1", value: "Ufone"),
        DropDownModel(id: "2", value: "Telenor"),
        DropDownModel(id: "3", value: "Jazz"),
        DropDownModel(id: "4", value: "Zong"),
        DropDownModel(id: "5", value: "Scom"),
    ]
    
    var body: some View {
        NavigationView {
            
            ZStack {
                BaseView(alertService: alertService)
                
                
                
                
                ZStack{
                    
                    Image("splash_background")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    
                    ScrollView{
                        
                        CustomNavBar(title: "Sign Up", destinationView: LoginScreenView(), isActive: $isNavBarLinkActive)
                            .ignoresSafeArea()
                        
                        
                        
                        
                        HStack {
                            Spacer()
                            RadioButton(option: RadioOption.CNIC.rawValue, selectedOption: $selectedOption)
                            Spacer()
                            RadioButton(option: RadioOption.MobileNumber.rawValue, selectedOption: $selectedOption)
                            Spacer()
                        }.padding(.top,30)
                        
                        
                        VStack {
                            
                            if selectedOption == RadioOption.CNIC.rawValue {
                                
                                FormInput(label: "CNIC", placeholder: "xxxxx-xxxxxxx-x", text: $fvCnic)
                                
                            }
                          
                            TextFields(label: "Name", placeholder: "Name", text: $fvName)
                          
                            DropDown(label: "Mobile Network", placeholder: "Select Mobile Network", selectedObj:  $fvMobileNetwork, menuOptions: networkOptions )
                            
                            MobileNoTextField(label: "Mobile Number", placeholder: "03xx3xxxxxx", text: $fvMobileNumber, isNumberInput: true)
                            TextFields(label: "Password", placeholder: "********", text: $fvPassword, isSecure: true)
                            TextFields(label: "Confirm password", placeholder: "********", text: $fvConfirmPassword, isSecure: true)
                            
                            MainButton(action: {
                                RegisterAction()
                            }, label: "Save").padding(.top,20)
                                .padding(.horizontal,80)
                            
                            
                        }.padding(16)
                        
                    }
                    
                    if isShowingLoader {
                        Loader(isShowing: $isShowingLoader)
                            .edgesIgnoringSafeArea(.all)
                    }
                }
                
                
            }
            .edgesIgnoringSafeArea(.top)
            .offset(y: kGuardian.slide).animation(.easeInOut(duration: 1.0))
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            
        }.navigationBarHidden(true)
            .navigationTitle("")
    }
    
    
    // Add Other Swift Functions Below Here
    
    
    func RegisterAction(){
        validateInputs()
    }
    
    
    func validateInputs(){
        if selectedOption == RadioOption.CNIC.rawValue && fvCnic.isEmpty  {
            
               alertService.show(title: "Alert", message: "CNIC is required")
           }
      
        else if(fvName.isEmpty){
            alertService.show(title: "Alert", message: "Name is required")
        }
        
        else if(fvMobileNetwork.value.isEmpty){
            alertService.show(title: "Alert", message: "Mobile Network is required")
        }
        
        else if(fvMobileNumber.isEmpty){
            alertService.show(title: "Alert", message: "Mobile Number is required")
        }
        
        else if(fvPassword.isEmpty){
            alertService.show(title: "Alert", message: "Password is required")
        }
        
        else if(fvConfirmPassword.isEmpty){
            alertService.show(title: "Alert", message: "Confirm Password is required")
        }
        
        else if(fvPassword != fvConfirmPassword){
            alertService.show(title: "Alert", message: "Password/Confirm Password are not same")
        }
        else{
            doRegister()
        }
        //        if selectedOption == RadioOption.MobileNumber.rawValue && fvMobileNumber.isEmpty && fvCnic.count == 12  {
        //            alertService.show(title: "Alert", message: "Mobile Network is required")
        //           }
        //
        //        else if(fvName.isEmpty){
        //            alertService.show(title: "Alert", message: "Name is required")
        //        }
        //
        //        else if(fvMobileNetwork.value.isEmpty){
        //            alertService.show(title: "Alert", message: "Mobile Network is required")
        //        }
        //
        //
        //        else if(fvPassword.isEmpty){
        //            alertService.show(title: "Alert", message: "Password is required")
        //        }
        //
        //        else if(fvConfirmPassword.isEmpty){
        //            alertService.show(title: "Alert", message: "Confirm Password is required")
        //        }
        //
        //        else if(fvPassword != fvConfirmPassword){
        //            alertService.show(title: "Alert", message: "Password/Confirm Password are not same")
        //        }
        //        else{
        //            doRegister()
        //        }
    }
    
    
    func doRegister(){
        isShowingLoader.toggle()
        if selectedOption == RadioOption.CNIC.rawValue {
            signupType="1"
        }
        else{
            signupType="2"
        }
        let parameters: [String:Any] = [
           
            "plattype": Global.PlatType,
            "user_cnic": fvCnic,
            "user_full_name": fvPassword,
            "user_msisdn": fvMobileNumber,
            "user_pass": fvPassword,
            "telco_op":fvMobileNetwork.id,
            "signup_type" : signupType
        ]
        
        let registerViewModel = RegisterViewModel()
        
        registerViewModel.registerNewAccountRequest(parameters: parameters ) { result in
            isShowingLoader.toggle()
            
            switch result {
                
            case .success(let loginResponse):
                
                if loginResponse.rescode == 1 {
                    
                    alertService.show(title: "Alert", message: loginResponse.message!)
                    
                    self.presentationMode.wrappedValue.dismiss()
                    
                }else{
                    alertService.show(title: "Alert", message: loginResponse.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    
    
}

struct RegisterScreenView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreenView()
    }
}
