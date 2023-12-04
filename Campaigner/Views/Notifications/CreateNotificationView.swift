//
//  CreateNotificationView.swift
//  Campaigner
//
//  Created by Macbook  on 27/11/2023.
//

import SwiftUI

struct SelectedCriteria {
    var criteria: DropDownModel
    var value: DropDownModel
    var valu2:DropDownModel?
}

struct CreateNotificationView: View {
    @State private var selectedCriteriaList: [SelectedCriteria] = []
    @State private var isOverlayVisible = false
    @State private var selectedTabIndex: Int = 0
    @State private var subject=""
    @State private var url=""
    @State private var details=""
    @State private var time: Date = Date()
    @State private var date: Date = Date()
    @State private var showActionSheet = false
    @State private var showImagePicker = false
    @State private var sourceType = 0
    @State private var selectedCriteria = DropDownModel()
    @State private var selectedMemberType = DropDownModel()
    @State private var selectedDistrict = DropDownModel()
    @State private var selectedTehsil = DropDownModel()
    @State private var selectedGender = DropDownModel()
    @State private var pollingList = [PollingStations]()
    @State private var showDatePickerSheet = false
    @State private var showTimePickerSheet = false
    @State var selectedImage: UIImage?
    @State private var showSimpleAlert = false
    @State var alertMsg = "Alert"
    @State private var isShowingLoader = false
    @StateObject private var alertService = AlertService()
    @State var isShowCriteriaView = false
    @State var  audienceCountInput = 00
    @State private var audienceMmebers = 0
    @State private var notifyID=""
    @State private var isSowNotificatioView=false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let CriteriaList = [
        DropDownModel(id: "0", value: "Member Type"),
        DropDownModel(id: "1", value: "Area"),
        DropDownModel(id: "2", value: "Gender")
    ]
    let MemberTypeList = [
        DropDownModel(id: "1", value: "Active"),
        DropDownModel(id: "2", value: "Suspended"),
        DropDownModel(id: "3", value: "All")
    ]
    @State var DistrictList = [DropDownModel]()
    @State var TehsilList  = [DropDownModel]()
    let GenderList = [
        DropDownModel(id: "1", value: "Male"),
        DropDownModel(id: "2", value: "Female"),
        DropDownModel(id: "3", value: "All")
    ]
    
