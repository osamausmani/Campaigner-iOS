//
//  ComplaintCustomCardView.swift
//  Campaigner
//
//  Created by Macbook  on 08/11/2023.
//

import SwiftUI


struct ComplaintCustomCardView: View {

    var deletedItemCallback: () -> Void
    var editItemCallback: (ComplaintListDataItem) -> Void
    var commentNavigationCallback: (ComplaintListDataItem) -> Void
    @StateObject private var alertService = AlertService()
    @Binding var selectedTab: Int
    @State private var isChatNavigationActive = false
    @State private var isMapNavigationActive = false
    
    @State private var showingDeleteAlert = false
    
    @Binding public var item : ComplaintListDataItem
    @State private var itemLat : Double = 0.0
    @State private var itemLng : Double = 0.0

    @State private var isProvinceNavigationActive = false
    @State private var isDistrictNavigationActive = false
    @State private var isTehsilNavigationActive = false
    @State private var navigationTitle = "Complaints"
    @State private var id=""
    
    var body: some View {
        ZStack{
            BaseView(alertService: alertService)
        VStack{
       
            VStack(spacing: 0) {
                HStack{
                    if item.province?.isEmpty==false{
                        VStack(alignment: .leading){
                            Text("Province")
                                .font(.headline)
                                .foregroundColor(Color.black)
                            Button(action: {
                                
                                navigationTitle = "Province Complaints"
                                isProvinceNavigationActive = true
                                id=item.province_id ?? ""
                            }){
                                Text(item.province ?? "")
                                    .font(.headline)
                                    .foregroundColor(Color.blue)
                            }
                        }
                    }
                    Spacer()
                    if item.district?.isEmpty==false{
                        VStack(alignment: .leading){
                            
                            Text("District")
                                .font(.headline)
                                .foregroundColor(Color.black)
                            Button(action: {
                                navigationTitle = "District Complaints"
                                isDistrictNavigationActive = true
                                id=item.district_id ?? ""
                            })
                            {
                                Text(item.district ?? "")
                                    .font(.headline)
                                    .foregroundColor(Color.blue)
                            }
                            
                        }
                    }
                    Spacer()
                    if item.tehsil?.isEmpty==false{
                        VStack(alignment: .leading){
                            Text("Tehsil")
                                .font(.headline)
                                .foregroundColor(Color.black)
                            Button(action: {
                                navigationTitle = "Tehsil Complaints"
                                isTehsilNavigationActive = true
                                id=item.tehsil_id ?? ""
                            }){
                                Text(item.tehsil ?? "")
                                    .font(.headline)
                                    .foregroundColor(Color.blue)
                            }
                        }
                    }
              
//                    Spacer()
                    
                }
                .background(NavigationLink("", destination: PublicComplaintsView(title: navigationTitle, id: id), isActive: $isProvinceNavigationActive))
                .background(NavigationLink("", destination: PublicComplaintsView(title: navigationTitle, id: id), isActive: $isDistrictNavigationActive).isDetailLink(false))
                .background(NavigationLink("", destination: PublicComplaintsView(title: navigationTitle, id: id), isActive: $isTehsilNavigationActive).isDetailLink(false))
                dividerline()
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
                        
                        
//                        if selectedTab == 1 {
//                            VStack(alignment:.leading){
////
////                                if (item.province != nil){
////                                    HStack{
////                                        Text("Province: ")
////                                            .font(.system(size: 18)).bold()
////                                            .foregroundColor(Color.black)
////                                        Text(item.province!)
////                                            .font(.system(size: 18))
////                                            .foregroundColor(Color.black)
////                                    }
////                                }
////                                if (item.district != nil){
////                                    HStack{
////                                        Text("District: ")
////                                            .font(.system(size: 18))
////                                            .foregroundColor(Color.black).bold()
////                                        
////                                        Text(item.district!)
////                                            .font(.system(size: 18))
////                                            .foregroundColor(Color.black)
////                                    }
////                                }
//                            }.padding(0.1)
//                        }
//                        
//                        if selectedTab == 0 {
//                            Text("External")
//                                .font(.headline)
//                                .foregroundColor(Color.blue)
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
                            
                            joinComplaint()
                            
                            
                        }) {
                            Text("Join the complaint?")
                                .foregroundColor(.white)
                            
                        }
                        .frame(width: 200, height: 35) // Set fixed width and height
                        
                        .background(CColors.MainThemeColor) // Set background color to green
                        .cornerRadius(10) // Apply corner radius for rounded edges
                    }
                    
                    Spacer()
                    Button(action: {
                        isMapNavigationActive.toggle()
                        
                    } ) {
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
            
            NavigationLink("", destination: GoogleMapView(latitude: $itemLat, longitude: $itemLng).edgesIgnoringSafeArea(.bottom) , isActive: $isMapNavigationActive)
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
        }.onAppear{
            print("Button 1 tapped")
            print(itemLat, itemLng )

            itemLat = Double(item.loc_lat ?? "0.0")!
            itemLng = Double(item.loc_lng ?? "0.0")!

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
    func joinComplaint(){
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "complaint_id":item.complaint_id!
        ]
        let ViewModel = ComplaintsViewModel()
        ViewModel.AddEndorseComplaint(parameters: parameters ) { result in
            switch result {
            case .success(let response ):
                if response.rescode == 1 {
                    alertService.show(title: "Alert", message: response.message!)
                }else{
                    alertService.show(title: "Alert", message: response.message!)
                }
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    
}
