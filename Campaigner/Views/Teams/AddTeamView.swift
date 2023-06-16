//
//  AddTeamView.swift
//  Campaigner
//
//  Created by Macbook  on 14/06/2023.
//

import SwiftUI

struct AddTeamView: View {
    
    @State private var fvTeamName = ""
    @State private var fvPollingStations = DropDownModel()
    @State private var fvDescription = ""

    
    @State private var showRegisterScreen = false
    @State private var isShowingLoader = false
    
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    @State var showStoreDropDown: Bool = false
    
    @StateObject private var alertService = AlertService()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    
    private let pollingStationsOptions: [DropDownModel] = [
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
                        headerView(heading: "Add Team", action: dismissView)
                        VStack {
                            
                            

                            FormInput(label: "Team Name", placeholder: "Enter Name", text: $fvTeamName)
                            
                            DropDown(label: "Polling Station", placeholder: "Select Polling Station", selectedObj:  $fvPollingStations, menuOptions: pollingStationsOptions )
                            
                           // FormInput(label: "Description", placeholder: "Description", text: $fvDescription, isNumberInput: true)
//                            FormInput(label: "Password", placeholder: "Password", text: $fvPassword, isSecure: true)
//                            FormInput(label: "Confirm password", placeholder: "Confirm Password", text: $fvConfirmPassword, isSecure: true)
                            
                            
                            MultiLineTextField( title: "Description")
                            Spacer()
                            Spacer()
                            Divider()
                         
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

        
         if(fvTeamName.isEmpty){
            alertService.show(title: "Alert", message: "Team Name is required")
        }
        
        else if(fvPollingStations.value.isEmpty){
            alertService.show(title: "Alert", message: "Polling Station is required")
        }
        
        else if(fvDescription.isEmpty){
            alertService.show(title: "Alert", message: "Mobile Number is required")
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
//            "user_full_name": fvPassword,
//            "user_msisdn": fvMobileNumber,
//            "user_pass": fvPassword,
//            "telco_op":fvMobileNetwork.id

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

struct AddTeamView_Previews: PreviewProvider {
    static var previews: some View {
        AddTeamView()
    }
}
