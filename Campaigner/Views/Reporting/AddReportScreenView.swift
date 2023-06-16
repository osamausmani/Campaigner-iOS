//
//  ReportingScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 05/06/2023.
//

import SwiftUI

struct AddReportScreenView: View {
    @StateObject private var alertService = AlertService()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
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
                                    Image(systemName: "arrowshape.left")
                                        .imageScale(.large)
                                    
                                }
                                Spacer()
                                Text("Reporting")
                                    .font(.headline)
                                
                                Spacer()
                                //                        Button(action: {
                                //                            // Perform action for bell icon
                                //                        }) {
                                //                            Image(systemName: "bell")
                                //                                .imageScale(.large)
                                //
                                //                        }
                            }.foregroundColor(CColors.MainThemeColor)
                                .padding()
                                .navigationBarHidden(true)
                            
                            
                            
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
    
    func addReport()
    {
        
    }
    
    func addAttachment()
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
