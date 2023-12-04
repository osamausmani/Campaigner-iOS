//
//  ComplaintsScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 06/06/2023.
//

import SwiftUI

struct ComplaintsScreenView: View {
    
    
    @State private var selectedTab = 0
    @State public var cTitle = DropDownModel()
    @State private var cDescription = DropDownModel()
    @State public var cProvince = DropDownModel()
    @State public var cDistrict = DropDownModel()
    @State public var cPolling = DropDownModel()
    
    @State public var provinceName : [DropDownModel] = []
    @State public var districtName : [DropDownModel] = []
    @State public var pollingStation : [DropDownModel] = []
    
    @State public var Title : [DropDownModel] = []
    @State public var Description : [DropDownModel] = []
    
    @State private var isHidden = false
    
    @StateObject private var alertService = AlertService()
    @State private var selectedOption: String = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var isToggled = false
    
    @State private var addNewComplaintScreenViewActive = false
    @State private var isEditNavigationActive = false
    @State private var isCommentsScreenViewActive = false
    
    
    @State var complaintsList = [ComplaintListDataItem]()
    @State var selectedItem : ComplaintListDataItem?
    
   
    
    
    var body: some View {
        
        ZStack {
            BaseView(alertService: alertService)
            NavigationLink(destination: AddNewComplaintView(), isActive: $addNewComplaintScreenViewActive) {
            }
            
            NavigationLink(destination: ComplaintCommentScreenView(selectedItemID: selectedItem?.complaint_id), isActive: $isCommentsScreenViewActive) {
            }
            NavigationLink("", destination: AddNewComplaintView(isEdit:true, item: selectedItem).edgesIgnoringSafeArea(.bottom) , isActive: $isEditNavigationActive)
                .isDetailLink(false)
            
            ZStack{
                VStack {
                    HStack(spacing: 0) {
                        TabBarButton(text: "Own", isSelected: selectedTab == 0)
                        {
                            selectedTab = 0
                            GetOwnedComplaints()
                        }
                        TabBarButton(text: "Public", isSelected: selectedTab == 1) {
                            selectedTab = 1
                            GetPublicComplaints()
                        }
                    }
                    Spacer()
                    
                    
                    VStack{
                        if complaintsList.count == 0 {
                            ZStack{
                                VStack{
                                    Spacer()
                                    NoRecordView(recordMsg: "If you are facing any issues in your area, we encourage you to file a complaint with the relevent authority.")
                                    Spacer()
                                    
                                }
                            }.frame(maxWidth: .infinity, maxHeight:.infinity)
                        }
                        else{
                            ScrollView{
                                ForEach(complaintsList.indices, id: \.self) { index in
                                    
                                    ComplaintCustomCardView(deletedItemCallback:{
                                        GetOwnedComplaints()
                                        alertService.show(title: "Alert", message: "Deleted")
                                    }, editItemCallback:  { item in
                                        selectedItem = item
                                        isEditNavigationActive.toggle()
                                    },
                                                            commentNavigationCallback: { item in
                                        selectedItem = item
                                        isCommentsScreenViewActive.toggle()
                                    }, selectedTab: $selectedTab, item:$complaintsList[index])
                                }
                            }
                        }
                        if selectedTab == 0 {
                            AddButton(action: {addNewComplaintScreenViewActive.toggle()}, label:  "Add")
                        }
                    }.background(complaintsList.count == 0 ? CColors.TextInputBgColor : .clear)
                }
            }
        }.onAppear{
            selectedTab == 1 ? GetPublicComplaints() : GetOwnedComplaints()
        }
        
        .navigationBarHidden(false)
        .navigationTitle("Complaints")
    }
    
    
    func GetOwnedComplaints(){
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
        ]
        let ViewModel = ComplaintsViewModel()
        ViewModel.GetOwnedComplaints(parameters: parameters ) { result in
            switch result {
            case .success(let response ):
                if response.rescode == 1 {
                    complaintsList.removeAll()
                    complaintsList = response.data ?? []
                    print(complaintsList[0].details)
                }else{
                    complaintsList.removeAll()
                    
                    //                    alertService.show(title: "Alert", message: response.message!)
                }
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    func GetPublicComplaints(){
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
        ]
        let ViewModel = ComplaintsViewModel()
        ViewModel.GetPublicComplaints(parameters: parameters ) { result in
            switch result {
            case .success(let response ):
                if response.rescode == 1 {
                    complaintsList.removeAll()
                    complaintsList = response.data ?? []
                }else{
                    complaintsList.removeAll()
                    
                    //                    alertService.show(title: "Alert", message: response.message!)
                }
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
}


