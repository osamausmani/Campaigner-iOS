//
//  SurveyScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 04/06/2023.
//

import SwiftUI
import Alamofire

struct SurveyScreenView: View {
    
    @StateObject private var alertService = AlertService()
    @State private var showSearchBar = false
    
    
    @State private var searchText = ""
    
    @State private var showAddSurveyScreen = false
    @State private var isLoading = false
    
    @State var survey = [SurveyData]()
    @State var surveyQuestion = [SurveyQuestion]()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationView {
            
            ZStack{
                Image("splash_background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    
                    HStack {
                        Button(action: {
                            // Perform action for burger icon
                            print("actionAddSurvey")
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            // Image(systemName: "line.horizontal.3")
//                            Image(systemName: "arrowshape.left")
//                                .imageScale(.large)
                            Image(systemName: "chevron.left").tint(CColors.MainThemeColor).font(.system(size: 18))
                            Text("Back").tint(CColors.MainThemeColor).font(.system(size: 18))
                                
                        }
                        
                       // Spacer()
                        
                        Text("Surveys")
                            .font(.headline)
                            .frame(width: 250)
                        
                        Spacer()
                        
                        Button(action: {
                            // Perform action for searchbar icon
                            showSearchBar.toggle()
                        }) {
                            Image(systemName: "magnifyingglass")
                                .imageScale(.large)
                        }
   
                    }
                    .foregroundColor(.black)
                    .padding()
                    
                    
                    VStack{
                        
                        if showSearchBar {
                            SearchBar(text: $searchText).onChange(of: searchText, perform: handleTextChange)
                        }
                        
                        CounterTabView(heading: "Total Surveys: \(survey.count)")
                        Spacer()
                        
                        ZStack{
                            List{
//                                SurveysCell(Team: "Support Team", TeamMessage: "Description Goes here ", tehsilTown: "Rawalpindi", polingStation: "Rawalpindi")
                                
                                if showSearchBar == false
                                {
                                    ForEach(survey.indices, id: \.self) { index in
                                        SurveysCell(Team: survey[index].survey_title ?? "", TeamMessage: survey[index].survey_description ?? "", tehsilTown: survey[index].tehsil ?? "", polingStation: survey[index].tehsil ?? "", action: {
                                            
                                        })
                                    }
                                }else
                                {
                                    ForEach(survey.indices, id: \.self) { index in
                                        if searchText.isEmpty || survey[index].survey_title?.contains(searchText) ?? false {
                                            SurveysCell(Team: survey[index].survey_title ?? "", TeamMessage: survey[index].survey_description ?? "", tehsilTown: survey[index].tehsil ?? "", polingStation: survey[index].tehsil ?? "", action: {
                                                
                                            })
                                        }
                                    }
                                    
                                }
                            }
                            AddButton(action: addSurverys, label: "")
                        }
                    }
                    
                    .frame(maxWidth: .infinity,
                             maxHeight: .infinity,
                             alignment: .topLeading)
                    .padding()
                    
                    NavigationLink(destination: AnyView(AddSurveyScreenView()), isActive: $showAddSurveyScreen) {

                    }
                    
                }
            }
        }.onAppear{
           listSurvey()
        }
        
    }
    
  
    func listSurvey(){
        
        isLoading = true
        
        let token = UserDefaults.standard.string(forKey: Constants.USER_SESSION_TOKEN)
        let headers:HTTPHeaders = [
             "Content-Type":"application/x-www-form-urlencoded",
            "x-access-token": token!
        ]
       
       isLoading = true
        // isShowingLoader.toggle()
        
        var userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!,
            //  "assembly": selectedOption + 1
            // "na_id": cDistrict
        ]
        
        let surveyViewModel = SurveyViewModel()
        
        var newDropDownData : [DropDownModel] = []
        

       
        surveyViewModel.ListSurvey(parameters: parameters,headers: headers ) { result in
            isLoading = false
            print(result)
           // searchDistrict()
            switch result {
                
            case .success(var Response):
                
                print(Response)
                
                if Response.rescode == 1
                {
                    survey = Response.data!

                    
//                    for i in province {
//                        let dropDownModel = DropDownModel(id: i.province_id!, value: i.province!)
//                        newDropDownData.append(dropDownModel)
//                    }
//                    //  provinceName = []
//                    //   provinceName.append(contentsOf: newDropDownData)
//                    
//                    assemblyName = newDropDownData
                }else{
                    alertService.show(title: "Alert", message: Response.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
                
              //  isShowingLoader.toggle()
            }
        }
    }
    
    
    
    
    func addSurverys()
    {
        showAddSurveyScreen = true
    }
    
    struct SurveysCell: View {
        
        
        var Team : String
        var TeamMessage: String
        
        var tehsilTown : String
        
        var polingStation : String
        
        var action: () -> Void
        
        var body: some View {
            
            VStack{
                HStack {
                    Text(Team)
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        // Perform action for Icon Button 2
                        // Edit Record
                        action()
                        
                    }) {
                        Image(systemName: "arrowshape.forward")
                            .imageScale(.small)
                            .foregroundColor(.black)
                    }
                }
                Spacer()
//                HStack{
//                    Text("Tehsil/Town: \(tehsilTown)")
//                        .font(.system(size: 11))
//                    Spacer()
//                    Text("Polling Station: \(polingStation)")
//                        .font(.system(size: 11))
//
//                }
                
                HStack{
                    Text(TeamMessage)
                        .font(.footnote).frame(maxWidth: .infinity,
                                                  maxHeight: .infinity,
                                                  alignment: .topLeading)
                    
                    
                }
                
                
            }
         
            
            
        }
        
    }
    
    
    func handleTextChange(_ newText: String) {
        // Perform any actions based on the new text
        print("New text: \(newText)")
    }
}


struct SurveyScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyScreenView()
    }
}
