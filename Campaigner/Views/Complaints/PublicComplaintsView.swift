//
//  PublicComplaintsView.swift
//  Campaigner
//
//  Created by Macbook  on 08/11/2023.
//

import SwiftUI

struct PublicComplaintsView: View {
    var title:String
    var id:String
    @State var complaintsList = [ComplaintListDataItem]()
    @StateObject private var alertService = AlertService()
    @State private var isActive = false
    var body: some View {
        ZStack{
            BaseView(alertService: alertService)
            VStack(spacing: 0){

                
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
                                
                                PublicComplaintCustomCardView(
                                item:$complaintsList[index])
                                .padding([.leading,.trailing],10)
                                
                                
                            }
                        }
                    }
            }
            .background(complaintsList.count == 0 ? CColors.TextInputBgColor : .clear)

          
        }
        .onAppear{
            GetPublicComplaints() 
        }
        .navigationBarHidden(false)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func GetPublicComplaints() {
        var parameters: [String: Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!
        ]
        
        if !id.isEmpty {
            if title == "Province Complaints" {
                parameters["provice_id"] = id
            } else if title == "District Complaints" {
                parameters["district_id"] = id
            } else if title == "Tehsil Complaints" {
                parameters["tehsil_id"] = id
            }
        }
        
        let ViewModel = ComplaintsViewModel()
        ViewModel.GetPublicComplaints(parameters: parameters) { result in
            switch result {
            case .success(let response):
                if response.rescode == 1 {
                    complaintsList.removeAll()
                    complaintsList = response.data ?? []
                } else {
                    complaintsList.removeAll()
                    // alertService.show(title: "Alert", message: response.message!)
                }
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }

}


struct PublicComplaintCustomCardView: View {
    
    
    @StateObject private var alertService = AlertService()
    @State private var isChatNavigationActive = false
    @State private var isMapNavigationActive = false
    
    @State private var showingDeleteAlert = false
    
    @Binding public var item : ComplaintListDataItem
    
    @State private var isProvinceNavigationActive = false
    @State private var isDistrictNavigationActive = false
    @State private var isTehsilNavigationActive = false
    @State private var navigationTitle = "Complaints"
    @State private var id=""
    
    var body: some View {
        ZStack{
            BaseView(alertService: alertService)
            VStack{
                
                VStack {
                    HStack{
                        
                        if item.province?.isEmpty == false{
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
                        Spacer()
                        
                    }
                    .background(NavigationLink("", destination: PublicComplaintsView(title: navigationTitle, id: id), isActive: $isProvinceNavigationActive))
                    .background(NavigationLink("", destination: PublicComplaintsView(title: navigationTitle, id: id), isActive: $isDistrictNavigationActive).isDetailLink(false))
                    .background(NavigationLink("", destination: PublicComplaintsView(title: navigationTitle, id: id), isActive: $isTehsilNavigationActive).isDetailLink(false))
                    Divider()
                    
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
                            
                            
                            
                            
                            Text("External")
                                .font(.headline)
                                .foregroundColor(Color.blue)
                                .padding(.top, 0.5)
                            
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
                        HStack{
                            
                            Spacer()
                            Button(action: {isMapNavigationActive.toggle()} ) {
                                Image("location_blue")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                            }
                        }
                        
                        
                    }
          
                    
                    NavigationLink("", destination: GoogleMapView(latitude: item.loc_lat ?? "", longitude: item.loc_lng ?? "").edgesIgnoringSafeArea(.bottom) , isActive: $isMapNavigationActive)
                        .isDetailLink(false)
                    
                }.padding(.bottom,-20).padding(.leading,8).padding(.trailing,8)
                
            }
            .padding(8)
            .background(CColors.CardBGColor)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 5)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            
            
            
        }
        
        
    }
}
