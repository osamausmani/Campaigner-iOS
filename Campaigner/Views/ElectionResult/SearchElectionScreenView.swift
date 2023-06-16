//
//  Election.swift
//  Campaigner
//
//  Created by Macbook  on 13/06/2023.
//



import SwiftUI
import Alamofire

struct SearchElectionScreenView: View {
    
  
  
    @State private var selectedOption = 0
    
    @State private var cYear = DropDownModel()
    @State private var cAssembly = DropDownModel()
    @State private var cDistrict = DropDownModel()
    @State private var cConstituency = DropDownModel()
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
        DropDownModel(id: "2", value: "Provencial Assembly"),
        
    ]
    
    @State  var electionYear : [DropDownModel] = []
    @State  var assemblyName : [DropDownModel] = []
    @State  var constituencyName : [DropDownModel] = []
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                BaseView(alertService: alertService)
             
                    Image("splash_background")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                
                ZStack{
                    ScrollView{
                        headerView
                        VStack {

                            CustomDropDown(label: "Election Year", placeholder: "Select Election Year", selectedObj:  $cYear, menuOptions: electionYear, onChange:{_ in
                                dropdownAsselblyChanged()
                            }  )
                            
                            
                            
                            DropDown(label: "Assembly", placeholder: "Select Assembly", selectedObj:  $cAssembly, menuOptions: assemblyName )
                            
//                            CustomDropDown(label: "District", placeholder: "Select District", selectedObj:  $cDistrict, menuOptions: districtName, onChange: {_ in
//                                selectConstituency()
//                            }
//                            )
                            
                            DropDown(label: "Constituency", placeholder: "Select Constituency", selectedObj:  $cConstituency, menuOptions: constituencyName )
                            
                            
                            Spacer()
                            Spacer()
                            Divider()
                            Spacer()
                            Spacer()
                            
                            MainButton(action: {
                                AddAction()
                            }, label: "Submit").padding(.top,5)
                            
                            
                        }.padding(16)
                        
                        
                    }
            
                }
                
                
            }
            .offset(y: kGuardian.slide).animation(.easeInOut(duration: 1.0))
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            
        }.navigationBarHidden(false)
            .navigationTitle("Search Elections")
        
            .overlay(
                        Group {
                            if isLoading {
                                ProgressHUDView()
                            }
                        }
            )
        
    }
    
    
    var headerView: some View {
        HStack {
            
            
            Text("Election")
                .font(.headline)
                .padding(.horizontal, 5)
                .padding(.vertical, 5)
            //
            
                .fontWeight(.bold)
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .leading)
            // Spacer().frame(height: 0)
            
            
            Button(action: {
                // Perform cancel action
                // self.presentationMode.wrappedValue.dismiss()
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .font(.title)
            }
        }
        .padding(.horizontal)
        .foregroundColor(.white)
        .background(CColors.MainThemeColor)
        //.cornerRadius(10)
        .frame(height: 40) // Increase the height to 200 points
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
    
    func dropdownAsselblyChanged()
    {
        searchProvince()
    }
    
    func searchProvince(){
        
       
       isLoading = true
        // isShowingLoader.toggle()
        
        var userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!,
            //  "assembly": selectedOption + 1
            // "na_id": cDistrict
        ]
        
        let lookupsViewModel = LookupsViewModel()
        
        var newDropDownData : [DropDownModel] = []
        
        lookupsViewModel.listProvinces(parameters: parameters ) { result in
            isLoading = false
            print(result)
           // searchDistrict()
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
                    
                    assemblyName = newDropDownData
                }else{
                    alertService.show(title: "Alert", message: Response.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
                
              //  isShowingLoader.toggle()
            }
        }
    }
    

    
