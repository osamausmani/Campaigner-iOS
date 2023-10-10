//
//  ComplaintsScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 06/06/2023.
//

import SwiftUI

struct ComplaintsScreenView: View {
    @State private var selectedTab = 0
    
    @State private var cTitle = DropDownModel()
    @State private var cDescription = DropDownModel()
    @State private var cProvince = DropDownModel()
    @State private var cDistrict = DropDownModel()
    @State private var cPolling = DropDownModel()
    
    @State  var provinceName : [DropDownModel] = []
    @State  var districtName : [DropDownModel] = []
    @State  var pollingStation : [DropDownModel] = []
    
    @State  var Title : [DropDownModel] = []
    @State  var Description : [DropDownModel] = []
    
    @State private var isHidden = false
    
    @StateObject private var alertService = AlertService()
    @State private var selectedOption: String = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var isToggled = false
    
    @State private var addNewComplaintScreenViewActive = false
    
    
    var body: some View {
        NavigationView {
            
            ZStack {
                BaseView(alertService: alertService)
                NavigationLink(destination: AddNewComplaintView(), isActive: $addNewComplaintScreenViewActive) {
                }
                ZStack{
                    //                    Image("splash_background")
                    //                        .resizable()
                    //                        .edgesIgnoringSafeArea(.all)
                    
                    
                    VStack {
                        
                        HStack(spacing: 0) {
                            TabBarButton(text: "Own", isSelected: selectedTab == 0)
                            {
                                selectedTab = 0
                                //                            listPendingPayments()
                            }
                            
                            //Spacer()
                            
                            
                            // Spacer()
                            
                            TabBarButton(text: "Public", isSelected: selectedTab == 1) {
                                selectedTab = 1
                                //                            listPaymentHistory()
                            }
                            
                            
                        }
                        Spacer()
                        HStack{
                            
                            VStack{
                                
                                NoRecordView(recordMsg: "If you are facing any issues in your area, we encourage you to file a complaint with the relevent authority.")
                                
                                AddButton(action: {addNewComplaintScreenViewActive.toggle()}, label: "Add")
                                
                                
                            }
                        }.frame(maxWidth: .infinity, maxHeight:.infinity).background(CColors.TextInputBgColor)
                        
                        
                    }
                }
                
                
                
                
                
                
                //                    ScrollView{
                //                        VStack(spacing: 10) {
                //                            //
                //                            // Navigation Bar
                //
                //                            HStack {
                //                                Button(action: {
                //                                    // Perform action for burger icon
                //                                    self.presentationMode.wrappedValue.dismiss()
                //                                }) {
                //                                    Image(systemName: "chevron.left").tint(CColors.MainThemeColor).font(.system(size: 18))
                //                                    Text("Back").tint(CColors.MainThemeColor).font(.system(size: 18))
                //
                //                                }
                //                                //Spacer()
                //                                Text("Complaints")
                //                                    .font(.headline)
                //                                    .frame(width: 250)
                //
                //                                Spacer()
                //
                //                            }.foregroundColor(CColors.MainThemeColor)
                //                                .padding()
                //                                .navigationBarHidden(true)
                //
                //
                //
                //                            DropDown(label: "Category", placeholder: "Select Category", selectedObj:  $cDescription, menuOptions: Description).padding(16)
                //
                //
                //
                //                            MultiLineTextField( title: "Description").padding(16)
                //
                //
                //                            Spacer()
                //                            HStack{
                //                                //CheckboxFieldView(label: "Mark as complaint")
                //                                ToggleButtonView(isToggled: $isToggled, action: toggle)
                //
                //                                CustomButton(text: "Attachments", image: "").frame(width: 200, height: 40)
                //
                //                            }.padding(5)
                //                            Spacer()
                //
                //                            if isToggled
                //                            {
                //                                VStack {
                //
                //                                    DropDown(label: "Province", placeholder: "Select Province", selectedObj:  $cProvince, menuOptions: provinceName )
                //                                    DropDown(label: "District", placeholder: "Select District", selectedObj:  $cDistrict, menuOptions: districtName )
                //                                    DropDown(label: "Polling Station", placeholder: "Select Polling Station", selectedObj:  $cPolling, menuOptions: pollingStation )
                //
                //
                //                                    Spacer()
                //                                    Divider()
                //
                //
                //
                //
                //
                //                                }.padding(16)
                //
                //                            }
                //
                //
                //
                //
                //                            Divider()
                //                            Spacer()
                //                            CustomButton(text: "Submit" , image: "")
                //
                //                        }
                //
                //                    }
                
            }
        }.navigationBarHidden(false)
            .navigationTitle("Complaints")
        
     
        
        
    }
    
    
}

struct ComplaintsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ComplaintsScreenView()
    }
}
