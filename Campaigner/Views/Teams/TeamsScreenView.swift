//
//  TeamsScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 02/06/2023.
//

import SwiftUI
import Alamofire

struct TeamsScreenView: View {
    @State private var selectedTab = 0
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var isLoading = false
    
    @State private var addMemberView = false
    @State private var addTeamView = false
    
   
    
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
                        Image(systemName: "arrowshape.left")
                            .imageScale(.large)
                        
                    }
                    Spacer()
                    Text("Teams")
                        .font(.headline)
                    
                    Spacer()
                    
                }.foregroundColor(CColors.MainThemeColor)
                    .padding()
                    .navigationBarHidden(true)
                
                Divider()
                
                HStack(spacing: 0) {
                    Spacer()
                    
                    TabBarButton(text: "Members", isSelected: selectedTab == 0) {
                        selectedTab = 0
                    }
                    
                    Spacer()
                    
                    TabBarButton(text: "Teams", isSelected: selectedTab == 1) {
                        selectedTab = 1
                    }
                    
                    Spacer()
                }.frame(height: 40)
                    .foregroundColor(Color.black)
                
                
                ZStack{
                    
                    VStack {
                        if selectedTab == 0 {
                            // Table view
                            List {
                                ForEach(0..<5) { index in
                                    MembersCell(name: "name", cnic: "cnic", mobileNumber: "mobileNumber")
                                }
                            }
                        } else {
                            
                            
                            List {
                                ForEach(0..<5) { index in
                                    TeamsCell(Team: "Support Team", TeamMessage: "This is testing....")
                                }
                            }
                        }
                        
                        // Other views...
                    }
                    
                    
                    
                    
                    
                    // Addition sign
                    AddButton(action: add, label: "")
                    // .padding(.top)
                    
                }
                
            }
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $addMemberView) {
                AddMemberView()
            }
            .fullScreenCover(isPresented: $addTeamView) {
                AddTeamView()
            }
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
    
    func listMembers(){
        // isShowingLoader.toggle()
        isLoading = true
        
        let token = UserDefaults.standard.string(forKey: Constants.USER_SESSION_TOKEN)
        let headers:HTTPHeaders = [
            // "Content-Type":"application/x-www-form-urlencoded",
            "x-access-token": token!
        ]
        
        let userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        
        
        
        print(token!)
        
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!
            
        ]
        
        //let registerViewModel = RegisterViewModel()
        
        
        let contestentViewModel = ContestentViewModel()
        
        contestentViewModel.listElections(parameters: parameters,headers: headers ) { result in
            // isShowingLoader.toggle()
            isLoading = false
            print(result)
            switch result {
                
            case .success(let loginResponse):
                
                if loginResponse.rescode == 1 {
                    
                    print(loginResponse)
                    
                    fin = loginResponse.data!
                    
                    //  self.presentationMode.wrappedValue.dismiss()
                    
                    
                }else{
                    alertService.show(title: "Alert", message: loginResponse.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    func add()
    {
        if selectedTab == 0
        {
            addMemberView = true
        }else
        {
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
                        
                    }
              

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

                    }
                 
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity,
                               alignment: .topLeading)
                        .fontWeight(.semibold)
                    
                }
            }
            .padding(.horizontal, 5)
            .padding(.vertical, 20)
        }
        
    
        
    }
    
    
    struct TeamsCell: View {
        
        
        var Team : String
        var TeamMessage: String
        
        
        
        var body: some View {
            HStack {
                VStack{
                    HStack {
                        Text(Team)
                            .font(.subheadline)
                        
                        Spacer()
                        
                        HStack(){
                            Button(action: {
                                // Perform action for Icon Button 1
                                //Update record
                            }) {
                                Image("Member")
                                    .imageScale(.small)
                                    .foregroundColor(.blue)
                            }
                            
                            Button(action: {
                                // Perform action for Icon Button 2
                                // Edit Record
                                
                            }) {
                                Image("edit")
                                    .imageScale(.small)
                                    .foregroundColor(.green)
                            }
                            
                            
                            
                        }
                        
                    }
                    HStack{
                        Text(TeamMessage)
                            .font(.subheadline)
                        
                    }.frame(maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .topLeading)
               Spacer().frame(height: 0) // Adjust the height of the Spacer

                }
            }
            .padding(.horizontal, 5)
            .padding(.vertical, 20)
        }
        
    }
}

struct TeamsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsScreenView()
    }
}
