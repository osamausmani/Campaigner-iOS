//
//  SurveyHomeScreenView.swift
//  Campaigner
//
//  Created by Osama Usmani on 29/10/2023.
//

import Foundation
import SwiftUI

struct SurveyHomeScreenView: View {
    
    @StateObject private var alertService = AlertService()
    @State private var addNewComplaintScreenViewActive = false
    @State private var isEditNavigationActive = false
    @State private var isCommentsScreenViewActive = false
    @State var surveyListArray = [SurveyListData]()
    @State var selectedItem : SurveyListData?
    @State private var selectedTab = 1
    @State private var surveyAttemptScreenView = false
    @State private var surveyID: String? = ""

 
    var body: some View {
        
        ZStack {
            BaseView(alertService: alertService)
            NavigationLink(destination: SurveyAttemptScreenView(surveyID: surveyID), isActive: $surveyAttemptScreenView) {
                        }
            //
            //            NavigationLink(destination: ComplaintCommentScreenView(selectedItemID: selectedItem?.complaint_id), isActive: $isCommentsScreenViewActive) {
            //            }
            //            NavigationLink("", destination: AddNewComplaintView(isEdit:true, item: selectedItem).edgesIgnoringSafeArea(.bottom) , isActive: $isEditNavigationActive)
            //                .isDetailLink(false)
            
            ZStack{
                VStack {
                    HStack(spacing: 0) {
                        TabBarButton(text: "Available", isSelected: selectedTab == 1)
                        {
                            selectedTab = 1
                            GetSurveysData()
                        }
                        TabBarButton(text: "Attempted", isSelected: selectedTab == 2) {
                            selectedTab = 2
                            GetSurveysData()
                        }
                    }
                    Spacer()
                    VStack{
                        if surveyListArray.count == 0 {
                            ZStack{
                                VStack{
                                    Spacer()
                                    NoRecordView(recordMsg: "No Record Found")
                                    Spacer()
                                    
                                }
                            }.frame(maxWidth: .infinity, maxHeight:.infinity)
                        }
                        else{
                            ScrollView{
                                ForEach(surveyListArray.indices, id: \.self) { index in
                                    SurveyCustomCardView(selectedTab: $selectedTab, item: $surveyListArray[index]).onTapGesture {
                                        surveyID = surveyListArray[index].survey_id_text
                                        surveyAttemptScreenView.toggle()
                                    }
                                }
                            }
                        }
                        if selectedTab == 100 {
                            AddButton(action: {addNewComplaintScreenViewActive.toggle()}, label:  "Add")
                        }
                    }.background(surveyListArray.count == 0 ? CColors.TextInputBgColor : .clear)
                }
            }
        }.onAppear{
            GetSurveysData()
        }
        
        .navigationBarHidden(false)
        .navigationTitle("Surveys")
    }
    
    
    func GetSurveysData(){
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
        ]
        let ViewModel = SurveyViewModel()
        ViewModel.ListSurveyByUser(parameters: parameters ) { result in
            switch result {
            case .success(let response ):
                if response.rescode == 1 {
                    
                    var sArr = [SurveyListData]()
                    sArr = response.data ?? []
    
                    if selectedTab == 1 {
                        let filteredSurveys = sArr.filter { $0.survey_submitted == "0" }
                        surveyListArray.removeAll()
                        surveyListArray = filteredSurveys
                    }
                    
                    if selectedTab == 2 {
                        let filteredSurveys = sArr.filter { $0.survey_submitted == "1" }
                        surveyListArray.removeAll()
                        surveyListArray = filteredSurveys
                    }
                }else{
                    surveyListArray.removeAll()
                }
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
 
    
}



struct SurveyCustomCardView: View {
    
    @Binding var selectedTab: Int
    @Binding public var item : SurveyListData
    
    var body: some View {
        
        VStack{
            
            VStack {
                HStack {
                    Text(item.survey_title ?? "Title")
                        .font(.headline)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                    if selectedTab == 1 {
                        Image(systemName:"chevron.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                    }
                    if selectedTab == 2 {
                        Image("s_completed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                    
                    
                }.padding(1)
                HStack{
                    Text(item.survey_description ?? "Description")
                        .font(.body)
                    .foregroundColor(Color.black)
                    Spacer()
                }
                if item.survey_multi_attempt! > 0 {
                    HStack{
                        Text("Number of attempted tries : " + String(item.attempt_count!))
                            .font(.body)
                            .foregroundColor(Color.black)
                        Spacer()
                        
                    }}
            }
            .padding(8)
            .background(CColors.CardBGColor)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 5)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            
            
            
        }.padding(.bottom,0).padding(.leading,8).padding(.trailing,8)
        
        
        
        
        
    }
    
    
    
}


struct SurveyHomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyHomeScreenView()
    }
}
