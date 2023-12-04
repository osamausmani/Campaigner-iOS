//
//  InviteMemberView.swift
//  Campaigner
//
//  Created by Macbook  on 14/06/2023.
//

import SwiftUI

struct InviteMemberScreenView: View {
    
    @State private var fvCnic = ""
    @State private var fvName = ""
    @State private var fvMobileNetwork = DropDownModel()
    @State private var fvMobileNumber = ""
   // @State private var fvPassword = ""
    @State private var fvConfirmPassword = ""
    
    @State private var showRegisterScreen = false
    @State private var isShowingLoader = false
    
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    @State var showStoreDropDown: Bool = false
    @State private var isActiveView = false
    @StateObject private var alertService = AlertService()
    @State private var isPresentMenu=false
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
                       // headerView(heading: "Add Member")
                        VStack {
                            

                            FormInputField(label: "Name", placeholder: "Enter Name", text: $fvName)
                            
                            DropDown(label: "Mobile Network", placeholder: "Select Mobile Network", selectedObj:  $fvMobileNetwork, menuOptions: networkOptions )
                            
                            MobileNoTextField(label: "Mobile Number", placeholder: "Mobile Number", text: $fvMobileNumber, isNumberInput: true)
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
            .navigationTitle("Invite Member")
            .background(CColors.MainThemeColor )
    }
    
    func RegisterAction(){
        validateInputs()
    }
    
    
    func validateInputs()
    {
      
        
      if(fvName.isEmpty){
            alertService.show(title: "Alert", message: "Name is required")
        }
        
        else if(fvMobileNetwork.value.isEmpty){
            alertService.show(title: "Alert", message: "Mobile Network is required")
        }
        
        else if(fvMobileNumber.isEmpty){
            alertService.show(title: "Alert", message: "Mobile Number is required")
        }
        
     
        
//        else if(fvConfirmPassword.isEmpty){
//            alertService.show(title: "Alert", message: "Confirm Password is required")
//        }
//
//        else if(fvPassword != fvConfirmPassword){
//            alertService.show(title: "Alert", message: "Password/Confirm Password are not same")
//        }
        else {
            doInvite()
             }
    }
    
    
    func doInvite(){
        isShowingLoader.toggle()
        
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "user_full_name": fvName,
            "user_msisdn": fvMobileNumber,

//            "telco_op":fvMobileNetwork.id

        ]
        
        let inviteViewModel = InviteViewModel()
        
        inviteViewModel.InviteMemberRequest(parameters: parameters ) { result in
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

struct InviteMemberView_Previews: PreviewProvider {
    static var previews: some View {
        InviteMemberScreenView()
    }
}
