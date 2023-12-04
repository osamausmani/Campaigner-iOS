//
//  TeamsScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 02/06/2023.
//

import SwiftUI
import Alamofire

struct TeamsScreenView: View {
    var value: String
    
    
    @State private var selectedTab = 0
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var isLoading = false
    
    @State private var isUpdate = false
    
    @State private var addMemberView = false
    
    @State private var addTeamView = false
    
    @State private var emptyViewMember = false
    
    @State private var emptyViewTeams = false
    
    @State private var emptyView = false
    
    @State private var selectedTeamId = ""
    
    @State private var selectedIndex = 0
    
    @State private var showAlert = false

  
    
    @State var fin = [TeamsData]()
    
    
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
                        Text("Teams")
                            .font(.headline)
                            .frame(width: 250)
                        
                        Spacer()
                        
                    }.foregroundColor(CColors.MainThemeColor)
                        .padding()
                        .navigationBarHidden(true)
                    
                    Divider()
                    
                    HStack(spacing: 0)
                    {
                        Spacer()
                        
                        TabBarButton(text: "Members", isSelected: selectedTab == 0) {
                            selectedTab = 0
                               listMembers()
                        }
                        
                        Spacer()
                        
                        TabBarButton(text: "Teams", isSelected: selectedTab == 1)
                        {
                            selectedTab = 1
                            listTeams()
                        }
                        
                        Spacer()
                    }.frame(height: 40)
                        .foregroundColor(Color.black)
                    
                    
                    ZStack{
                        
                        
                        
                        if(emptyView == true)
                        {
                            Image("MembersNil")
                                .resizable()
                                .edgesIgnoringSafeArea(.all)
                                .padding(20)
                        }else
                        {
                            
                            VStack {
                                if selectedTab == 0 {
                                    // Table view
                                    List {
                                        //                                    ForEach(0..<5) { index in
                                        //                                        MembersCell(name: "name", cnic: "cnic", mobileNumber: "mobileNumber")//.padding()
                                        //                                    }.border(Color.gray, width: 1)
                                        
                                        ForEach(fin.indices, id: \.self)
                                        { index in
                                            
                                            
                                        }
                                    }
                                    
                                    
                                }else {
                                    
                                    
                                    List {
                                        
//                                        ForEach(0..<5) { index in
//                                            TeamsCell(Team: "Support Team", TeamMessage: "This is testing...."){
//                                                add()
//                                            } updateAction: {
//                                                update()
//                                            } deleteAction: {
//                                                delete()
//                                            }
//                                        }.border(Color.gray, width: 1)
                                        
                                        
                                        
                                        ForEach(fin.indices, id: \.self) { index in
                                            TeamsCell(Team: fin[index].team_name ?? "", TeamMessage: fin[index].team_desc ?? "")
                                            {
                                                
                                                add()
                                                selectedTeamId = fin[index].team_id ?? ""
                                                selectedIndex = index
                                            } updateAction: {
                                                selectedTeamId = fin[index].team_id ?? ""
                                                update()
                                                selectedIndex = index
                                            } deleteAction: {
                                                selectedTeamId = fin[index].team_id ?? ""
                                               delete()
                                                selectedIndex = index
                                               
                                            }

                                        }.onTapGesture {
                                            
                                        }
                                    }
                                }
                                
                                // Other views...
                            }.border(Color.gray, width: 1)
                            
                        }
                        
                        
                        
                        // Addition sign
                        AddButton(action: addButton, label: "")
                        // .padding(.top)
                        
                    }
                    
                }
                .navigationBarHidden(true)
                .fullScreenCover(isPresented: $addMemberView) {
                    AddMemberView()
                }
                .fullScreenCover(isPresented: $addTeamView) {
                   // AddTeamView()
                    if(isUpdate == true)
                    {
                        AddTeamView(isUpdate: true,title: .constant(fin[selectedIndex].team_name ?? ""), description: .constant(fin[selectedIndex].team_desc ?? ""), message: .constant(fin[selectedIndex].poll_station_name ?? ""), selected_team_id: .constant(fin[selectedIndex].team_id ?? "")).onDisappear{
                            DispatchQueue.main.asyncAfter(deadline: .now() )
                            {
                                listTeams()
                            }
                        }
                    }else
                    {
                        AddTeamView(isUpdate: false,title: .constant(""), description: .constant(""), message: .constant(""), selected_team_id: .constant("")).onDisappear{
                            DispatchQueue.main.asyncAfter(deadline: .now() )
                            {
                                listTeams()
                            }
                        }
                    }
                }
                .overlay(
                    Group {
                        if isLoading {
                            ProgressHUDView()
                        }
                    }
                )
            }
        }//.foregroundColor(CColors.MainThemeColor)
            .onAppear
            {
                //   listTeams()
            }
            .navigationBarHidden(true)
    }
    
    func add()
    {
        print("add")
    }
    
    func update()
    {
      
           
        
        isUpdate = true
        
        addTeamView = true
        
  

    }
    
    func delete()
    {
        print("delete")
        // isShowingLoader.toggle()
        isLoading = true
        
        let token = UserDefaults.standard.string(forKey: Constants.USER_SESSION_TOKEN)
        let headers:HTTPHeaders = [
            //   "Content-Type":"application/x-www-form-urlencoded",
            "x-access-token": token!
        ]
        
        let userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        
        
        
        print(token!)
        
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!,
            "team_id": selectedTeamId
            
            
        ]
        
        //let registerViewModel = RegisterViewModel()
        
        
        let teamsViewModel = TeamsViewModel()
        
        teamsViewModel.DeleteTeam(parameters: parameters,headers: headers ) { result in
            // isShowingLoader.toggle()
            isLoading = false
            print(result)
            switch result {
                
            case .success(let Response):
                
                if Response.rescode == 1 {
                    
                    print(Response)
                    
                  //  fin = Response.data!
                    alertService.show(title: "Alert", message: Response.message!)
                  
                    DispatchQueue.main.asyncAfter(deadline: .now() ) {
                        listTeams()
                    }
                    
                    //  self.presentationMode.wrappedValue.dismiss()
                    
                    
                }else{
                   
                    alertService.show(title: "Alert", message: Response.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
        
    }
    
  
    
    
    func listTeams(){
        // isShowingLoader.toggle()
        isLoading = true
        
        let token = UserDefaults.standard.string(forKey: Constants.USER_SESSION_TOKEN)
        let headers:HTTPHeaders = [
            //   "Content-Type":"application/x-www-form-urlencoded",
            "x-access-token": token!
        ]
        
        let userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        
        
        
        print(token!)
        
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!
            
        ]
        
        //let registerViewModel = RegisterViewModel()
        
        
        let teamsViewModel = TeamsViewModel()
        
        teamsViewModel.ListTeams(parameters: parameters,headers: headers ) { result in
            // isShowingLoader.toggle()
            isLoading = false
            print(result)
            switch result {
                
            case .success(let Response):
                
                if Response.rescode == 1 {
                    
                    print(Response)
                    
                    fin = Response.data!
                    
                    if (fin.isEmpty)
                    {
                        emptyView = true
                    }else
                    {
                        emptyView = false
                    }
                    
                    //  self.presentationMode.wrappedValue.dismiss()
                    
                    
                }else{
                    emptyView = true
                    alertService.show(title: "Alert", message: Response.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    
    func listMembers()
    {
        // isShowingLoader.toggle()
        isLoading = true
        
        let token = UserDefaults.standard.string(forKey: Constants.USER_SESSION_TOKEN)
        let headers:HTTPHeaders = [
            //   "Content-Type":"application/x-www-form-urlencoded",
            "x-access-token": token!
        ]
        
        let userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        
        print(token!)
        
        let parameters: [String:Any] =
        [
            "plattype": Global.PlatType,
            "user_id": userID!,
            "election_id": value
            
        ]
        
        //let registerViewModel = RegisterViewModel()
        
        
        let teamsViewModel = TeamsViewModel()
        
        teamsViewModel.ListMembers(parameters: parameters,headers: headers ) { result in
            // isShowingLoader.toggle()
            isLoading = false
            print(result)
            switch result {
                
            case .success(let Response):
                
                if Response.rescode == 1 {
                    
                    print(Response)
                    
                    fin = Response.data!
                    if (fin.isEmpty)
                    {
                        emptyView = true
                    }else
                    {
                        emptyView = false
                    }
                    
                    //  self.presentationMode.wrappedValue.dismiss()
                    
                    
                }else{
                    emptyView = true
                    alertService.show(title: "Alert", message: Response.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    func addButton()
    {
        if selectedTab == 0
        {
            addMemberView = true
        }else
        {
            isUpdate = false

            addTeamView = true
       
        }

    }
    struct MembersCell: View {
        
        
        
        var name : String
        var cnic : String
        var mobileNumber : String
        
        
        var body: some View {
            HStack {
                HStack {
                    Spacer()
                    
                    VStack(alignment: .leading){
                        
                        Text("Name")
                            .font(.subheadline)
                        
                        Spacer()
                        Text("CNIC")
                            .font(.subheadline)
                        
                        Spacer()
                        
                        Text("Mobile Number:")
                            .font(.subheadline)
                        Spacer()
                        
                    }.padding(10)
                    
                    
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity,
                               alignment: .topLeading)
                    Spacer()
                    Spacer()
                    Spacer()
                    VStack(alignment: .leading){
                        
                        Text(name)
                            .font(.subheadline)
                        
                        Spacer()
                        Text(cnic)
                            .font(.subheadline)
                        
                        Spacer()
                        Text(mobileNumber)
                            .font(.subheadline)
                        
                        Spacer()
                        
                    }.padding(10)
                    
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity,
                               alignment: .topLeading)
                        .fontWeight(.semibold)
                    
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
        }
        
        
        
    }
    
    
    struct TeamsCell: View {
        
        @State private var showAlert = false
        var Team : String
        var TeamMessage: String
        var addAction: () -> Void
        var updateAction: () -> Void
        var deleteAction: () -> Void
        
        
        
        var body: some View {
            HStack {
                VStack{
                    HStack {
                        Text(Team)
                            .font(.headline)
                        
                        Spacer()
                        
                        HStack(spacing: 20){
                            Button(action: {}) {
                                Image("Member")
                                    .imageScale(.medium)
                                    .foregroundColor(.blue)
                                
                            }.onTapGesture
                            {
                            addAction()
                            }
                            
                            Button(action: {}) {
                                Image(systemName: "pencil")
                                    .imageScale(.medium)
                                    .foregroundColor(.green)
                            }.onTapGesture
                            {
                             updateAction()
                            }
                            
                            Button(action: {}) {
                                Image(systemName: "trash")
                                    .imageScale(.medium)
                                    .foregroundColor(.green)
                            }.onTapGesture {
                               // Alert(title: "Deleting",message: "Are you sure")
                            deleteAction()
                            }
                            
                            
                            
                        }
                        
                    }
                    VStack(){
                        Text(TeamMessage)
                            .font(.subheadline)
                            .frame(maxWidth: .infinity,
                                   maxHeight: .infinity,
                                   alignment: .topLeading)
                           
                            
                        
                    }
                    
                    
                }
            }
            .padding(.horizontal, 5)
            .padding(.vertical, 10)
        }
        
    }
}

struct TeamsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsScreenView(value: "")
    }
}
