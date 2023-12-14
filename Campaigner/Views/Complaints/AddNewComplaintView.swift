//
//  AddNewComplaintView.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/10/2023.
//

import Foundation
import SwiftUI

struct AddNewComplaintView: View {
    @StateObject private var alertService = AlertService()
    
    @State private var selectedCategory = DropDownModel()
    @State private var selectedProvince = DropDownModel()
    @State private var selectedDistrict = DropDownModel()
    @State private var selectedTehsil = DropDownModel()
    @State private var selectedAssembly = DropDownModel()
    @State private var selectedConstituency = DropDownModel()

    @State private var description = ""
    @State private var showActionSheet = false
    @State private var sourceType = 0
    @State private var showImagePicker = false
    @State var selectedImage: UIImage?
    @State private var locationText = ""
    @State private var locationLat = ""
    @State private var locationLng = ""

    @State private var showTeshsil = false
    @State private var showAddress = false
    @State private var showAssembly = false
    @State private var showConstituency = false
    
   @State private var networkOptions: [DropDownModel] = []
    @State private var provinceOptions: [DropDownModel] = []
    @State private var districtOptions: [DropDownModel] = []
    @State private var tehsilOption: [DropDownModel] = []
    @State private var constituencyOption: [DropDownModel] = []
    @State private var isShowingLoader = false
    @State var alertMsg = "Alert"    
    @State private var showSimpleAlert = false
    @State private var canGoBack = false
    @State private var isAddLocationView = false

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State public var isEdit = false
    @State public var item : ComplaintListDataItem?
    @State private var selectedAssemblyType = ""

    @ObservedObject private var sharedLocationData = SharedLocationData()


