//
//  AddTeamView.swift
//  Campaigner
//
//  Created by Macbook  on 14/06/2023.
//

import SwiftUI
import Alamofire
import SwiftAlertView



struct AddTeamView: View {
    
    @State private var selectedTeamId = ""
    
    var isUpdate = false
    @State private var title = ""
    @State private var description  = ""
    @State private var message = ""
    @State private var selected_team_id = ""
    
    @State private var isLoading = false
    @State private var fvTeamName = ""
    @State private var fvPollingStations = DropDownModel()
    @State private var fvDescription = ""
    @State private var showRegisterScreen = false
    @State private var isShowingLoader = false
    
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    @State var showStoreDropDown: Bool = false
    @State var polling = [PollingStations]()
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    @State var pollingStationsOptions: [DropDownModel] = [
        //        DropDownModel(id: "1", value: "Ufone"),
        //        DropDownModel(id: "2", value: "Telenor"),
        //        DropDownModel(id: "3", value: "Jazz"),
        //        DropDownModel(id: "4", value: "Zong"),
        //        DropDownModel(id: "5", value: "Scom"),
    ]
    
    var body: some View {
        
        ZStack {
            ZStack{
                VStack{
                    if(isUpdate == false)
                    {
                        CustomNavBarBack(title: "Add Team")
                    }else
                    {
                        CustomNavBarBack(title: "Update Team")
                    }
                    ScrollView{
                        
                        VStack {
                            FormInputField(label: "Team Name", placeholder: "Enter Name", text: $fvTeamName)
                            SearchableDropDown(label: "Polling Station", placeholder: "Select Polling Station", selectedObj:  $fvPollingStations, menuOptions: pollingStationsOptions)
                            MultilineFormInput(label: "Description", placeholder: "Enter Description", text: $fvDescription)
                            Spacer()
                            Spacer()
                            Divider()
                            MainButton(action: {
                                RegisterAction()
                            }, label: isUpdate ? "Update" : "Add").padding(.top,20)
                        }.padding(16)
                        
                        
                    }
                    
                    if isShowingLoader {
                        Loader(isShowing: $isShowingLoader)
                            .edgesIgnoringSafeArea(.all)
                    }
                }
                
            }
        }
        .offset(y: kGuardian.slide).animation(.easeInOut(duration: 1.0))
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }.navigationBarHidden(true).edgesIgnoringSafeArea(.top)
            .onAppear{
                listPollingStations()
                
                if (isUpdate == true)
                {
                    fvTeamName = title
                    fvDescription = description
                    fvPollingStations.value = message
                }
            }
    }
    
    
    // Add Other Swift Functions Below Here
    
    func dismissView()
    {
        self.presentationMode.wrappedValue.dismiss()
    }
    func RegisterAction(){
        validateInputs()
    }
    
    
    func validateInputs(){
        
        
        if(fvTeamName.isEmpty)
        {
            SwiftAlertView.show(title: "Alert", message: "Team Name is required", buttonTitles: "OK")
        }
        
        else if(fvPollingStations.value.isEmpty)
        {
            SwiftAlertView.show(title: "Alert", message: "Polling Station is required", buttonTitles: "OK")
        }
        
        else if(fvDescription.isEmpty)
        {
            SwiftAlertView.show(title: "Alert", message: "Description is required", buttonTitles: "OK")        }
        else{
            if(isUpdate == false)
            {
                doInvite()
            }else
            {
                doUpdate()
            }
        }
    }
    
    func listPollingStations() {
        isLoading = true
        
        let userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!
            // "assembly": selectedOption + 1
            // "na_id": cDistrict
        ]
        
        let token = UserDefaults.standard.string(forKey: Constants.USER_SESSION_TOKEN)
        let headers:HTTPHeaders = [
            //   "Content-Type":"application/x-www-form-urlencoded",
            "x-access-token": token!
        ]
        
        let lookupsViewModel = LookupsViewModel()
        
        var newDropDownData : [DropDownModel] = []
        
        lookupsViewModel.ListPollingStation(parameters: parameters,headers:headers ) { result in
            isLoading = false
            print(result)
            switch result {
                
            case .success(var Response):
                
                print(Response)
                
                if Response.rescode == 1
                {
                    polling = Response.data!
                    
                    print(polling)
                    var  counter =  0
                    for i in polling {
                        
                        let dropDownModel = DropDownModel(id: String(counter), value: i.pol_name ?? "")
                        newDropDownData.append(dropDownModel)
                        counter = counter + 1
                    }
                    print(newDropDownData)
                    //  provinceName = []
                    // constituencyName.append(contentsOf: newDropDownData)
                    
                    //constituencyName = newDropDownData
                    pollingStationsOptions = newDropDownData
                    
                    
                    
                    
                }else{
                    SwiftAlertView.show(title: "Alert", message: Response.message, buttonTitles: "OK")
                    
                }
                
            case .failure(let error):
                SwiftAlertView.show(title: "Alert", message: error.localizedDescription, buttonTitles: "OK")
            }
        }
    }
    
    
    func doInvite()
    {
        
        isShowingLoader.toggle()
        
        let token = UserDefaults.standard.object(forKey: Constants.USER_SESSION_TOKEN) as! String
        
        print(token)
        let headers:HTTPHeaders = [
            "Content-Type":"application/x-www-form-urlencoded",
            "x-access-token": token
        ]
        let userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        
        var fin = ""
        
        for i in polling {
            if (i.pol_name == fvPollingStations.value)
            {
                fin = i.station_id ?? ""
            }
        }
        
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!,
            "team_title": fvTeamName,
            "team_desc" : fvDescription,
            "poll_station_id" : fin,
            "election_id": UserDefaults.standard.string(forKey: Constants.USER_ELECTION_ID)!,

            
            
        ]
        
        let teamsViewModel = TeamsViewModel()
        
        teamsViewModel.AddTeam(parameters: parameters, headers: headers ) { result in
            isShowingLoader.toggle()
            
            switch result {
                
            case .success(let response):
                
                if response.rescode == 1 {
                    
                    SwiftAlertView.show(title: "Alert", message: response.message, buttonTitles: "OK")
                    
                    
                    self.presentationMode.wrappedValue.dismiss()
                    
                }else{
                    SwiftAlertView.show(title: "Alert", message: response.message, buttonTitles: "OK")
                }
                
            case .failure(let error):
                SwiftAlertView.show(title: "Alert", message: error.localizedDescription, buttonTitles: "OK")
                
            }
        }
    }
    
    func doUpdate()
    {
        print("update")
        // isShowingLoader.toggle()
        
        var fin = ""
        
        for i in polling {
            if (i.pol_name == fvPollingStations.value)
            {
                fin = i.station_id ?? ""
            }
        }
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
            "team_id": selected_team_id,
            "team_title": fvTeamName,
            "team_desc": fvDescription ,
            "poll_station_id" : fin,
            "election_id": UserDefaults.standard.string(forKey: Constants.USER_ELECTION_ID)!,

            
        ]
        
        //let registerViewModel = RegisterViewModel()
        
        
        let teamsViewModel = TeamsViewModel()
        
        teamsViewModel.UpdateTeam(parameters: parameters,headers: headers ) { result in
            // isShowingLoader.toggle()
            isLoading = false
            print(result)
            switch result {
                
            case .success(let response):
                
                if response.rescode == 1 {
                    
                    
                    
                    SwiftAlertView.show(title: "Alert", message: response.message, buttonTitles: "OK")
                    
                    
                    self.presentationMode.wrappedValue.dismiss()
                    
                    
                }else{
                    
                    SwiftAlertView.show(title: "Alert", message: response.message, buttonTitles: "OK")
                }
                
            case .failure(let error):
                SwiftAlertView.show(title: "Alert", message: error.localizedDescription, buttonTitles: "OK")
                
            }
        }
        
        
        
    }
    
    
}

struct AddTeamView_Previews: PreviewProvider {
    static var previews: some View {
        AddTeamView()
    }
}
