//
//  ContestingElectionPopUpView.swift
//  Campaigner
//
//  Created by Macbook  on 31/05/2023.
//

import SwiftUI
import Alamofire

struct ContestingElectionPopUpScreenView: View {
    
   // @Binding var refreshFlag: Bool
  
    @State private var selectedOption = 0
    
    @State private var cAssembly = DropDownModel()
    @State private var cProvince = DropDownModel()
    @State private var cDistrict = DropDownModel()
    @State private var cConstituency = DropDownModel()
    @State private var party = DropDownModel()
    @State private var fvPassword = ""
    @State private var fvConfirmPassword = ""
    
    @State private var showRegisterScreen = false
    @State private var isShowingLoader = false
    @State private var isLoading = false
    
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    @State var showStoreDropDown: Bool = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject private var alertService = AlertService()
    
    
    //Model
    @State var constituency = [ConstituencyResponseModel]()
    @State var district = [DistrictResponseModel]()
    @State var province = [ProvinceResponseModel]()
    

    var networkOptions: [DropDownModel] = []
    
    var assemblyType: [DropDownModel] = [
        DropDownModel(id: "1", value: "National Assembly"),
        DropDownModel(id: "2", value: "Provincial Assembly"),
        
    ]
    
    @State  var provinceName : [DropDownModel] = []
    @State  var districtName : [DropDownModel] = []
    @State  var constituencyName : [DropDownModel] = []
    @State  var partiesName : [DropDownModel] = []
    @State  var partiesList: [PartiesResponseModel] = []
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                BaseView(alertService: alertService)
                
