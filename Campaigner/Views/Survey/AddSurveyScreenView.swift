//
//  AddSurveyScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 06/06/2023.
//

import SwiftUI

struct AddSurveyScreenView: View {
    @State private var cTitle = DropDownModel()
    @State private var cDescription = DropDownModel()
    
    @State  var Title : [DropDownModel] = []
    @State  var Description : [DropDownModel] = []
    
    @StateObject private var alertService = AlertService()
    @State private var selectedOption: String = ""
        let options = ["Single Attempt", "Multiple Attempt"]
    var body: some View {
        
        NavigationView {
            
            ZStack {
                BaseView(alertService: alertService)
                
                ZStack{
                    Image("splash_background")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    
                    ScrollView{
                        
                        VStack
                        {
                            
                            
                            HStack {
                                
                                Button(action: {
                                    // Perform action for burger icon
                                    // self.presentationMode.wrappedValue.dismiss()
                                    
                                }) {
                                    Image(systemName: "arrowshape.left")
                                        .imageScale(.large)
                                }
                                
                                Spacer()
                                
                                Text("Add Survey")
                                    .font(.headline)
                                
                                Spacer()
                                
                                
                            }.foregroundColor(Color.black)
                            
                                .padding()
                            
                            DropDown(label: "Title", placeholder: "Type Title", selectedObj:  $cTitle, menuOptions: Title ).padding(14)
                            DropDown(label: "Description", placeholder: "Description", selectedObj:  $cDescription, menuOptions: Description ).padding(14)
                            MultiLineTextField(title: "Question").padding(14)
                            DropDown(label: "Question Type", placeholder: "Multiple Choice", selectedObj:  $cDescription, menuOptions: Description ).padding(14)
                            
                            Spacer()
                            HStack {
                                ForEach(options, id: \.self) { option in
                                    RadioButton(option: option, selectedOption: $selectedOption)
                                }
                            }
                            
                            CustomButton(text: "Save" , image: "") .padding(5)
                            
                            DropDown(label: "Polling Station", placeholder: "Select Polling Station", selectedObj:  $cDescription, menuOptions: Description ).padding(14)
                                .frame(maxWidth: .infinity,
                                       maxHeight: .infinity,
                                       alignment: .top)
                            
                            CustomButton(text: "Save" , image: "") .padding(5)
                            
                        }
                        
                    }
                }
            }
        }
    }
}

struct AddSurveyScreenView_Previews: PreviewProvider {
    static var previews: some View {
        AddSurveyScreenView()
    }
}
