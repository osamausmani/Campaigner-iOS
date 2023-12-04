//
//  AddMemberView.swift
//  Campaigner
//
//  Created by Macbook  on 14/06/2023.
//

import SwiftUI
import SwiftAlertView

struct AddMemberView: View {
    
    @State private var fvName = ""
    @State private var fvMobileNo = ""
    
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var contactsScreenViewActive = false

    var body: some View {
        VStack{
            
            NavigationLink(destination: ContactsScreenView(), isActive: $contactsScreenViewActive) {
            }
            
            CustomNavBarBack(title: "Add Member")
            VStack {
                
                FormInputField(label: "Name", placeholder: "Enter Name", text: $fvName)
                MobileNoTextField(label: "Mobile Number", placeholder: "Mobile Number", text: $fvMobileNo, isNumberInput: true)
                Divider().background(.black)
                
                MainButton(action: {
                    RegisterAction()
                }, label: "Invite").padding(20)
                
                Divider().background(.black)
                Text("OR").padding(20).foregroundColor(CColors.MainThemeColor).bold()
                
                Text("Select From Contact List").padding(0).foregroundColor(.blue).bold().underline().onTapGesture {
                    contactsScreenViewActive.toggle()
                }
                
                Spacer()
            }.padding(16)
            
        }.navigationBarHidden(true).edgesIgnoringSafeArea(.top)
        
        
    }
    
    
    func RegisterAction(){
        ValidateInputs()
    }
    
    
    func ValidateInputs(){
        if(fvName.isEmpty){
            SwiftAlertView.show(title: "Alert", message: "Name is required", buttonTitles: "OK")
        }
        else if(fvMobileNo.isEmpty){
            SwiftAlertView.show(title: "Alert", message: "Mobile Number is required", buttonTitles: "OK")

        }

        else{
            SubmitAction()
        }
    }
    
    
    func SubmitAction(){
        
        let parameters: [String:Any] = [
            "plattype": Constants.PLAT_TYPE,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "user_full_name": fvName,
            "user_msisdn": fvMobileNo,
            
        ]
        
        let RequestModel =  InviteViewModel()
        
        RequestModel.InviteMemberRequest(parameters: parameters ) { result in
            switch result {
            case .success(let response):
                if response.rescode == 1 {
                    SwiftAlertView.show(title: "Alert", message: response.message, buttonTitles: "OK")
                    self.presentationMode.wrappedValue.dismiss()
                }else{
                    SwiftAlertView.show(title: "Alert", message: response.message, buttonTitles: "OK")                }
            case .failure(let error):
                SwiftAlertView.show(title: "Alert", message: error.localizedDescription, buttonTitles: "OK")            }
        }
    }
    
    
    
}

struct AddMemberView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemberView()
    }
}
