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
    
    @State  var Title : [DropDownModel] = []
    @State  var Description : [DropDownModel] = []
    
    @State private var selectedTab = 0
    @StateObject private var alertService = AlertService()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var selectedOption: String = ""
    let options = ["Single Attempt", "Multiple Attempt"]
    var body: some View {
        
        NavigationView {
            
            ZStack {
                BaseView(alertService: alertService)
                
                
                
                
                ScrollView{
                    
                    HStack {
                        
                        Button(action: {
                            // Perform action for burger icon
                            self.presentationMode.wrappedValue.dismiss()
                            
                        }) {
                            Image(systemName: "chevron.left").tint(CColors.MainThemeColor).font(.system(size: 18))
                            Text("Back").tint(CColors.MainThemeColor).font(.system(size: 18))
                        }
                        
                        //  Spacer()
                        
                        Text("Add Survey")
                            .font(.headline)
                            .frame(width: 250)
                        
                        
                        Spacer()
                        
                        
                    }.foregroundColor(Color.black)
                        .frame(height: 40)
                        .padding()
                    Divider()
                    
                    HStack(spacing: 0) {
                        
                        TabBarButton(text: "Info", isSelected: selectedTab == 0)
                        {
                            selectedTab = 0
                            //  listPendingPayments()
                        }
                        
                        //Spacer()
                        
                        TabBarButton(text: "Questions", isSelected: selectedTab == 1) {
                            selectedTab = 1
                        }
                        
                        // Spacer()
                        
                        TabBarButton(text: "Polling Stations", isSelected: selectedTab == 2) {
                            selectedTab = 2
                            // listPaymentHistory()
                        }
                        
                        
                    }.frame(height: 4)
                        .foregroundColor(Color.black)
                        .padding(20)
                    
                    ZStack{
                        
                        VStack
                        {
                            
                            if selectedTab == 0
                            {
                                FormInput(label: "Title", placeholder: "Type Title", text: $ftitle, isCnic: false).padding(20)
                                Spacer()
                                MultiLineTextField(title: "Description").padding(20)
                                Spacer()
                                
                                Text("Survey Attempt").padding(20)
                                Spacer()
                                HStack {
                                    ForEach(options, id: \.self) { option in
                                        RadioButton(option: option, selectedOption: $selectedOption)
                                    }
                                }.padding(30)
                                Spacer()
                                CustomButton(text: "Next", image: "").padding(40)
                            }
                            else if selectedTab == 1
                            {
                                MultiLineTextField(title: "Question").padding(14)
                                DropDown(label: "Question Type", placeholder: "Select Question Type", selectedObj:  $cTitle, menuOptions: Title ).padding(14)
                                
                                CustomButton(text: "Save", image: "").padding(40)
                                
                                if (showingQuestionare == true)
                                {
                                    
                                }
                            }else
                            {
                                
                            }
                            
                            
                        } .frame(maxWidth: .infinity,
                                 maxHeight: .infinity,
                                 alignment: .top)
                    }
                    
                }
                
            }
        }.navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}

struct AddSurveyScreenView_Previews: PreviewProvider {
    static var previews: some View {
        AddSurveyScreenView()
    }
}