    var assemblyList: [DropDownModel] = [
        DropDownModel(id: "1", value: "National Assembly"),
        DropDownModel(id: "2", value: "Provincial Assembly"),
        
    ]
    var body: some View {
     
            ZStack {
                BaseView(alertService: alertService)


                VStack{
                    ScrollView{
                    HStack{
                        
                        VStack {
                            DropDown(label: "Category", placeholder: "Select Category", selectedObj:  $selectedCategory, menuOptions: networkOptions )
                            
                            MultilineFormInput(label: "Description", placeholder: "Enter Description", text: $description)
                            
                            HStack(){
                                Spacer()
                                HStack{
                                    Text("File Upload: ")
                                    MainButton(action: {
                                        //
                                        showActionSheet = true
                                        // promptForImageSelection()
                                        
                                    },  label: "Attachment").frame(maxWidth: 180,maxHeight: 50,alignment: .topTrailing).actionSheet(isPresented: $showActionSheet) {
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
                                }
                            }
                            
                            
                            
                            DropDown(label: "Province", placeholder: "Select Province", selectedObj:  $selectedProvince, menuOptions: provinceOptions)
                            
                            districtOptions.count > 0 ?
                            
                            
                            DropDown(label: "District", placeholder: "Select District", selectedObj:  $selectedDistrict, menuOptions: districtOptions )
                            :  nil
                            
                            
                            if showTeshsil {
                                tehsilOption.count > 0 ?
                                DropDown(label: "Tehsil", placeholder: "Select Tehsil", selectedObj:  $selectedTehsil, menuOptions: tehsilOption
                                )
                                : nil
                            }
                            if showAddress {
                                LocationField(label: "Address", placeholder: "Address", text: $sharedLocationData.locationName, buttonAction: {
                                    isAddLocationView = true
                                })
                            }
                            
                            
                            if showAssembly {
                                DropDown(label: "Assembly", placeholder: "Select Assembly", selectedObj: $selectedAssembly, menuOptions: assemblyList)
                                    .onChange(of: selectedAssembly) { newValue in
                                        if let index = assemblyList.firstIndex(where: { $0.id == selectedAssembly.id }) {
                                            
                                            selectedAssemblyType = index == 0 ? "1" : "2"
                                        }
                                    }
                            }
                            if showConstituency {
                                DropDown(label: "Constituency", placeholder: "Select Constituency", selectedObj: $selectedConstituency, menuOptions: constituencyOption)
                                
                            }
                            
                            
                            MainButton(action: SubmitAction, label: isEdit ? "Update" : "Submit").padding(.top,20)
                            
                            
                        }.frame(width: .infinity, height: .infinity).padding(10)
                        
                    }.background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    )
                }
                }
                    
                NavigationLink(destination: AddLocationView(sharedLocationData: sharedLocationData), isActive: $isAddLocationView) {
                    }
                    .navigationBarHidden(true)
            
                if isShowingLoader {
                    Loader(isShowing: $isShowingLoader)
                        .edgesIgnoringSafeArea(.all)
                }
                
            }.onAppear{
                if(isEdit){
                    selectedCategory = DropDownModel(id: (item?.type_id)!, value: (item?.type_name)!)
                    description = (item?.details)!
                    if item?.province_id != nil{
                        selectedProvince = DropDownModel(id: (item?.province_id)!, value: (item?.province)!)
                    }
                    if item?.district_id != nil{
                        selectedDistrict = DropDownModel(id: (item?.district_id)!, value: (item?.district)!)
                    }

                }
            }
            .alert(isPresented: $showSimpleAlert) {
                Alert(
                    title: Text("Alert"),
                    message: Text(alertMsg),
                    dismissButton: .default(Text("Ok")) {
                        // Optional completion block
                        if canGoBack {
                            DispatchQueue.main.asyncAfter(deadline: .now()) {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                        
                    }
                )
            }
            .onChange(of: selectedProvince) { newValue in
                districtOptions.removeAll()
                GetDistricts()
                selectedDistrict = DropDownModel()
                selectedTehsil = DropDownModel()
                selectedAssembly = DropDownModel()
                selectedConstituency = DropDownModel()
                showTeshsil = false
                showAddress = false
                showAssembly = false
                showConstituency = false
           
            }
            .onChange(of: sharedLocationData.longitude) { newValue in
                print("sharedLocationData", sharedLocationData.locationName)
            }
            .onChange(of: selectedDistrict) { newValue in
                tehsilOption.removeAll()
                GetTehsil()
                showTeshsil = true
                showAddress = true
                showAssembly = true
                selectedTehsil = DropDownModel()
                selectedAssembly = DropDownModel()
                selectedConstituency = DropDownModel()
            }
            .onChange(of: selectedAssemblyType) { newValue in
                
                showConstituency = true
                GetConstituency()
            }

            .onAppear{
                GetComplaintsTypes()
                GetProvinces()
                
            }
            .padding(10)
            .sheet(isPresented: $showImagePicker)
            {
                ImageUploader(selectedImage: $selectedImage, sourceTypeNo: sourceType)
            }
            
            
            
            
        
            .navigationBarHidden(false)
            .navigationTitle("Post a Complain")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    
    func SubmitAction(){
        print(selectedCategory.value.count)
        if selectedCategory.value.count == 0 {
            alertMsg = "Category is required."
            showSimpleAlert = true
//            alertService.show(title: "Alert", message: "Category is required.")
        }
        else if description == "" {
            alertMsg = "Description is required.."
            showSimpleAlert = true

//            alertService.show(title: "Alert", message: "Description is required.")
        }
        else{
            isEdit ? UpdateComplaint() : AddComplaint()
        }
    }
    
    
    func GetComplaintsTypes(){
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            
        ]
        let ViewModel = ComplaintsViewModel()
        ViewModel.GetComplaintsType(parameters: parameters ) { result in
            switch result {
            case .success(let response ):
                
                if response.rescode == 1 {
                    let newOptions = response.data.map { data in
                        DropDownModel(id: (data?.type_id!)!, value: (data?.type_name!)!)
                    }
                    networkOptions.append(contentsOf: newOptions)
                    
                }else{
                    alertService.show(title: "Alert", message: response.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    func GetProvinces(){
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
        ]
        
        let ViewModel = LookupsViewModel()
        ViewModel.ListProvinces(parameters: parameters ) { result in
            switch result {
            case .success(let response ):
                
                if response.rescode == 1 {
                    
                    let newOptions = response.data?.map { data in
                        DropDownModel(id: (data.province_id!), value: (data.province!))
                    }
                    provinceOptions.append(contentsOf: newOptions!)
                    
                }else{
                    alertService.show(title: "Alert", message: response.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    func GetDistricts(){
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "province_id" : selectedProvince.id
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
                    
                }else{
                    alertService.show(title: "Alert", message: response.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    func GetTehsil(){
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "district_id" : selectedDistrict.id
        ]
        
        let ViewModel = LookupsViewModel()
        ViewModel.ListTehsils(parameters: parameters ) { result in
            switch result {
            case .success(let response ):
                
                if response.rescode == 1 {
                    
                    let newOptions = response.data?.map { data in
                        DropDownModel(id: (data.tehsil_id!), value: (data.tehsil_name!))
                    }
                    tehsilOption.append(contentsOf: newOptions!)
                    
                }else{
                    alertService.show(title: "Alert", message: response.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
  
    func GetConstituency(){
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "assembly": selectedAssemblyType,
            "district_id" : selectedDistrict.id
        ]
        
        let ViewModel = LookupsViewModel()
        ViewModel.ListConstituency(parameters: parameters ) { result in
            switch result {
            case .success(let response ):
                
                if response.rescode == 1 {
                    print(response)
                    let newOptions = response.data?.map { data in
                        DropDownModel(id: (data.id_text!), value: (data.constituency!))
                    }
                    constituencyOption.append(contentsOf: newOptions!)
                    
                }else{
                    alertService.show(title: "Alert", message: response.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    func AddComplaint(){
        
        isShowingLoader.toggle()
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "complaint_type": selectedCategory.id,
            "complaint_desc": description,
            "is_internal": "0",
            "loc_lat": sharedLocationData.latitude,
            "loc_lng": sharedLocationData.longitude,
            "loc_text":sharedLocationData.locationName,
            "file": "",
            "province_id": selectedProvince.id,
            "district_id": selectedDistrict.id,
            "poll_station_id": ""

            
        ]
        let ViewModel = ComplaintsViewModel()
        ViewModel.AddComplaint(parameters: parameters ) { result in
            isShowingLoader.toggle()

            switch result {
            case .success(let response ):
                
                if response.rescode == 1 {
                    alertMsg = response.message!
                    canGoBack = true
                    showSimpleAlert = true
                    
                }
                else{
                    alertMsg = response.message!
                    canGoBack = false
                    showSimpleAlert = true
                }

                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    func UpdateComplaint(){
        
        isShowingLoader.toggle()
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "complaint_id": item!.complaint_id!,
            "complaint_type": selectedCategory.id,
            "complaint_desc": description,
            "is_internal": "0",
            "loc_lat": "",
            "loc_lng": "",
            "loc_text": "",
            "file": "",
            "province_id": selectedProvince.id,
            "district_id": selectedDistrict.id,
            "poll_station_id": ""
 
        ]
        let ViewModel = ComplaintsViewModel()
        ViewModel.UpdateComplaint(parameters: parameters ) { result in
            isShowingLoader.toggle()

            switch result {
            case .success(let response ):
                
                if response.rescode == 1 {
                    alertMsg = response.message!
                    canGoBack = true
                    showSimpleAlert = true
                    
                }
                else{
                    alertMsg = response.message!
                    canGoBack = false
                    showSimpleAlert = true
                }

                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    func didUpdateLocation(latitude: Double, longitude: Double, locationName: String) {
           print("Received location data: Latitude \(latitude), Longitude \(longitude), Name: \(locationName)")
       }
    
}

struct AddNewComplaintView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewComplaintView()
    }
}
