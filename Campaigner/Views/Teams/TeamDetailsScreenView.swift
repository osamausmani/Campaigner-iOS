//
//  TeamDetailsScreenView.swift
//  Halka
//
//  Created by Osama Usmani on 01/12/2023.
//


import SwiftUI
import SwiftAlertView

struct TeamDetailsScreenView: View {
    
    @State private var fvName = ""
    @State private var fvMobileNo = ""
    @State public var selectedTeamName = ""
    @State public var selectedTeamID = ""
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var contactsScreenViewActive = false
    @State private var isOn = true
    @State private var searchText = ""
    @State private var isSearching = false
    @State var membersArray = [Member]()
    
    var body: some View {
        VStack{
            CustomNavBarBack(title: "Team Details")
            VStack {
                VStack{
                    HStack{
                        Text("Is Team Lead")
                        HStack {
                            Image(systemName: "checkmark.square")
                        }
                        Text("Added")
                        Toggle("", isOn: $isOn).scaleEffect(0.7).frame(width: 30, height: 20).disabled(true)
                        Spacer()
                    }
                    Divider().background(.black)
                    HStack{
                        Text(selectedTeamName).font(.headline)
                        Spacer()
                    }
                    HStack{
                        CustomSearchBar(placeholder: "Search By Name / CNIC ", text: $searchText)
                    }
                    HStack{
                        ScrollView{
                            ForEach(membersArray.indices, id: \.self) { index in
                                MembersCardView(item: $membersArray[index], isOn: membersArray[index].is_member == 1 ? true : false, parent: self)
                            }
                        }
                    }
                }.padding(8).background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                )
                Spacer()
            }.padding(8)
        }.navigationBarHidden(true).background(CColors.CardBGColor).frame(maxHeight: .infinity).edgesIgnoringSafeArea(.top).onAppear{
            LoadDetails()
            //            membersArray.append(Member(user_id: "userID", mem_id: "memid", user_full_name: "Osama Usmani", user_cnic: "032234234234", msisdn: "123123123", is_lead: 0, is_member: 0))
        }
        
    }
    
    
    
    
    struct MembersCardView: View {
        @Binding public var item : Member
        @State public var isOn:Bool
        let parent: TeamDetailsScreenView // Reference to the parent instance
        
        var body: some View {
            VStack{
                VStack {
                    HStack{
                        VStack{
                            HStack {
                                Text(item.user_full_name!)
                                    .font(.headline)
                                    .foregroundColor(Color.black)
                                Spacer()
                            }.padding(1)
                            HStack {
                                Text(item.user_cnic!)
                                    .font(.body)
                                    .foregroundColor(Color.black)
                                Spacer()
                            }.padding(0)
                            Spacer()
                        }
                        HStack{
                            HStack {
                                Image( systemName: item.is_lead == 1 ? "checkmark.square" : "square" )
                            }.onTapGesture {
                                parent.AddTeamLead(item: item)
                            }
                            Toggle("", isOn: $isOn).scaleEffect(0.7).frame(width: 30, height: 20).onTapGesture {
                                item.is_member  == 1 ? parent.RemoveMember(item: item)
                                :
                                parent.AddMember(item:item)
                                
                            }
                        }
                        
                    }
                }
                .padding(8)
                .background(CColors.CardBGColor)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 5)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            }.padding(.bottom,0).padding(.leading,0).padding(.trailing,0)
        }
    }
    
    func LoadDetails(){
        let parameters: [String:Any] = [
            "plattype": Constants.PLAT_TYPE,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "team_id": selectedTeamID,
            "election_id": UserDefaults.standard.string(forKey: Constants.USER_ELECTION_ID)!
        ]
        let RequestModel =  TeamsViewModel()
        RequestModel.ListTeams(parameters: parameters ) { result in
            switch result {
            case .success(let response):
                if response.rescode == 1 {
                    membersArray.removeAll()
                    membersArray = response.data?[0].members ?? []
                }else{
                    SwiftAlertView.show(title: "Alert", message: response.message, buttonTitles: "OK")
                    
                }
            case .failure(let error):
                SwiftAlertView.show(title: "Alert", message: error.localizedDescription, buttonTitles: "OK")
                
            }
        }
    }
    
    func AddTeamLead(item : Member){
        
        let parameters: [String:Any] = [
            "plattype": Constants.PLAT_TYPE,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "team_id": selectedTeamID,
            "mem_id": item.mem_id!,
            "is_lead": item.is_lead == 1 ? "0" : "1",
            "election_id": UserDefaults.standard.string(forKey: Constants.USER_ELECTION_ID)!
        ]
        let RequestModel =  TeamsViewModel()
        RequestModel.UpdateTeamLead(parameters: parameters ) { result in
            switch result {
            case .success(let response):
                if response.rescode == 1 {
                    SwiftAlertView.show(title: "Alert", message: response.message, buttonTitles: "OK")
                    LoadDetails()
                }
                LoadDetails()
                
            case .failure(let error):
                SwiftAlertView.show(title: "Alert", message: error.localizedDescription, buttonTitles: "OK")
                
            }
        }
        
    }
    
    func AddMember(item:Member){
        let parameters: [String:Any] = [
            "plattype": Constants.PLAT_TYPE,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "team_id": selectedTeamID,
            "mem_id": item.mem_id!,
            "is_lead": "0",
            "election_id": UserDefaults.standard.string(forKey: Constants.USER_ELECTION_ID)!
        ]
        let RequestModel =  TeamsViewModel()
        RequestModel.AddTeamMember(parameters: parameters ) { result in
            switch result {
            case .success(let response):
                if response.rescode == 1 {
                    SwiftAlertView.show(title: "Alert", message: response.message, buttonTitles: "OK")
                    LoadDetails()
                    
                }
            case .failure(let error):
                SwiftAlertView.show(title: "Alert", message: error.localizedDescription, buttonTitles: "OK")
                
            }
        }
    }
    
    func RemoveMember(item:Member){
        let parameters: [String:Any] = [
            "plattype": Constants.PLAT_TYPE,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "team_id": selectedTeamID,
            "mem_id": item.mem_id!,
            "election_id": UserDefaults.standard.string(forKey: Constants.USER_ELECTION_ID)!
        ]
        let RequestModel =  TeamsViewModel()
        RequestModel.RemoveTeamMember(parameters: parameters ) { result in
            switch result {
            case .success(let response):
                if response.rescode == 1 {
                    SwiftAlertView.show(title: "Alert", message: response.message, buttonTitles: "OK")
                    LoadDetails()
                    
                }
            case .failure(let error):
                SwiftAlertView.show(title: "Alert", message: error.localizedDescription, buttonTitles: "OK")
                
            }
        }
    }
    
}

struct TeamDetailsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDetailsScreenView()
    }
}

struct CustomSearchBar: View {
    @State var placeholder: String
    @Binding var text: String
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        if isEditing {
                            Button(action: {
                                text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .onTapGesture {
                    isEditing = true
                }
            if isEditing {
                Button(action: {
                    isEditing = false
                    text = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                }
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }.padding(0)
            .onAppear{
                text = ""
            }
        
    }
}
