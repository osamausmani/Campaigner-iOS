//
//  PayNowScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 15/06/2023.
//


import SwiftUI

struct PayNowScreenView: View {
    
    @State private var fvBank = DropDownModel()
    @State private var fvAccountTitle = ""
    @State private var fvAccountNumber = ""
    @State private var fvAmount = ""
    @State private var fvReferenceNumber = ""
    //@State private var fvConfirmPassword = ""
    
    @State private var showRegisterScreen = false
    @State private var isShowingLoader = false
    
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    @State var showStoreDropDown: Bool = false
    
    @StateObject private var alertService = AlertService()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    
    private let bankOptions: [DropDownModel] = [
        DropDownModel(id: "1", value: "MCB"),
        DropDownModel(id: "2", value: "UBL"),
        DropDownModel(id: "3", value: "HBL"),
        DropDownModel(id: "4", value: "SILK"),
        DropDownModel(id: "5", value: "ALLIED"),
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
                        
                        // Navigation bar
                        HStack {
                            Button(action: {
                                // Perform action for burger icon
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "arrowshape.left")
                                    .imageScale(.large)
    
                            }
                            Spacer()
                            Text("Pay Now")
                                .font(.headline)
    
                            Spacer()
    
                        }.foregroundColor(CColors.MainThemeColor)
                            .padding()
                            .navigationBarHidden(true)
    
                      //  Divider()
                        
                        VStack {
                            
                            
                            DropDown(label: "Bank", placeholder: "Select Bank", selectedObj:  $fvBank, menuOptions: bankOptions )
                            
                            FormInput(label: "Account Title", placeholder: "Enter Account Title", text: $fvAccountTitle)
                            
                            FormInput(label: "Account Number", placeholder: "Enter Account Number", text: $fvAccountNumber)

                            FormInput(label: "Amount", placeholder: "Enter Amount", text: $fvAmount)
                            FormInput(label: "Reference Number", placeholder: "Enter Reference Number", text: $fvReferenceNumber)
                            
                            HStack{
                                Text("File upload:")
                                CustomButton(text: "Attachment", image: "paperclip").frame(maxWidth: 180,maxHeight: 80,alignment: .topTrailing)
                                
                            }
                            MainButton(action: {
                                RegisterAction()
                            }, label: "Submit").padding(.top,20)
                            
                            
                            
                            
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
    
    
    func RegisterAction(){
        validateInputs()
    }
    
    
    func validateInputs(){
        if(fvBank.value.isEmpty){
            alertService.show(title: "Alert", message: "Bank is required")
        }
        
        else if(fvAccountTitle.isEmpty){
            alertService.show(title: "Alert", message: "Account Number is required")
        }
        
        else if(fvAccountNumber.isEmpty){
            alertService.show(title: "Alert", message: "Account Number is required")
        }
        
        else if(fvAmount.isEmpty){
            alertService.show(title: "Alert", message: "Amount is required")
        }
        
        else if(fvReferenceNumber.isEmpty){
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
//            "user_cnic": fvCnic,
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

struct PayNowScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PayNowScreenView()
    }
}
