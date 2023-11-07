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
                        TabBarButton(text: "My Complaint", isSelected: selectedTab == 0)
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
        .navigationBarTitleDisplayMode(.inline)
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

//struct ComplaintsScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        ComplaintsScreenView()
//    }
//}



struct ComplaintCustomCardView: View {
    var deletedItemCallback: () -> Void
    var editItemCallback: (ComplaintListDataItem) -> Void
    var commentNavigationCallback: (ComplaintListDataItem) -> Void
    
    @Binding var selectedTab: Int
    @State private var isChatNavigationActive = false
    @State private var isMapNavigationActive = false
    
    @State private var showingDeleteAlert = false
    
    @Binding public var item : ComplaintListDataItem
    
    
    var body: some View {
        
        VStack{
            
            VStack {
                HStack {
                    Text(item.status == 4 ? "Pending" : "Status")
                        .font(.headline)
                        .foregroundColor(Color.blue)
                    Spacer()
                    Text(DateFormatterHelper().formatDateString(item.sdt!)!)
                        .font(.subheadline)
                        .foregroundColor(Color.black)
                }
                
                
                HStack {
                    VStack(alignment: .leading) {
                        HStack{
                            Text("Category:")
                                .font(.system(size: 16))
                                .foregroundColor(Color.black)
                            Text(item.type_name!)
                                .font(.system(size: 16))
                                .foregroundColor(Color.black)
                        }
                        
                        
                        if selectedTab == 1 {
                            VStack(alignment:.leading){
                                
                                if (item.province != nil){
                                    HStack{
                                        Text("Province: ")
                                            .font(.system(size: 18)).bold()
                                            .foregroundColor(Color.black)
                                        Text(item.province!)
                                            .font(.system(size: 18))
                                            .foregroundColor(Color.black)
                                    }
                                }
                                if (item.district != nil){
                                    HStack{
                                        Text("District: ")
                                            .font(.system(size: 18))
                                            .foregroundColor(Color.black).bold()
                                        
                                        Text(item.district!)
                                            .font(.system(size: 18))
                                            .foregroundColor(Color.black)
                                    }
                                }
                            }.padding(0.1)
                        }
                        
//                        if selectedTab == 0 {
//                            Text("External")
//                                .font(.headline)
//                                .foregroundColor(Color.blue)
//                                .padding(.top, 0.5)
//                        }
                        Text(item.details ?? "Description").frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(item.details!.count > 200 ? 1 : 0)
                            .font(.body)
                        
                        if item.details!.count > 200 {
                            Button(action: {}) {
                                Text("See More")
                                    .foregroundColor(Color.blue)
                            }
                        }
                    }
                    
                }
                
                
                HStack() {
                    if selectedTab == 0 {
                        HStack{
                            
                            Button(action: {editItemCallback(item)} ) {
                                Image("edit_black")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                            }
                            
                            
                            Button(action: {showingDeleteAlert.toggle()} ) {
                                Image("delete_black")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                            }
                            
                            Button(action: {commentNavigationCallback(item)} ) {
                                Image("chat")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                            }
                        }
                    }
                    else{
                        Button(action: {
                            // Action to perform when the button is tapped
                            // Add your action here
                        }) {
                            Text("Facing Same Problem?")
                                .foregroundColor(.white)
                            
                        }
                        .frame(width: 200, height: 35) // Set fixed width and height
                        
                        .background(CColors.MainThemeColor) // Set background color to green
                        .cornerRadius(10) // Apply corner radius for rounded edges
                    }
                    
                    Spacer()
                    Button(action: {isMapNavigationActive.toggle()} ) {
                        Image("location_blue")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                }
                
                
            }
            .padding(8)
            .background(CColors.CardBGColor)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 5)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            
            NavigationLink("", destination: GoogleMapView().edgesIgnoringSafeArea(.bottom) , isActive: $isMapNavigationActive)
                .isDetailLink(false)
            
        }.padding(.bottom,-20).padding(.leading,8).padding(.trailing,8)
        
            .alert(isPresented: $showingDeleteAlert) {
                Alert(title: Text("Alert"), message: Text("Are you sure you want to delete?"), primaryButton: .default(Text("Yes")) {
                    DeleteComplaint()
                    print("Button 1 tapped")
                }, secondaryButton: .cancel(Text("No")) {
                    // Action for Button 2
                    print("Button 2 tapped")
                })
            }
        
        
        
    }
    
    func DeleteComplaint(){
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "complaint_id": item.complaint_id!
        ]
        let ViewModel = ComplaintsViewModel()
        ViewModel.DeleteComplaint(parameters: parameters ) { result in
            switch result {
            case .success(let response ):
                deletedItemCallback()
            case .failure(let error):
                print("fail")
                
            }
        }
    }
    
    
}