    @State private var isNavBarLinkActive = false
    var body: some View {
        ZStack{
            BaseView(alertService: alertService)
            VStack{
                //                Spacer()
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        
                        Image("back_arrow")
                            .resizable()
                            .frame(width: 24, height: 24).tint(CColors.MainThemeColor)
                        Spacer()
                        Text("Create Promotion").tint(CColors.MainThemeColor).font(.system(size: 18))
                        Spacer()
                        
                        
                        
                    }
                    
                }
                .foregroundColor(.black)
                .padding()
                dividerline()
                TabBarView(selectedTab: $selectedTabIndex, tabNames: ["Basic Information", "Audience"])
                
                
                if selectedTabIndex==0{
                    VStack(alignment: .leading,spacing: 10 ){
                        
                        
                        FormInputField(label: "Subject", placeholder: "Type here", isMandatory: true, text: $subject)
                            .padding(.horizontal,20)
                            .padding(.top,30)
                        FormInputField(label: "URL", placeholder: "Type here", text: $url)
                            .padding(.horizontal,20)
                        MultilineInputMandatory(label: "Detail", placeholder: "Type details", text: $details)
                            .padding(.horizontal,20)
                        
                        ScheduleView(label: "Schedule", isMandatory: true, showDatePicker: {
                            self.showDatePickerSheet = true
                        }, showTimePicker: { self.showTimePickerSheet = true
                        }, selectedDate: $date, selectedTime: $time)
                        
                        .padding(.leading,20)
                        
                        
                        
                        HStack(alignment: .top,spacing: 0){
                            //
                            CustomButton(text: "Attachment", image: "paperclip", action: {
                                self.showActionSheet = true
                            })
                            .padding(.leading,20)
                            //
                            .actionSheet(isPresented: $showActionSheet) {
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
                        
                        dividerline()
                        
                        MainButton(action: next, label: "Next")
                            .padding(.horizontal,100)
                            .padding(.bottom,20)
                        
                        //                        Spacer()
                        
                        
                        
                    }
                    
                    .background(Color.white)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                    .sheet(isPresented: $showDatePickerSheet) {
                        DatePicker("Select Date", selection: $date, displayedComponents: [.date])
                        
                            .datePickerStyle(WheelDatePickerStyle())
                            .background(Color.white)
                            .cornerRadius(15)
                    }
                    
                    
                    
                    .sheet(isPresented: $showTimePickerSheet) {
                        DatePicker("Select Time", selection: $time, displayedComponents: [.hourAndMinute])
                            .datePickerStyle(WheelDatePickerStyle())
                            .background(Color.white)
                            .cornerRadius(15)
                    }
                    .sheet(isPresented: $showImagePicker)
                    {
                        ImageUploader(selectedImage: $selectedImage, sourceTypeNo: sourceType)
                    }
                    .alert(isPresented: $showSimpleAlert) {
                        Alert(
                            title: Text("Alert"),
                            message: Text(alertMsg),
                            dismissButton: .default(Text("Ok")) {
                                
                                showSimpleAlert = false
                            }
                        )
                    }
                    
                    .navigationBarHidden(true)
                    Spacer()
                    
                }
                
                else {
                    VStack{
                        DropDownMandatory(label: "Select Criteria", placeholder: "Select Critera", selectedObj: $selectedCriteria, menuOptions: filteredCriteriaList)
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                        
                        
                        if selectedCriteria.id=="0"{
                            DropDownMandatory(label: "Member Type", placeholder: "Select Member Type", selectedObj: $selectedMemberType, menuOptions: MemberTypeList)
                                .padding(.horizontal,20)
                            
                            if selectedMemberType.id>="0"{
                                
                                MainButton(action: addaudience, label: "Add Audience",customHeight:15)
                                    .padding(.horizontal,20)
                                
                                    .padding(.bottom,20)
                                
                                
                            }
                            
                            
                            
                            
                        }
                        
                        
                        else  if selectedCriteria.id=="1"{
                            DropDownMandatory(label: "District", placeholder: "Select District", selectedObj: $selectedDistrict, menuOptions: DistrictList)
                                .padding(.horizontal,20)
                            
                            if selectedDistrict.id>="0"{
                                DropDownMandatory(label: "Tehsil", placeholder: "Select Tehsil", selectedObj: $selectedTehsil, menuOptions: TehsilList)
                                    .padding(.horizontal,20)
                                
                                if selectedTehsil.id>="0"
                                {
                                    MainButton(action: addaudience, label: "Add Audience",customHeight:15)
                                        .padding(.horizontal,20)
                                        .padding(.bottom,20)
                                    
                                }
                            }
                            
                        }
                        
                        
                        else if selectedCriteria.id=="2"{
                            DropDownMandatory(label: "Gender", placeholder: "Select Gender", selectedObj: $selectedGender, menuOptions: GenderList)
                                .padding(.horizontal,20)
                                .padding(.bottom,10)
                            if selectedGender.id>="0"{
                                MainButton(action: addaudience, label: "Add Audience",customHeight:15)
                                    .padding(.horizontal,20)
                                    .padding(.bottom,20)
                                
                                
                            }
                            
                        }
                        
                        
                    }
                    .background(Color.white)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .frame(width: .infinity, height:.infinity, alignment:.top)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                    
                    if isShowCriteriaView {
                        CriteriaTableView(heading: "Criteria Detail", data: selectedCriteriaList.map { [$0.criteria.value, "\($0.value.value + " "+($0.value.value2 ?? ""))"] }) {
                            isShowCriteriaView = false
                            selectedCriteriaList.removeAll()
                        }
                        Spacer()
                        VStack{
                            Spacer()
                            MainButton(action: {
                                getAudienceCount()
                                isOverlayVisible = true
                                
                                
                            }, label: "Save")
                            .padding(.horizontal,20)
                            .padding(.bottom,20)
                            
                            
                        }
                        
                    }
                }
                Spacer()
                
                
                
            }
            .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 2)
            .navigationBarHidden(true)
            
            
            NavigationLink(
                destination: NotificationScreenView(),
                isActive: $isSowNotificatioView,
                label: {
                    EmptyView()
                }
            )
            .hidden()
            
        }
        .overlay{
            VStack{
                if isOverlayVisible {
                    
                    AudienceView(
                        title: "Notification",
                        totalAudienceMember: "\(audienceMmebers)",
                        crossButtonAction: {
                            isOverlayVisible = false
                        },
                        audienceCount: $audienceCountInput,
                        Submit: {
                            if audienceCountInput <= audienceMmebers{
                                AddAudience()
                            }
                            else{
                                alertMsg = "You can send notification less than audience member \(audienceMmebers)"
                                alertService.show(title: "Alert", message: alertMsg)
                            }
                        }
                    )
                    .background(Color.black.opacity(0.5))
                    .edgesIgnoringSafeArea(.all)
                }
            }
        }
        
        
        
