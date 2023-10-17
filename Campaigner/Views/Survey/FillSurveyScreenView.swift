//
//  fillSurveyScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 04/07/2023.
//

import SwiftUI
import Alamofire

struct FillSurveyScreenView: View {
  
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var isLoading = false
    
   
    @State private var emptyView = false
    
   
    var title : String
    
    var questionList = [SurveyQuestion]()
    
    @State var fin = [ContestingElection]()
    
    @StateObject private var alertService = AlertService()
    
    
    var body: some View {
        NavigationView {
            
            ZStack{
                
//                Image("splash_background")
//                    .resizable()
//                    .edgesIgnoringSafeArea(.all)
            
            VStack {

                // Navigation bar
                HStack {
                    Button(action: {
                        // Perform action for burger icon
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                      //  Image(systemName: "arrowshape.left")
                       //     .imageScale(.large)
                        Image(systemName: "chevron.left").tint(CColors.MainThemeColor).font(.system(size: 18))
                        Text("Back").tint(CColors.MainThemeColor).font(.system(size: 18))
                        
                    }
                   // Spacer()
                    Text(title)
                        .font(.headline)
                        .frame(width: 250)
                    
                    Spacer()
                    
                }.foregroundColor(CColors.MainThemeColor)
                    .padding()
                    .navigationBarHidden(true)
                
                Divider()
 
                ZStack{
                    
                    if(emptyView == true)
                    {
                        HStack
                        {
                            Text("Press + icon to fill the survey")
                        }
                    }else
                    {
                        //List
//                        VStack(alignment: .leading, spacing: 16) {
//                                  Text("Question Title")
//                                      .font(.headline)
//                                  
//                                  VStack(alignment: .leading, spacing: 8) {
//                                      CheckboxOptionView(text: "Yes", isSelected: selectedOption == true) {
//                                          selectedOption = true
//                                      }
//                                      CheckboxOptionView(text: "No", isSelected: selectedOption == false) {
//                                          selectedOption = false
//                                      }
//                                  }
//                              }
//                              .padding()
                        
                        
                    }
        
                    // Addition sign
                    AddButton(action: add, label: "")
                    // .padding(.top)
                    
                }
                
            }
            .navigationBarHidden(true)
     
            .overlay(
                Group {
                    if isLoading {
                        ProgressHUDView()
                    }
                }
            )
        }
        }.foregroundColor(CColors.MainThemeColor)
    }
    

    
    func add()
    {
      
        
    }
   
}

struct FillSurveyScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FillSurveyScreenView( title: "----",questionList: [])
    }
}
