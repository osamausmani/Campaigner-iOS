//
//  TeamsScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 02/06/2023.
//

import SwiftUI
import Alamofire
import SwiftAlertView

struct TeamsScreenView: View {
    
    @State private var selectedTab = 1
    @State var membersArray = [ElectionMembers]()
    @State var teamsArray = [TeamsData]()
    
    @State var addNewMemberViewIsActive = false
    @State var addNewTeamIsActive = false
    
    var body: some View {
        
        VStack{
            
            NavigationLink(destination: AddMemberView(), isActive: $addNewMemberViewIsActive) {
            }
            NavigationLink(destination: AddTeamView(), isActive: $addNewTeamIsActive) {
            }
            CustomNavBarBack(title: "Teams")
            
            HStack() {
                TabBarButton(text: "Members", isSelected: selectedTab == 1)
                {
                    selectedTab = 1
                    LoadData()
                }
                TabBarButton(text: "Teams", isSelected: selectedTab == 2) {
                    selectedTab = 2
                    LoadData()
                }
            }.padding(.top,10)
            
            VStack{
                if selectedTab == 1 &&  membersArray.count == 0 {
                    ZStack{
                        VStack{
                            Spacer()
                            NoRecordView(recordMsg: "To ensure a sucessfull election campaign, we encourage you to add your team members to assist with outreach efforts and engage with voters.")
                            Spacer()
                        }
                    }.frame(maxWidth: .infinity, maxHeight:.infinity)
                }
                
                else if selectedTab == 2 && teamsArray.count == 0 {
                    ZStack{
                        VStack{
                            Spacer()
                            NoRecordView(recordMsg: "To ensure a sucessfull election campaign, we encourage you to add your teams to assist with outreach efforts and engage with voters.")
                            Spacer()
                        }
                    }.frame(maxWidth: .infinity, maxHeight:.infinity)
                }
                
                else{
                    ScrollView{
                        
                        if selectedTab == 1 {
                            ForEach(membersArray.indices, id: \.self) { index in
                                MembersCustomCardView(item: $membersArray[index])
                            }
                        }
                        
                        if selectedTab == 2 {
                            ForEach(teamsArray.indices, id: \.self) { index in
                                TeamsCustomCardView(item: $teamsArray[index])
                            }
                        }
                        
                        
                    }
                }
                if selectedTab == 1 {
                    AddButton(action: {addNewMemberViewIsActive.toggle()}, label:  "Add")
                }
                if selectedTab == 2 {
                    AddButton(action: {addNewTeamIsActive.toggle()}, label:  "Add")
                }
            }.background(
                selectedTab == 1 ? membersArray.count == 0 ? CColors.TextInputBgColor : .clear : teamsArray.count == 0 ? CColors.TextInputBgColor : .clear
            )
            
            
        }.navigationBarHidden(true).edgesIgnoringSafeArea(.top).onAppear{
            LoadData()
        }
        
    }
    
    func LoadData(){
        if selectedTab == 1 {
            ListMembers()
        }
        if selectedTab == 2 {
            ListTeams()
        }

        
        //        teamsArray.append(TeamsData(group_sdt: "", members: [], members_count: 0, poll_station_id: "", poll_station_name: "", sdt: "", team_desc: "team_desc", team_id: "", team_name: "team_name"))
        //
    }
    
    
    func ListMembers(){
        let parameters: [String:Any] = [
            "plattype": Constants.PLAT_TYPE,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "election_id": UserDefaults.standard.string(forKey: Constants.USER_ELECTION_ID)!,
        ]
        
        let RequestModel =  ContestentViewModel()
        RequestModel.ListElectionsMembers(parameters: parameters ) { result in
            switch result {
            case .success(let response):
                if response.rescode == 1 {
                    membersArray.removeAll()
                    membersArray = response.data ?? []
                }else{
                    SwiftAlertView.show(title: "Alert", message: response.message, buttonTitles: "OK")                }
            case .failure(let error):
            print(error)
                /*                SwiftAlertView.show(title: "Alert", message: error.localizedDescription, buttonTitles: "OK")            */
            }
        }
    }
    
    func ListTeams(){
        let parameters: [String:Any] = [
            "plattype": Constants.PLAT_TYPE,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "election_id": UserDefaults.standard.string(forKey: Constants.USER_ELECTION_ID)!,
        ]
        let RequestModel =  TeamsViewModel()
        RequestModel.ListTeams(parameters: parameters ) { result in
            switch result {
            case .success(let response):
                if response.rescode == 1 {
                    teamsArray.removeAll()
                    teamsArray = response.data ?? []
                }else{
                    SwiftAlertView.show(title: "Alert", message: response.message, buttonTitles: "OK")                }
            case .failure(let error):
                SwiftAlertView.show(title: "Alert", message: error.localizedDescription, buttonTitles: "OK")            }
        }
    }
}


struct MembersCustomCardView: View {
    @Binding public var item : ElectionMembers
    var body: some View {
        VStack{
            VStack {
                HStack {
                    Text("Name")
                        .font(.headline)
                        .foregroundColor(Color.black)
                        .frame(width: 130, alignment: .leading)
                    Text(item.user_full_name!)
                        .font(.body)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(1)
                HStack {
                    Text("CNIC")
                        .font(.headline)
                        .foregroundColor(Color.black)
                        .frame(width: 130, alignment: .leading)
                    Text(item.user_cnic!)
                        .font(.body)
                        .foregroundColor(Color.black)
                    Spacer()
                }.padding(1)
                HStack {
                    Text("Mobile Number")
                        .font(.headline)
                        .foregroundColor(Color.black)
                        .frame(width: 130, alignment: .leading)
                    Text(item.msisdn!)
                        .font(.body)
                        .foregroundColor(Color.black)
                    Spacer()
                }.padding(1)
            }
            .padding(8)
            .background(CColors.CardBGColor)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 5)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        }.padding(.bottom,0).padding(.leading,8).padding(.trailing,8)
    }
}


struct TeamsCustomCardView: View {
    @Binding public var item : TeamsData
    @State public var teamDetailsViewIsActive = false
    var body: some View {
        VStack{
            NavigationLink(destination: TeamDetailsScreenView(selectedTeamName: item.team_name!, selectedTeamID: item.team_id!), isActive: $teamDetailsViewIsActive) {
            }
            
            VStack {
                HStack {
                    Text(item.team_name!)
                        .font(.headline)
                        .foregroundColor(Color.black)
                        .frame( alignment: .leading)
                    
                    Spacer()
                    HStack{
                        VStack{
                            HStack{
                                Button(action: {
                                    teamDetailsViewIsActive.toggle()
                                }) {
                                    Image("group")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 28, height: 28)
                                        .foregroundColor(CColors.MainThemeColor)
                                }
                                Button(action: {
                                    print("")
                                }) {
                                    Image("edit_black")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(CColors.MainThemeColor)
                                }
                                Button(action: {
                                    print("")
                                }) {
                                    Image("delete_black")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(CColors.MainThemeColor)
                                }
                            }
                            Spacer()
                        }
                    }
                    
                }.padding(1)
                
                HStack {
                    Text(item.team_desc!)
                        .font(.body)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(1)
                
            }
            .padding(8)
            .background(CColors.CardBGColor)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 5)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        }.padding(.bottom,0).padding(.leading,8).padding(.trailing,8)
    }
}

struct TeamsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsScreenView()
    }
}
