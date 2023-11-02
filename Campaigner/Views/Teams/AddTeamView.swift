//
//  AddTeamView.swift
//  Campaigner
//
//  Created by Macbook  on 14/06/2023.
//

import SwiftUI
import Alamofire



struct AddTeamView: View {
    
    @State private var selectedTeamId = ""
    
    
      var isUpdate = false
    
    
    @Binding var title : String
    @Binding var description : String
    @Binding var message : String
    @Binding var selected_team_id : String
    
    
    
    @State private var isLoading = false
    @State private var fvTeamName = ""
    @State private var fvPollingStations = DropDownModel()
    @State private var fvDescription = ""
    
   
   
    
    
    @State private var showRegisterScreen = false
    @State private var isShowingLoader = false
    
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    @State var showStoreDropDown: Bool = false
    
    @StateObject private var alertService = AlertService()
    
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
        
        NavigationView {
            
            ZStack {
                BaseView(alertService: alertService)
                
                ZStack{
                    
                    Image("splash_background")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    
                    ScrollView{
                        if(isUpdate == false)
                        {
                            headerView(heading: "Add Team", action: dismissView)
                        }else
                        {
                            headerView(heading: "Update Team", action: dismissView)
                            
                        }
                        
                        if (isUpdate == false)
                        {
                            VStack {
                                FormInputField(label: "Team Name", placeholder: "Enter Name", text: $fvTeamName)
                                DropDown(label: "Polling Station", placeholder: "Select Polling Station", selectedObj:  $fvPollingStations, menuOptions: pollingStationsOptions)
                                MultilineFormInput(label: "Description", placeholder: "Enter Description", text: $fvDescription)
                                Spacer()
                                Spacer()
                                Divider()
                                MainButton(action: {
                                    RegisterAction()
                                }, label: "Invite").padding(.top,20)
                            }.padding(16)
                        }else
                        {
 
                            VStack {
                                FormInput(label: "Team Name", placeholder: "Enter Name", text: $fvTeamName)
                                DropDown(label: "Polling Station", placeholder: "Select Polling Station", selectedObj:  $fvPollingStations, menuOptions: pollingStationsOptions)
                                MultilineFormInput(label: "Description", placeholder: "Enter Description", text: $fvDescription)
                                Spacer()
                                Spacer()
                                Divider()
                                MainButton(action: {
                                    RegisterAction()
                                }, label: "Update").padding(.top,20)
                            }.padding(16)
                        }
                        
                    }
                    
                    if isShowingLoader {
                        Loader(isShowing: $isShowingLoader)
                            .edgesIgnoringSafeArea(.all)
                    }
                }
                
                
            }
            .offset(y: kGuardian.slide).animation(.easeInOut(duration: 1.0))
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            
        }.navigationBarHidden(false)
            .navigationTitle("Sign Up")
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
            alertService.show(title: "Alert", message: "Team Name is required")
        }
        
        else if(fvPollingStations.value.isEmpty)
        {
            alertService.show(title: "Alert", message: "Polling Station is required")
        }
        
        else if(fvDescription.isEmpty)
        {
            alertService.show(title: "Alert", message: "Description is required")
        }
        
        
        
        //        else if(fvConfirmPassword.isEmpty){
        //            alertService.show(title: "Alert", message: "Confirm Password is required")
        //        }
        //
        //        else if(fvPassword != fvConfirmPassword){
        //            alertService.show(title: "Alert", message: "Password/Confirm Password are not same")
        //        }
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
                    alertService.show(title: "Alert", message: Response.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
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
            "poll_station_id" : fin
            
           
            
        ]
        
        let teamsViewModel = TeamsViewModel()
        
        teamsViewModel.AddTeam(parameters: parameters, headers: headers ) { result in
            isShowingLoader.toggle()
            
            switch result {
                
            case .success(let loginResponse):
                
                if loginResponse.rescode == 1 {
                    
                //    alertService.show(title: "Alert", message: loginResponse.message!)
                    
                   
                    self.presentationMode.wrappedValue.dismiss()
                    
                }else{
                    alertService.show(title: "Alert", message: loginResponse.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
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
            "poll_station_id" : fin
            
            
        ]
        
        //let registerViewModel = RegisterViewModel()
        
        
        let teamsViewModel = TeamsViewModel()
        
        teamsViewModel.UpdateTeam(parameters: parameters,headers: headers ) { result in
            // isShowingLoader.toggle()
            isLoading = false
            print(result)
            switch result {
                
            case .success(let Response):
                
                if Response.rescode == 1 {
                    
                    print(Response)
                    
                  //  fin = Response.data!
                   // alertService.show(title: "Alert", message: Response.message!)
                  
                  
                    
                      self.presentationMode.wrappedValue.dismiss()
                    
                    
                }else{
                   
                    alertService.show(title: "Alert", message: Response.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
        
        
        
    }
    
    
}

struct AddTeamView_Previews: PreviewProvider {
    static var previews: some View {
        AddTeamView(isUpdate: true, title: .constant(""), description: .constant(""), message: .constant(""), selected_team_id: .constant(""))
    }
}
