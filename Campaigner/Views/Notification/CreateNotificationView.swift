//
//  CreateNotification.swift
//  Campaigner
//
//  Created by Macbook  on 18/10/2023.
//

import SwiftUI

struct CreateNotificationView: View {
    @State private var selectedTabIndex: Int = 0
    @State private var subject=""
    @State private var details=""
    @State private var time: Date = Date()
    @State private var date: Date = Date()
    @State private var showActionSheet = false
    @State private var showImagePicker = false
    @State private var sourceType = 0
    @State private var cTitle = DropDownModel()
    @State private var selectedMemberType = DropDownModel()
    @State private var selectedDistrict = DropDownModel()
    @State private var selectedTehsil = DropDownModel()
    @State private var selectedGender = DropDownModel()

     let sampleDropDownModels = [
        DropDownModel(id: "1", value: "Member Type"),
        DropDownModel(id: "2", value: "Area"),
        DropDownModel(id: "3", value: "Gender")
    ]
    let sampleDropDownMember = [
       DropDownModel(id: "1", value: "Active"),
       DropDownModel(id: "2", value: "Suspended"),
       DropDownModel(id: "3", value: "All")
   ]
    let sampleDropDownDistrict = [
       DropDownModel(id: "1", value: "District A"),
       DropDownModel(id: "2", value: "District B"),
       DropDownModel(id: "3", value: "District C")
    ]
    let sampleDropDownTehsil = [
       DropDownModel(id: "1", value: "Tehsil A1"),
       DropDownModel(id: "2", value: "Tehsil A2"),
       DropDownModel(id: "3", value: "Tehsil A3")
    ]
    let sampleDropDownGender = [
       DropDownModel(id: "1", value: "Male"),
       DropDownModel(id: "2", value: "Female"),
       DropDownModel(id: "3", value: "All")
    ]
    
    @State private var isNavBarLinkActive = false
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                
                CustomNavBar(title: "Create Notification", destinationView: ShowNotificationView(), isActive: $isNavBarLinkActive)
                    .edgesIgnoringSafeArea(.top)
                TabBarView(selectedTab: $selectedTabIndex, tabNames: ["Basic Information", "Audience"])
                    .offset(y: -55)
                if selectedTabIndex==0{
                VStack(alignment:.leading,spacing: 10 ){
                 
                        
                        FormInputMandatory(label: "Subject", placeholder: "Type here", text: $subject)
                            .padding(.horizontal,20)
                            .padding(.top,30)
                    FormInput(label: "URL", placeholder: "Type here", text: $subject)
                        .padding(.horizontal,20)
                        MultilineInputMandatory(label: "Detail", placeholder: "Type details", text: $details)
                            .padding(.horizontal,20)
                    
                        ScheduleView(label: "Schedule", selectedDate: $date, selectedTime: $time)
                            .padding(.leading,20)
                        
            
                    
                    HStack(alignment: .top,spacing: 0){
                        Text("File Upload")
                            .padding()
                        CustomButton(text: "Attachment", image: "paperclip", action: {
                            self.showActionSheet = true
                        })
                        .actionSheet(isPresented: $showActionSheet) {
                            ActionSheet(title: Text("Select Image"), message: nil, buttons: [
                                .default(Text("Photo Library")) {
                                    // Handle selection from photo library
                                    self.sourceType = 0
                                    self.showImagePicker = true
                                },
                                .default(Text("Camera")) {
                                    // Handle selection from camera
                                    self.sourceType = 1
                                    self.showImagePicker = true
                                },
                                .cancel()
                            ])
                        }


                    }
                    
                    dividerline()
                    
                    MainButton(action: next, label: "Next")
                        .padding(.horizontal,100)
                    
                    Spacer()
                    
                }
                
                .background(Color.white)
                .cornerRadius(15)
                .padding(.horizontal)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                .offset(y: -100)
            }
                else {
                    VStack(alignment:.leading,spacing: 10 ){
                        
                        DropDownMandatory(label: "Select Criteria", placeholder: "Select Critera", selectedObj: $cTitle, menuOptions: sampleDropDownModels)
                            .padding(.horizontal,20)
                            .padding(.top,30)
                        Spacer()
                        if let selectedIndexCriteria = sampleDropDownModels.firstIndex(where: { $0.id == cTitle.id }) {
                            if selectedIndexCriteria==0{
                                DropDownMandatory(label: "Member Type", placeholder: "Select Member Type", selectedObj: $selectedMemberType, menuOptions: sampleDropDownMember)
                                    .padding(.horizontal,20)
                                Spacer()
                                    .frame(maxHeight: .infinity)
                                if let selectedIndexmember = sampleDropDownMember.firstIndex(where: { $0.id == selectedMemberType.id }) {
                                    if selectedIndexmember>=0{
                                        
                                        MainButton(action: addaudience, label: "Add Audience")
                                            .padding(.horizontal,20)
                                        Spacer()
                                            .frame(maxHeight: .infinity)
                                        
                                        
                                    }
                                }
                            }
                            else if selectedIndexCriteria == 1 {
                                   DropDownMandatory(label: "District", placeholder: "Select District", selectedObj: $selectedDistrict, menuOptions: sampleDropDownDistrict)
                                       .padding(.horizontal,20)
                                Spacer()
                                    .frame(maxHeight: .infinity)
                                   
                                   if let selectedIndexDistrict = sampleDropDownDistrict.firstIndex(where: { $0.id == selectedDistrict.id }) {
                                       
                                           DropDownMandatory(label: "Tehsil", placeholder: "Select Tehsil", selectedObj: $selectedTehsil, menuOptions: sampleDropDownTehsil)
                                               .padding(.horizontal,20)
                                       if selectedIndexDistrict >= 0 {
                                           MainButton(action: addaudience, label: "Add Audience")
                                               .padding(.horizontal,20)
                                           Spacer()
                                               .frame(maxHeight: .infinity)
                                       }
                                   }
                               }
                            else if selectedIndexCriteria==2{
                                DropDownMandatory(label: "Gender", placeholder: "Select Gender", selectedObj: $selectedGender, menuOptions: sampleDropDownGender)
                                    .padding(.horizontal,20)
                                Spacer()
                                    .frame(maxHeight: .infinity)
                                if let selectedIndexgender = sampleDropDownMember.firstIndex(where: { $0.id == selectedGender.id }) {
                                    if selectedIndexgender>=0{
                                        MainButton(action: addaudience, label: "Add Audience")
                                            .padding(.horizontal,20)
                                        Spacer()
                                            .frame(maxHeight: .infinity)
                                        
                                       
                                    }
                                }
                            }
                        } else {
                         
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                    .offset(y: -350)
                }
                
                
            }
            .background(Color("BackgroundColorTheme"))
            
            
        }
        .navigationBarHidden(true)
    }
    func addaudience(){
        
    }
    func next(){
        if selectedTabIndex < 1 {
              selectedTabIndex += 1
          } else {
              
              
             
          }
    }
}



struct CreateNotification_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CreateNotificationView()
                .previewDevice("iPhone 11 Pro Max")
            CreateNotificationView()
                .previewDevice("iPhone 14 Plus")
        }
    }
}

