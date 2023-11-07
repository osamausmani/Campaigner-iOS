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

    @State private var description = ""
    @State private var showActionSheet = false
    @State private var sourceType = 0
    @State private var showImagePicker = false
    @State var selectedImage: UIImage?
    
    
    
   @State private var networkOptions: [DropDownModel] = []
    @State private var provinceOptions: [DropDownModel] = []
    @State private var districtOptions: [DropDownModel] = []

    @State private var isShowingLoader = false
    @State var alertMsg = "Alert"    
    @State private var showSimpleAlert = false
    @State private var canGoBack = false

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State public var isEdit = false
    @State public var item : ComplaintListDataItem?

    
    var body: some View {
        NavigationView {
            
            ZStack {
                
                BaseView(alertService: alertService)

                VStack{
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
                            
                            
                            MainButton(action: SubmitAction, label: isEdit ? "Update" : "Submit").padding(.top,20)
                            
                            
                        }.frame(width: .infinity, height: .infinity).padding(10)
                        
                    }.background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    )
                    Spacer()
                }
                
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
            
            
            
            
        }
        .navigationBarHidden(false)
        .navigationTitle("Post a Complaint")
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
    
    func AddComplaint(){
        
        isShowingLoader.toggle()
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
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
    
    
}

struct AddNewComplaintView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewComplaintView()
    }
}