                ZStack{
                    ScrollView{
                        headerView( heading: "Add Contesting Election", action: dismissView)
                        VStack {

                            CustomDropDown(label: "Assembly", placeholder: "Select Assembly", selectedObj:  $cAssembly, menuOptions: assemblyType, onChange:{_ in
                                dropdownAsselblyChanged()
                            }  )
                            
                            
//                            
//                            DropDown(label: "Province", placeholder: "Select Province", selectedObj:  $cProvince, menuOptions: provinceName )
//                            
//                            CustomDropDown(label: "District", placeholder: "Select District", selectedObj:  $cDistrict, menuOptions: districtName, onChange: {_ in
//
//                            }
//                            )
                            
                            DropDown(label: "Constituency", placeholder: "Select Constituency", selectedObj:  $cConstituency, menuOptions: constituencyName)
                            DropDown(label: "Party", placeholder: "Select Party", selectedObj:  $party, menuOptions: partiesName )
                            
                            
                            
                            Spacer()
                            Divider()
                            
                            
                            MainButton(action: {
                                AddAction()
                            }, label: "Add").padding(.top,5)
                            
                            
                        }.padding(16)
                        
                        
                    }
            
                }
                
                
            }
            .offset(y: kGuardian.slide).animation(.easeInOut(duration: 1.0))
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            
        }.navigationBarHidden(false)
            .navigationTitle("Sign Up")
            .overlay(
                        Group {
                            if isLoading {
                                ProgressHUDView()
                            }
                        }
                    )
            .onAppear(){
                selectConstituency()
            }
        
    }
    
    
   
    
    // Add Other Swift Functions Below Here
    
    //
    //    func dropdownAsselblyChanged(optionIndex: Int) {
    //        // Perform actions based on the selected option
    //        print("Selected option: \(assemblyType[optionIndex])")
    //
    //        searchProvince()
    //
    //
    //    }
    
    func dismissView()
    {
        self.presentationMode.wrappedValue.dismiss()
    }
    func dropdownAsselblyChanged()
    {
        searchProvince()
        getparties()
      
       
    }
    
    func searchProvince(){
        
       
       isLoading = true
        // isShowingLoader.toggle()
        
        var userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!,
          
        ]
        
        let lookupsViewModel = LookupsViewModel()
        
        var newDropDownData : [DropDownModel] = []
        
        lookupsViewModel.ListProvinces(parameters: parameters ) { result in
            isLoading = false
            print(result)
            searchDistrict()
            switch result {
                
            case .success(var Response):
                
                print(Response)
                
                if Response.rescode == 1
                {
                    province = Response.data!
                    
                    for i in province {
                        let dropDownModel = DropDownModel(id: i.province_id!, value: i.province!)
                        newDropDownData.append(dropDownModel)
                    }
                    //  provinceName = []
                    //   provinceName.append(contentsOf: newDropDownData)
                    
                    provinceName = newDropDownData
                }else{
                    alertService.show(title: "Alert", message: Response.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
                
              //  isShowingLoader.toggle()
            }
        }
    }
    

    
    func searchDistrict()
    {
        isLoading = true
        var userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            //          "user_id": userID!,
            //           "assembly": selectedOption + 1
            // "na_id": cDistrict
            
        ]
        
        let lookupsViewModel = LookupsViewModel()
        
        var newDropDownData : [DropDownModel] = []
        
        lookupsViewModel.ListDistricts(parameters: parameters ) { result in
            isLoading = false
            print(result)
            switch result {
                
            case .success(var Response):
                
                print(Response)
                
                if Response.rescode == 1
                {
                    district = Response.data!
                    
                    for i in district {
                        let dropDownModel = DropDownModel(id: i.district_id!, value: i.district_name!)
                        newDropDownData.append(dropDownModel)
                    }
                    //  provinceName = []
                    //districtName.append(contentsOf: newDropDownData)
                    districtName = newDropDownData
                    
                    
                    
                }else{
                    alertService.show(title: "Alert", message: Response.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
                
              //  isShowingLoader.toggle()
            }
        }
    }
    func getparties()
    {
        isLoading = true
        var userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!,
        
            
        ]
        
        let lookupsViewModel = LookupsViewModel()
        
        var newDropDownData : [DropDownModel] = []
        
        lookupsViewModel.ListParties(parameters: parameters ) { result in
            isLoading = false
            print(result)
            switch result {
                
            case .success(var Response):
                
                print(Response)
                
                if Response.rescode == 1
                {
                    partiesList = Response.data!
                    
                    for i in partiesList {
                        let dropDownModel = DropDownModel(id: i.id_text!, value: i.party_name!)
                        newDropDownData.append(dropDownModel)
                    }
                    //  provinceName = []
                    //districtName.append(contentsOf: newDropDownData)
                    partiesName = newDropDownData
                    
                    
                    
                }else{
                    alertService.show(title: "Alert", message: Response.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
                
              //  isShowingLoader.toggle()
            }
        }
    }

    
    func selectConstituency() {
        isLoading = true
        
        var finDistrict = ""
        for i in district{
            if( i.district_name == cDistrict.value)
            {
                finDistrict = i.district_id!
           }
        }
        
        var districtID = district
        var userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!,
             "assembly": selectedOption + 1
            // "na_id": cDistrict
//            "district_id": finDistrict
        ]
        
        let lookupsViewModel = LookupsViewModel()
        
        var newDropDownData : [DropDownModel] = []
        
        lookupsViewModel.ListConstituency(parameters: parameters ) { result in
            isLoading = false
            print(result)
            switch result {
                
            case .success(var Response):
                
//                print(Response)
                
                if Response.rescode == 1
                {
                    constituency = Response.data!
                    
                    print(constituency)
                    var  counter =  0
                    for i in constituency {
                        
                        let dropDownModel = DropDownModel(id: String(counter), value: i.constituency!)
                        newDropDownData.append(dropDownModel)
                        counter = counter + 1
                    }
                    print(newDropDownData)
                    //  provinceName = []
                    // constituencyName.append(contentsOf: newDropDownData)
                    
                    constituencyName = newDropDownData
                    
                }else{
                    alertService.show(title: "Alert", message: Response.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    

        
    
    
    func AddAction(){
        validateInputs()
    }
    
    
    func validateInputs(){
        if(cAssembly.value.isEmpty){
            alertService.show(title: "Alert", message: "Assemly is required")
        }
        
//        else if(cProvince.value.isEmpty){
//            alertService.show(title: "Alert", message: "Province is required")
//        }
//        
//        else if(cDistrict.value.isEmpty){
//            alertService.show(title: "Alert", message: "District is required")
//        }
        
        else if(cConstituency.value.isEmpty){
            alertService.show(title: "Alert", message: "Constituency is required")
        }
        else if(party.value.isEmpty){
            alertService.show(title: "Alert", message: "Party is required")
        }
        
        
        else{
            addContestElection()
        }
    }
    
    
    func addContestElection(){
        isLoading = true
        
        var finProvince = ""
        for i in province{
           if( i.province == cProvince.value)
            {
               finProvince = i.province_id!
           }
        }
        
        
        var finDistrict = ""
        for i in district{
            if( i.district_name == cDistrict.value)
            {
                finDistrict = i.district_id!
           }
        }
        
        
        
        let token = UserDefaults.standard.object(forKey: Constants.USER_SESSION_TOKEN) as! String
        
        print(token)
        let headers:HTTPHeaders = [
            // "Content-Type":"application/x-www-form-urlencoded",
            "x-access-token": token
        ]
      //  isShowingLoader.toggle()
        
        
        for lan in constituency where lan.constituency! ==  cConstituency.value
        {
            print(lan.id_text!)
            cConstituency.id = lan.id_text!
        }
        var userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!,
            "election_province": finProvince,
            "election_district": finDistrict,
            "election_type": cAssembly.id,
            "constituency_id":cConstituency.id,
            "party_id":party.id
        ]
        
        let contestentViewModel = ContestentViewModel()
        
        contestentViewModel.addContestentRequest(parameters: parameters , headers: headers) { result in
           // isShowingLoader.toggle()
            isLoading = false
            switch result {
                
            case .success(let addResponse):
                
                if addResponse.rescode == 1 {
                    
                 //   alertService.show(title: "Alert", message: addResponse.message!)
                   
                    self.presentationMode.wrappedValue.dismiss()
                    
                    
                  //  ContestingElectionScreenView.loadContestElection()
              
 
                }else{
                    alertService.show(title: "Alert", message: addResponse.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    
    
}

struct ContestiongElectionPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        ContestingElectionPopUpScreenView()
    }
}
