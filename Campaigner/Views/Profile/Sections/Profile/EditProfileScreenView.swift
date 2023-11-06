//
//  EditProfileScreenView.swift
//  Campaigner
//
//  Created by Osama Usmani on 04/11/2023.
//

import Foundation
import SwiftUI
import SwiftAlertView

struct EditProfileScreenView: View {
    @StateObject private var alertService = AlertService()
    
    @State private var userRecord : BasicProfileInfoResponseData?
    
    @State private var isShowingLoader = false
    @State private var showActionSheet = false
    @State private var sourceType = 0
    @State private var showImagePicker = false
    @State var selectedImage: UIImage?
    
    @State var inputName: String = ""
    private let genderOptions: [DropDownModel] = [
        DropDownModel(id: "1", value: "Male"),
        DropDownModel(id: "2", value: "Female"),
        DropDownModel(id: "3", value: "Others")
    ]
    
    @State  var districtOptions: [DropDownModel] = []
    @State  var tehsilOptions: [DropDownModel] = []
    @State  var naOptions: [DropDownModel] = []
    @State  var paOptions: [DropDownModel] = []
    
    @State  var selectedGender = DropDownModel()
    
    @State  var selectedDistrict = DropDownModel()
    @State  var selectedTehsil = DropDownModel()
    @State  var selectedNA = DropDownModel()
    @State  var selectedPA = DropDownModel()
    
    
    var body: some View {
        
        ZStack{
            Image("splash_background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                CustomNavBarBack(title: "Edit Profile")
                ScrollView{
                    VStack{
                        ZStack {
                            ZStack {
                                Image(uiImage: (selectedImage != nil ? UIImage(cgImage: selectedImage!.cgImage!) : UIImage(named: "default_large_image"))!)
                                    .resizable()
                                    .cornerRadius(60)
                                    .frame(width: 120, height: 120)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 60)
                                            .stroke(Color.black, lineWidth: 1)
                                    )
                                    .alignmentGuide(.bottom) { d in d[.bottom] }
                                HStack{Image("camera_dialog")
                                        .resizable()
                                        .cornerRadius(10)
                                        .frame(width: 24, height: 24).padding(2)
                                }.background(.white).cornerRadius(10).overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.black, lineWidth: 1)
                                ).padding(.top, 80).padding(.leading, 80).onTapGesture {
                                    showActionSheet.toggle()
                                }.actionSheet(isPresented: $showActionSheet) {
                                    ActionSheet(title: Text("Select Image"), message: nil, buttons: [
                                        .default(Text("Photo Library")) {
                                            // Handle selection from photo library
                                            self.sourceType = 0
                                            self.showImagePicker = true
                                        },
                                        .default(Text("Camera"))
                                        {
                                            // Handle selection from camera
                                            self.sourceType = 1
                                            self.showImagePicker = true
                                        },
                                        .cancel()
                                    ])
                                }
                            }.padding(20)
                        }
                        
                        HStack{
                            VStack {
                                FormInputField(label: "Name", placeholder: "Enter Name", isDisabled: true, text: $inputName)
                                DropDown(label: "Gender", placeholder: "Select Gender", selectedObj:  $selectedGender, menuOptions: genderOptions )
                                SearchableDropDown(label: "District", placeholder: "Select District", selectedObj:  $selectedDistrict, menuOptions: districtOptions )
                                SearchableDropDown(label: "Tehsil/City/Town", placeholder: "Select Tehsil/City/Town", selectedObj:  $selectedTehsil, menuOptions: tehsilOptions )
                                SearchableDropDown(label: "National Assembly (NA)", placeholder: "Select National Assembly", selectedObj:  $selectedNA, menuOptions: naOptions )
                                SearchableDropDown(label: "Provincial Assembly (PA)", placeholder: "Select Provincial Assembly", selectedObj:  $selectedPA, menuOptions: paOptions )
                                MainButton(action: SubmitAction, label:  "Update").padding(.top,20)
                            }.frame(width: .infinity, height: .infinity).padding(10)
                            
                        }.background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                        )
                        Spacer()
                    }.padding(10)
                }
            }
            if isShowingLoader {
                Loader(isShowing: $isShowingLoader)
                    .edgesIgnoringSafeArea(.all)
            }
            
        }.ignoresSafeArea(.all) .navigationBarHidden(true).sheet(isPresented: $showImagePicker)
        {
            ImageUploader(selectedImage: $selectedImage, sourceTypeNo: sourceType)
        }
        .onChange(of:selectedDistrict) { newValue in
            
            GetTehsils(dID: newValue.id)
            LoadPAConstituencies(dID: newValue.id)
            LoadNAConstituencies(dID: newValue.id)
            
        }
        .onAppear{
            InitUserData()
            GetDistricts()
            LoadUserData()
        }
        .onChange(of:userRecord) { newValue in
            if let uGender = userRecord?.user_gender {
                let uGenderString = String(uGender)
                selectedGender = genderOptions.first { $0.id == uGenderString }!
            }
            if userRecord?.district_id != nil {
                selectedDistrict = districtOptions.first { $0.id == userRecord?.district_id }!
            }
            if userRecord?.tehsil_id != nil {
                selectedTehsil = DropDownModel(id: (userRecord?.tehsil_id)!, value: (userRecord?.tehsil_name)!)
            }
            if userRecord?.constituency_id_na != nil {
                selectedNA = DropDownModel(id: (userRecord?.constituency_id_na)!, value: (userRecord?.constituency_na)!)
            }
            if userRecord?.constituency_id_pa != nil {
                selectedPA = DropDownModel(id: (userRecord?.constituency_id_pa)!, value: (userRecord?.constituency_pa)!)
            }
            
        }
        
    }
    
    func InitUserData(){
        inputName = UserDefaults.standard.string(forKey: Constants.USER_NAME) ?? "User Name"
    }
    
    
    func OpenImagePicker(){
        ActionSheet(title: Text("Select Image"), message: nil, buttons: [
            .default(Text("Photo Library")) {
                self.sourceType = 0
                self.showImagePicker = true
            },
            .default(Text("Camera"))
            {
                self.sourceType = 1
                self.showImagePicker = true
            },
            .cancel()
        ])
    }
    
    
    
    func GetDistricts(){
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
        ]
        let ViewModel = LookupsViewModel()
        ViewModel.ListDistricts(parameters: parameters ) { result in
            switch result {
            case .success(let response ):
                if response.rescode == 1 {
                    let newOptions = response.data?.map { data in
                        DropDownModel(id: (data.district_id!), value: (data.district_name!))
                    }
                    districtOptions.append(contentsOf: newOptions!)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func GetTehsils(dID:String){
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "district_id" : dID
        ]
        let ViewModel = LookupsViewModel()
        ViewModel.ListTehsils(parameters: parameters ) { result in
            switch result {
            case .success(let response ):
                if response.rescode == 1 {
                    let newOptions = response.data?.map { data in
                        DropDownModel(id: (data.tehsil_id!), value: (data.tehsil_name!))
                    }
                    tehsilOptions.removeAll()
                    tehsilOptions.append(contentsOf: newOptions!)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func LoadNAConstituencies(dID:String) {
        var userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!,
            "assembly": "1",
            "district_id" : dID
        ]
        let LookupsViewModel = LookupsViewModel()
        LookupsViewModel.ListConstituency(parameters: parameters ) { result in
            switch result {
            case .success(var response):
                if response.rescode == 1
                {
                    let newOptions = response.data?.map { data in
                        DropDownModel(id: (data.id_text!), value: (data.constituency!))
                    }
                    naOptions.removeAll()
                    naOptions.append(contentsOf: newOptions!)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func LoadPAConstituencies(dID:String) {
        var userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!,
            "assembly": "2",
            "district_id" : dID
        ]
        let LookupsViewModel = LookupsViewModel()
        LookupsViewModel.ListConstituency(parameters: parameters ) { result in
            switch result {
            case .success(var response):
                if response.rescode == 1
                {
                    let newOptions = response.data?.map { data in
                        DropDownModel(id: (data.id_text!), value: (data.constituency!))
                    }
                    paOptions.removeAll()
                    paOptions.append(contentsOf: newOptions!)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func SubmitAction(){
        UpdateProfile()
    }
    
    func UpdateProfile() {
        let parameters: [String:Any] = [
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "plattype": Global.PlatType,
            "user_full_name": inputName,
            "user_gender" : selectedGender.id,
            "info_district_id" : selectedDistrict.id,
            "info_tehsil_id" : selectedTehsil.id,
            "user_constituency_pa" : selectedPA.id,
            "user_constituency_na": selectedNA.id,
        ]
        let ViewModel = ProfileViewModel()
        ViewModel.ProfileBasicInfoUpdate(parameters: parameters ) { result in
            switch result {
            case .success(var response):
                if response.rescode == 1
                {
                    SwiftAlertView.show(title: "Alert", message: response.message, buttonTitles: "OK")
                }
            case .failure(let error):
                SwiftAlertView.show(title: "Alert", message: error.localizedDescription, buttonTitles: "OK")
            }
        }
    }
    
    
    func LoadUserData(){
        isShowingLoader.toggle()
        let parameters: [String:Any] = [
            "plattype": Constants.PLAT_TYPE,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!
        ]
        let ProfileViewModel = ProfileViewModel()
        
        ProfileViewModel.GetProfileBasicInfo(parameters: parameters ) { result in
            isShowingLoader.toggle()
            
            switch result {
            case .success(let response):
                if response.rescode == 1 {
                    userRecord = response.data![0]
                }else{
                    alertService.show(title: "Alert", message: response.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    
    
    
}

struct EditProfileScreenView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileScreenView()
    }
}
