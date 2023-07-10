//
//  ReportingScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 05/06/2023.
//

import SwiftUI
import Alamofire

struct AddReportScreenView: View {
    @StateObject private var alertService = AlertService()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var isLoading = false
    @State private var cProvince = DropDownModel()
    @State private var isOn1 = true
    
    @State  var provinceName : [DropDownModel] = []
    var body: some View {
        NavigationView {
            
            ZStack {
                BaseView(alertService: alertService)
                
                ZStack{
                    Image("splash_background")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    
                    //   ScrollView{
                    VStack(spacing: 10) {
                        //
                        // Navigation Bar
                        
                        HStack {
                            Button(action: {
                                // Perform action for burger icon
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                //                                    Image(systemName: "arrowshape.left")
                                //                                        .imageScale(.large)
                                Image(systemName: "chevron.left").tint(CColors.MainThemeColor).font(.system(size: 18))
                                Text("Back").tint(CColors.MainThemeColor).font(.system(size: 18))
                                
                            }
                            //  Spacer()
                            Text("Reporting")
                                .font(.headline)
                                .frame(width: 250)
                            
                            
                            Spacer()
                            
                            Button(action: {
                                // Perform action for bell icon
                            }) {
                                //                                                            Image(systemName: "bell")
                                //                                                                .imageScale(.large)
                                
                            }
                        }.foregroundColor(CColors.MainThemeColor)
                            .padding()
                            .navigationBarHidden(true)
                            .border(Color.gray, width: 1)
                        
                        
                        
                        
                        DropDown(label: "Type", placeholder: "Select type", selectedObj:  $cProvince, menuOptions: provinceName).padding(16)
                        
                        
                        
                        MultiLineTextField( title: "Description").padding(16)
                        
                        
                        Spacer()
                        HStack{
                            CheckboxFieldView(label: "Mark as complaint")
                            
                            CustomButton(text: "Attachments", image: "paperclip").frame(width: 200, height: 40)
                            
                        }.padding(5)
                        Spacer()
                        
                        Divider()
                        Spacer()
                        CustomButton(text: "Submit" , image: "")
                        
                    }
                    
                }
            }
            //  }
        }
        
    }
    
    
    func listPaymentHistory(){
        // isShowingLoader.toggle()
        isLoading = true
        
        let token = UserDefaults.standard.string(forKey: Constants.USER_SESSION_TOKEN)
        let headers:HTTPHeaders = [
             "Content-Type":"application/x-www-form-urlencoded",
            "x-access-token": token!
        ]
        
        let userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        
        
        
        print(token!)
        
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!
            
        ]
        
        //let registerViewModel = RegisterViewModel()
        
        
        let lookupViewModel = LookupsViewModel()
        
        lookupViewModel.listReportingTypes(parameters: parameters,headers: headers ) { result in
            // isShowingLoader.toggle()
            isLoading = false
            print(result)
            switch result {
                
            case .success(let paymentHistoryResponse):
                
                if paymentHistoryResponse.rescode == 1 {
                    
                    print(paymentHistoryResponse)
                    
                //    fin = loginResponse.data!
                    
                    //  self.presentationMode.wrappedValue.dismiss()
                    
                    
                }else{
                    alertService.show(title: "Alert", message: paymentHistoryResponse.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    func addReport()
    {
   
                isLoading = true
        

        
                let token = UserDefaults.standard.object(forKey: Constants.USER_SESSION_TOKEN) as! String
        
                print(token)
                let headers:HTTPHeaders = [
                    // "Content-Type":"application/x-www-form-urlencoded",
                    "x-access-token": token
                ]
              //  isShowingLoader.toggle()
        
        
//                for lan in constituency where lan.constituency! ==  cConstituency.value
//                {
//                    print(lan.id_text!)
//                    cConstituency.id = lan.id_text!
//                }
                var userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
                let parameters: [String:Any] = [
                    "plattype": Global.PlatType,
                    "user_id": userID!,
                   
                ]
        
                let reportingModel = ReportingViewModel()
        
        reportingModel.AddReport(parameters: parameters , headers: headers) { result in
                   // isShowingLoader.toggle()
                    isLoading = false
                    switch result {
        
                    case .success(let addResponse):
        
                        if addResponse.rescode == 1 {
        
                         //   alertService.show(title: "Alert", message: addResponse.message!)
        
                            self.presentationMode.wrappedValue.dismiss()
        
                          //  ContestingElectionScreenView.loadContestElection()
        
        
                        }else{
                            alertService.show(title: "Alert", message: addResponse.message!)
                        }
        
                    case .failure(let error):
                        alertService.show(title: "Alert", message: error.localizedDescription)
                    }
                }
  
    }
    
    func addAttachment()
    {
        
    }
    
    func getReportType()
    {
        
    }
    
    
    func submit()
    {
        
    }
}


struct AddReportScreenView_Previews: PreviewProvider {
    static var previews: some View {
        AddReportScreenView()
    }
}
