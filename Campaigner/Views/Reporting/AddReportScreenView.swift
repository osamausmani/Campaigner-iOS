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
   // @State private var isOn1 = true
    @State private var isChecked = false
    @State private var fvDescription = ""
    @State var selectedImage: UIImage?
    @State var reportingType = [ListReportingType]()
    @State private var sourceType = 0
    @State private var showImagePicker = false
    @State private var showActionSheet = false
    
    @State  var reportingTypeName : [DropDownModel] = []
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
                        
                        
                        
                        
                        DropDown(label: "Type", placeholder: "Select type", selectedObj:  $cProvince, menuOptions: reportingTypeName).padding(16)
                        
                        
                        
                       // MultiLineTextField( title: "Description").padding(16)
                        MultilineFormInput(label: "Description", placeholder: "Enter Description", text: $fvDescription).padding(10)
                        
                        
                        Spacer()
                        HStack{
                            CheckboxFieldView(isChecked: $isChecked, label: "Mark as complaint")
                            
                            //CustomButton(text: "Attachments", image: "paperclip").frame(width: 200, height: 40)
                            
                            MainButton(action: {
                              //
                                showActionSheet = true
                               // promptForImageSelection()
                                
                            }, label: "Attachment").frame(maxWidth: 180,maxHeight: 60,alignment: .topTrailing).actionSheet(isPresented: $showActionSheet) {
                                ActionSheet(title: Text("Select Image"), message: nil, buttons: [
                                    .default(Text("Photo Library")) {
                                        // Handle selection from photo library
                                        self.sourceType = 0
                                        self.showImagePicker = true
                                    },
                                    .default(Text("Camera"))
                                    {
                                        // Handle selection from camera
                                        self.sourceType = 1
                                        self.showImagePicker = true
                                    },
                                    .cancel()
                                ])
                            }
                        
                            
                        }.padding(5)
                       // Spacer()
                        
                        if let image = selectedImage {
                                       Image(uiImage: image)
                                           .resizable()
                                           .aspectRatio(contentMode: .fit)
                                           .frame(width: 150, height: 150)
                                   } else {
                                       Text("No image selected")
                                   }
                        
                        Divider()
                        Spacer()
                   //     CustomButton(text: "Submit" , image: "")
                        
                        MainButton(action: {
                            addReport()
                        }, label: "Submit").frame(maxWidth: 180,maxHeight: 40,alignment: .center) .frame(maxWidth: .infinity,
                                                                                                         maxHeight: .infinity,
                                                                                                        alignment: .top)
                        
                    }
                    
                }
            }.sheet(isPresented: $showImagePicker)
            {
             ImageUploader(selectedImage: $selectedImage, sourceTypeNo: sourceType)
             }
            //  }
        }.onAppear{
            listReportingType()
        }
        
    }
    
    
    func listReportingType(){
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
        var newDropDownData : [DropDownModel] = []
        
        let lookupViewModel = LookupsViewModel()
        
        lookupViewModel.ListReportingTypes(parameters: parameters,headers: headers ) { result in
            // isShowingLoader.toggle()
            isLoading = false
            print(result)
            switch result {
                
            case .success(let Response):
                
                if Response.rescode == 1 {
                    
                    print(Response)
                    
//                    fin = loginResponse.data!
//
//                    provinceName
                    
                    reportingType = Response.data!
                    
                    for i in reportingType
                    {
                        let dropDownModel = DropDownModel(id: i.type_id!, value: i.type_name!)
                        newDropDownData.append(dropDownModel)
                    }
                    //  provinceName = []
                    //   provinceName.append(contentsOf: newDropDownData)
                    
                    reportingTypeName = newDropDownData
                    
                    //  self.presentationMode.wrappedValue.dismiss()
                    
                    
                }else{
                    alertService.show(title: "Alert", message: Response.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    func addReport()
    {
   
                isLoading = true
        
        var finReportType = ""
               for i in reportingType{
                   if( i.type_name == cProvince.value)
                   {
                       finReportType = i.type_id ?? ""
                  }
               }

        
                let token = UserDefaults.standard.object(forKey: Constants.USER_SESSION_TOKEN) as! String
        
                print(token)
                let headers:HTTPHeaders = [
                    // "Content-Type":"application/x-www-form-urlencoded",
                    "x-access-token": token
                ]

                var userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
                let parameters: [String:Any] = [
                    "plattype": Global.PlatType,
                    "user_id": userID!,
                    "report_type": finReportType,
                    "report_desc": fvDescription,
                    "is_complaint": isChecked == true ? "1":"0",
                    "loc_lat": "0",
                    "loc_lng": "0",
                    "loc_text": "",
                    "file": ""
                
                    
                   
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