//    func searchDistrict()
//    {
//        isLoading = true
//        var userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
//        let parameters: [String:Any] = [
//            "plattype": Global.PlatType,
//            //          "user_id": userID!,
//            //           "assembly": selectedOption + 1
//            // "na_id": cDistrict
//        ]
//
//        let lookupsViewModel = LookupsViewModel()
//
//        var newDropDownData : [DropDownModel] = []
//
//        lookupsViewModel.listDistricts(parameters: parameters ) { result in
//            isLoading = false
//            print(result)
//            switch result {
//
//            case .success(var Response):
//
//                print(Response)
//
//                if Response.rescode == 1
//                {
//                    district = Response.data!
//
//                    for i in district {
//                        let dropDownModel = DropDownModel(id: i.district_id!, value: i.district_name!)
//                        newDropDownData.append(dropDownModel)
//                    }
//                    //  provinceName = []
//                    //districtName.append(contentsOf: newDropDownData)
//                    districtName = newDropDownData
//
//                }else{
//                    alertService.show(title: "Alert", message: Response.message!)
//                }
//
//            case .failure(let error):
//                alertService.show(title: "Alert", message: error.localizedDescription)
//
//              //  isShowingLoader.toggle()
//            }
//        }
//    }
    
    func selectConstituency() {
        isLoading = true
        
        var userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!,
            // "assembly": selectedOption + 1
            // "na_id": cDistrict
        ]
        
        let lookupsViewModel = LookupsViewModel()
        
        var newDropDownData : [DropDownModel] = []
        
        lookupsViewModel.listConstituency(parameters: parameters ) { result in
            isLoading = false
            print(result)
            switch result {
                
            case .success(var Response):
                
                print(Response)
                
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
        if(cYear.value.isEmpty){
            alertService.show(title: "Alert", message: "Assemly is required")
        }
        
        else if(cAssembly.value.isEmpty){
            alertService.show(title: "Alert", message: "Province is required")
        }
        
        else if(cDistrict.value.isEmpty){
            alertService.show(title: "Alert", message: "District is required")
        }
        
        else if(cConstituency.value.isEmpty){
            alertService.show(title: "Alert", message: "Constituency is required")
        }
        
        
        else{
            //addContestElection()
        }
    }
    
    
//    func addContestElection(){
//        isLoading = true
//
//        var finProvince = ""
//        for i in province{
//           if( i.province == cProvince.value)
//            {
//               finProvince = i.province_id!
//           }
//        }
//
//
//        var finDistrict = ""
//        for i in district{
//            if( i.district_name == cDistrict.value)
//            {
//                finDistrict = i.district_id!
//           }
//        }
//
//
//
//        let token = UserDefaults.standard.object(forKey: Constants.USER_SESSION_TOKEN) as! String
//
//        print(token)
//        let headers:HTTPHeaders = [
//            // "Content-Type":"application/x-www-form-urlencoded",
//            "x-access-token": token
//        ]
//      //  isShowingLoader.toggle()
//
//
//        for lan in constituency where lan.constituency! ==  cConstituency.value
//        {
//            print(lan.id_text!)
//            cConstituency.id = lan.id_text!
//        }
//        var userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
//        let parameters: [String:Any] = [
//            "plattype": Global.PlatType,
//            "user_id": userID!,
//            "election_province": finProvince,
//            "election_district": finDistrict,
//            "election_type": cAssembly.id,
//            "constituency_id":cConstituency.id
//        ]
//
//        let contestentViewModel = ContestentViewModel()
//
//        contestentViewModel.addContestentRequest(parameters: parameters , headers: headers) { result in
//           // isShowingLoader.toggle()
//            isLoading = false
//            switch result {
//
//            case .success(let addResponse):
//
//                if addResponse.rescode == 1 {
//
//                 //   alertService.show(title: "Alert", message: addResponse.message!)
//
//                    self.presentationMode.wrappedValue.dismiss()
//
//                  //  ContestingElectionScreenView.loadContestElection()
//
//
//                }else{
//                    alertService.show(title: "Alert", message: addResponse.message!)
//                }
//
//            case .failure(let error):
//                alertService.show(title: "Alert", message: error.localizedDescription)
//            }
//        }
//    }
    
    
    
}

struct Election_Previews: PreviewProvider {
    static var previews: some View {
        SearchElectionScreenView()
    }
}
