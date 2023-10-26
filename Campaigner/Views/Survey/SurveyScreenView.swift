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
    @State private var isNavBarLinkActive = false
    @State private var isPresentNode:Bool=false
    @State private var searchText = ""
    @State private var selectedTab = 0
    
    @State private var showAddSurveyScreen = false
    @State private var isLoading = false
    var tabnames=["Own","Attempt","Attempted"]
    @State var survey = [SurveyData]()
    @State var surveyQuestion = [SurveyQuestion]()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationView {
            
            ZStack{
                Color(red: 0.95, green: 0.95, blue: 0.95)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    
                    Image("Emptybox")
                    Text("Press the + button to create your own survey")
                }
                VStack(spacing: 0) {
                
                    CustomNavBar(title: "Surveys",
                                 destinationView: HomeScreenView(presentSideMenu: $isPresentNode),
                                 isActive: $isNavBarLinkActive,
                                 trailingView: AnyView(
                                    Button(action: {
                                        // Perform action for searchbar icon
                                        showSearchBar.toggle()
                                    }) {
                                        Image(systemName: "magnifyingglass")
                                            .imageScale(.large)
                                            .padding(.trailing,10)
                                    }
                                 )
                    )
                    .edgesIgnoringSafeArea(.top)
                    
                    HStack(spacing: 0) {
                        TabBarButton(text: "Own", isSelected: selectedTab == 0){
                            selectedTab = 0
                        }

                        TabBarButton(text: "Attempt", isSelected: selectedTab == 1) {
                            selectedTab = 1
                        }

                        TabBarButton(text: "Polling Stations", isSelected: selectedTab == 2) {
                            selectedTab = 2
                        }

                    }
                    .foregroundColor(Color.black)
                    .background(.white)
                        Spacer()
              
                    VStack{
                        
                        if showSearchBar {
                            SearchBar(text: $searchText).onChange(of: searchText, perform: handleTextChange)
                        }
                        if selectedTab==0{
                        ZStack{
                            List{
                                //SurveysCell(Team: "Support Team", TeamMessage: "Description Goes here ", tehsilTown: "Rawalpindi", polingStation: "Rawalpindi")
                                
                                if showSearchBar == false
                                {
                                    ForEach(survey.indices, id: \.self) { index in
                                        SurveysCell(Team: survey[index].survey_title ?? "", TeamMessage: survey[index].survey_description ?? "", tehsilTown: survey[index].tehsil ?? "", polingStation: survey[index].tehsil ?? "", action: {
                                            
                                        })
                                    }
                                }else {
                                    ForEach(survey.indices, id: \.self) { index in
                                        if searchText.isEmpty || survey[index].survey_title?.contains(searchText) ?? false {
                                            SurveysCell(Team: survey[index].survey_title ?? "", TeamMessage: survey[index].survey_description ?? "", tehsilTown: survey[index].tehsil ?? "", polingStation: survey[index].tehsil ?? "", action: {
                                                
                                            })
                                        }
                                    }
                                    
                                }
                            }
                            
                          
                            
                        }
                           
                    }
                         else if selectedTab==1{
                            
                            
                        }
                        else if selectedTab==2{
                            
                            
                        }
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                AddButton(action: addSurverys, label: "Add")
                                    .padding()
                            }
                        }
                    }
                    
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity,
                           alignment: .topLeading)
                    .padding()
                    
                    NavigationLink(destination: AnyView(AddSurveyScreenView()), isActive: $showAddSurveyScreen) {
                        
                    }
                    
                }
                .edgesIgnoringSafeArea(.top)
            }
            
        }.navigationBarHidden(true)
            .onAppear{
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
            
            VStack(alignment: .leading, spacing: 10){
                HStack {
                    Text(Team)
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        // Perform action for Icon Button 2
                        // Edit Record
                        action()
                        
                    }) {
                        Image("box-right")
                            .imageScale(.small)
                            .foregroundColor(.black)
                    }
                }
                Text(TeamMessage)
                    .font(.footnote).frame(maxWidth: .infinity,
                                           maxHeight: .infinity,
                                           alignment: .topLeading)
                //                HStack{
                //                    Text("Tehsil/Town: \(tehsilTown)")
                //                        .font(.system(size: 11))
                //                    Spacer()
                //                    Text("Polling Station: \(polingStation)")
                //                        .font(.system(size: 11))
                //
                //                }
                
                
                  
                       
                    
                    
       
                
            }
            .background(Color("BackgroundColorTheme"))
                .border(Color.black, width: 1)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowInsets(EdgeInsets())
                .frame(minHeight: 80)
            
            
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
