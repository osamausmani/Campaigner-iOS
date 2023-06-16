//
//  AddMemberView.swift
//  Campaigner
//
//  Created by Macbook  on 14/06/2023.
//

import SwiftUI

struct AddMemberView: View {
    
    @State private var fvCnic = ""
    @State private var fvName = ""
    @State private var fvMobileNetwork = DropDownModel()
    @State private var fvMobileNumber = ""
    @State private var fvPassword = ""
    @State private var fvConfirmPassword = ""
    
    @State private var showRegisterScreen = false
    @State private var isShowingLoader = false
    
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    @State var showStoreDropDown: Bool = false
    
    @StateObject private var alertService = AlertService()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    
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
                        headerView(heading: "Add Member", action: dismissView)
                        VStack {
                            
                            
                            FormInput(label: "CNIC", placeholder: "Enter CNIC", text: $fvCnic, isCnic: true)
                            FormInput(label: "Name", placeholder: "Enter Name", text: $fvName)
                            
                            DropDown(label: "Mobile Network", placeholder: "Select Mobile Network", selectedObj:  $fvMobileNetwork, menuOptions: networkOptions )
                            
                            FormInput(label: "Mobile Number", placeholder: "Mobile Number", text: $fvMobileNumber, isNumberInput: true)
//                            FormInput(label: "Password", placeholder: "Password", text: $fvPassword, isSecure: true)
//                            FormInput(label: "Confirm password", placeholder: "Confirm Password", text: $fvConfirmPassword, isSecure: true)
                            
                            MainButton(action: {
                                RegisterAction()
                            }, label: "Invite").padding(.top,20)
                            
                            
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
            .navigationTitle("Sign Up")
    }
    
    
    // Add Other Swift Functions Below Here
    
    func dismissView()
    {
        self.presentationMode.wrappedValue.dismiss()
    }
    func RegisterAction(){
        validateInputs()
    }
    
    
    func validateInputs(){
        if(fvCnic.isEmpty){
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
        
//        else if(fvConfirmPassword.isEmpty){
//            alertService.show(title: "Alert", message: "Confirm Password is required")
//        }
//
//        else if(fvPassword != fvConfirmPassword){
//            alertService.show(title: "Alert", message: "Password/Confirm Password are not same")
//        }
        else{
            doRegister()
        }
    }
    
    
    func doRegister(){
        isShowingLoader.toggle()
        
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_cnic": fvCnic,
            "user_full_name": fvPassword,
            "user_msisdn": fvMobileNumber,
            "user_pass": fvPassword,
            "telco_op":fvMobileNetwork.id

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

struct AddMemberView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemberView()
    }
}