        .onChange(of: selectedCriteria) { newValue in
            print(selectedMemberType.id)
            if selectedCriteria.id == "1" {
                GetDistrict()
            }
            
        }
        .onChange(of: selectedDistrict) {newValue in
            print(newValue.id)
            GetTehsil(districtID:newValue.id)
        }
        
        
    }
    var filteredCriteriaList: [DropDownModel] {
        return CriteriaList.filter { criteria in
            !selectedCriteriaList.contains { $0.criteria.id == criteria.id }
        }
    }
    
    func GetDistrict(){
        let parameters: [String:Any] = [
            "":""
        ]
        let ViewModel = LookupsViewModel()
        ViewModel.ListDistricts(parameters: parameters ) { result in
            switch result {
            case .success(let response ):
                let newOptions = response.data?.map { data in
                    DropDownModel(id: (data.district_id!), value: (data.district_name!))
                }
                DistrictList.removeAll()
                DistrictList.append(contentsOf: newOptions!)
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    func GetTehsil(districtID:String){
        print("District id:",districtID)
        let parameters: [String:Any] = [
            "plattype":Global.PlatType,
            "district_id":districtID
        ]
        let ViewModel = LookupsViewModel()
        ViewModel.ListTehsils(parameters: parameters ) { result in
            switch result {
            case .success(let response ):
                let newOptions = response.data?.map { data in
                    DropDownModel(id: (data.tehsil_id!), value: (data.tehsil_name!),value2: (data.tehsil_name!))
                }
                TehsilList.removeAll()
                TehsilList.append(contentsOf: newOptions!)
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    func addaudience() {
        var selectedValue = DropDownModel()
        
        switch selectedCriteria.id {
        case "0":
            selectedValue = selectedMemberType
        case "1":
            selectedValue = selectedTehsil
            print(selectedTehsil.id)
        case "2":
            selectedValue = selectedGender
        default:
            break
        }
        
        // Append the selected criteria and value to the list
        selectedCriteriaList.append(SelectedCriteria(criteria: selectedCriteria, value: selectedValue))
        
        // Reset the selected criteria for the next entry
        selectedCriteria = DropDownModel()
        
        // Show the table view
        isShowCriteriaView = true
    }
    
    
    func next() {
        if selectedTabIndex < 1 {
            if subject.isEmpty {
                alertMsg = "Subject is Required"
                showSimpleAlert = true
            } else if details.isEmpty {
                alertMsg = "Detail is Required"
                showSimpleAlert = true
            } else {
                AddNotification()
            }
        } else {
            
        }
    }
    func AddNotification() {
        isShowingLoader.toggle()
        
        // Format date and time
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        let formattedTime = timeFormatter.string(from: time)
        
        let dateTimeString = "\(formattedDate) \(formattedTime)"
        let parameters: [String: Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "notify_title": subject,
            "notify_desc": details,
            "notify_type": 2,
            "notify_url": url,
            "notify_dtm": dateTimeString,
            "election_id":Global.electionID,
            "file":selectedImage ?? ""
        ]
        print(Global.electionID)
        
        let ViewModel = NotificationViewModel()
        ViewModel.AddNotification(parameters: parameters) { result in
            isShowingLoader.toggle()
            
            switch result {
            case .success(let response):
                if response.rescode == 1 {
                    alertMsg = response.message!
                    notifyID=response.data ?? ""
                    selectedTabIndex+=1
                } else {
                    alertMsg = response.message!
                }
                
            case .failure(let error):
                alertMsg = error.localizedDescription
            }
            
            // Show the alert here
            showSimpleAlert = true
        }    }
    func getPollingStations(){
        let parameters: [String:Any] = [
            "platype":Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!
        ]
        let ViewModel = LookupsViewModel()
        ViewModel.ListPollingStation(parameters: parameters ) { result in
            switch result {
            case .success(let response ):
                pollingList.removeAll()
                pollingList.append(contentsOf: response.data!)
                print(pollingList)
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    func getAudienceCount(){
        print(UserDefaults.standard.string(forKey: Constants.USER_ID)!)
        print(Global.PlatType)
        print(selectedMemberType.value)
        print(selectedDistrict.id)
        print(selectedTehsil.id)
        print(selectedGender.value)
        let parameters: [String:Any] = [
            "plattype":Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "member_type":selectedMemberType.value,
            "district_id":selectedDistrict.id,
            "town_id":selectedTehsil.id,
            "user_gender":selectedGender.value,
            "poll_ids":"",
            "group_ids":""
        ]
        let ViewModel = NotificationViewModel()
        ViewModel.AudienceCount(parameters: parameters ) { result in
            switch result {
            case .success(let response ):
                audienceMmebers=response.data?[0].totalCount ?? 0
                print(response.data!)
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    func AddAudience() {
        isShowingLoader.toggle()
        print(UserDefaults.standard.string(forKey: Constants.USER_ID)!)
        let parameters: [String:Any] = [
            
            "plattype":Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "notify_id":notifyID,
            "member_type":selectedMemberType.value,
            "district_id":selectedDistrict.id,
            "town_id":selectedTehsil.id,
            "user_gender":selectedGender.value,
            "poll_ids":"0",
            "audience_count":audienceMmebers,
            "select_count":audienceCountInput,
            "group_ids":"0"
        ]
        
        let ViewModel = NotificationViewModel()
        ViewModel.AddAudience(parameters: parameters) { result in
            isShowingLoader.toggle()
            
            switch result {
            case .success(let response):
                if response.rescode == 1 {
                    alertMsg = response.message!
                    isSowNotificatioView=true
                    
                } else {
                    alertMsg = response.message!
                    
                }
                
            case .failure(let error):
                alertMsg = error.localizedDescription
            }
            
            // Show the alert here
            showSimpleAlert = true
        }    }
    
}



//#Preview {
//CreateNotificationView()
//}
