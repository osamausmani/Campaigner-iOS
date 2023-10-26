//
//  AddSurveyScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 06/06/2023.
//

import SwiftUI

struct AddSurveyScreenView: View {
    
    @State private var ftitle = ""
    
    @State private var showingQuestionare = false
    
    @State private var cTitle = DropDownModel()
    @State private var cDescription = DropDownModel()
    @State private var isPresentNode:Bool=false
    @State  var Title : [DropDownModel] = []
    @State  var Description : [DropDownModel] = []
    @State var varDescription=""
    @State private var selectedTab = 0
    @StateObject private var alertService = AlertService()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var selectedOption: String = ""
    @State private var selectedMemberType = DropDownModel()
    @State private var selectedDistrict = DropDownModel()
    @State private var selectedTehsil = DropDownModel()
    @State private var selectedGender = DropDownModel()
    @State var varQuestion=""
    let sampleQuestionsList = [
       DropDownModel(id: "1", value: "Yes/No"),
       DropDownModel(id: "2", value: "Multiple Choice"),
       DropDownModel(id: "3", value: "Answer in text form")
   ]
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
    let options = ["Single Attempt", "Multiple Attempt"]
    var body: some View {
        
        NavigationView {
            
            ZStack {
                BaseView(alertService: alertService)
                Color("BackgroundColorTheme")
                    .ignoresSafeArea()
                VStack(spacing: 0)
                {
                    CustomNavBar(title: "Add Survey", destinationView: SurveyScreenView(), isActive: $isPresentNode)
                        .edgesIgnoringSafeArea(.top)
                    HStack(spacing: 0) {
                        Spacer()
                        TabBarButton(text: "Info", isSelected: selectedTab == 0)
                        {
//                            selectedTab = 0
                            //  listPendingPayments()
                        }
                    

                        
                        //Spacer()
                        
                        TabBarButton(text: "Questions", isSelected: selectedTab == 1) {
//                            selectedTab = 1
                        }
                      

                        
                        // Spacer()
                        
                        TabBarButton(text: "Audience", isSelected: selectedTab == 2) {
//                            selectedTab = 2
                            //   listPaymentHistory()
                        }

                       
                        
                    }
                        .foregroundColor(Color.black)
                        .background(.white)
    
                    Spacer()
                   
           
                
                ScrollView{
                    
                    //                    HStack {
                    //
                    //                        Button(action: {
                    //                            // Perform action for burger icon
                    //                            self.presentationMode.wrappedValue.dismiss()
                    //
                    //                        }) {
                    //                            Image(systemName: "chevron.left").tint(CColors.MainThemeColor).font(.system(size: 18))
                    //                            Text("Back").tint(CColors.MainThemeColor).font(.system(size: 18))
                    //                        }
                    //
                    //                        //  Spacer()
                    //
                    //                        Text("Add Survey")
                    //                            .font(.headline)
                    //                            .frame(width: 250)
                    //
                    //
                    //                        Spacer()
                    //
                    //
                    //                    }.foregroundColor(Color.black)
                    //                        .frame(height: 40)
                    //                        .padding()
                    //                    Divider()
                    
                   
                    VStack(alignment: .leading)
                        {
                            
                            if selectedTab == 0
                            {
                                FormInputMandatory(label: "Title", placeholder: "Type Title", text: $ftitle).padding(20)
                                Spacer()
                                MultilineInputMandatory(label: "Description", placeholder: "Enter description", text: $varDescription).padding(20)
                                Spacer()
                                
                                labelMandatory(label: "Survey Attempt")
                            
                                Spacer()
                                HStack {
                                    ForEach(options, id: \.self) { option in
                                        RadioButton(option: option, selectedOption: $selectedOption)
                                    }
                                }.padding(30)
                                Spacer()
                                CustomButton(text: "Next", image: "", action: {
                                    if ftitle.isEmpty==true{
                                        
                                    }
                                    else if varDescription.isEmpty==true{
                                        
                                    }
                                    else if selectedOption==""{
                                        
                                    }
                                    else{
                                        selectedTab+=1
                                    }
                                    
                                }).padding(40)
                            }
                            else if selectedTab == 1
                            {
                                MultilineInputMandatory(label: "Question", placeholder: "Type Question", text: $varQuestion).padding(14)
                                DropDownMandatory(label: "Question Type", placeholder: "Select Question Type", selectedObj:  $cTitle, menuOptions: sampleQuestionsList ).padding(14)
                                
                                CustomButton(text: "Save", image: "", action: {
                                    selectedTab+=1
                                }).padding(40)
                                if (showingQuestionare == true)
                                {
                                    
                                }
                                if varQuestion.isEmpty==true{
                                    
                                }
                              
                                else{
//                                    sampleQuestionsList.append(contentsOf: varQuestion,)
                                }
                                
                               
                            }else if selectedTab == 2{
                              
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
                            
                            
                            
                        } .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                        .frame(maxWidth: .infinity,
                                 maxHeight: .infinity,
                                 alignment: .top)
                    
                    
                }
            }
                .edgesIgnoringSafeArea(.top)
                
            }
        }.navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
    func addaudience(){
        
    }
}

struct AddSurveyScreenView_Previews: PreviewProvider {
    static var previews: some View {
        AddSurveyScreenView()
    }
}
