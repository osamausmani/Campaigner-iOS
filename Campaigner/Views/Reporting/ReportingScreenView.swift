//
//  ReportingScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 13/06/2023.
//

import SwiftUI
import Alamofire


struct ReportingScreenView: View {
    @State private var selectedReport: Reporting?
    
    
    @State private var selectedTab = 0
    @State var showingAddReportingView = false
    @State private var isLoading = false
    @State private var showSearchBar = false
    @State private var searchText = ""
    @State private var isUpdateView = false
    @State var reportingType = [Reporting]()
    @State var finalDate = ""
    @State var reportID=""
    @State var description=""
    @State var reportType=""
    @StateObject private var alertService = AlertService()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isComplaint = 0
    @State var showingDeleteAlert=false
    var body: some View {
        
        
        ZStack {
            BaseView(alertService: alertService)
            
            
            //                    Image("splash_background")
            //                        .resizable()
            //                        .edgesIgnoringSafeArea(.all)
            
            VStack {
                //
                // Navigation Bar
                
                HStack {
                    Button(action: {
                        // Perform action for burger icon
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left").tint(CColors.MainThemeColor).font(.system(size: 18))
                        Text("Back").tint(CColors.MainThemeColor).font(.system(size: 18))
                        
                    }
                    // Spacer()
                    Text("Reporting")
                        .font(.headline)
                        .frame(width: 250)
                    
                    Spacer()
                    Button(action: {
                        // Perform action for searchbar icon
                        showSearchBar.toggle()
                    }) {
                        Image(systemName: "magnifyingglass")
                            .imageScale(.large)
                    }
                    
                } .foregroundColor(CColors.MainThemeColor)
                    .padding()
                    .navigationBarHidden(true)
                
                Divider()
                
                HStack(spacing: 0)
                {
                    Spacer()
                    
                    TabBarButton(text: "Own", isSelected: selectedTab == 0) {
                        selectedTab = 0
                        // listMembers()
                    }
                    
                    Spacer()
                    
                    TabBarButton(text: "Other(s)", isSelected: selectedTab == 1)
                    {
                        selectedTab = 1
                        // listTeams()
                    }
                    
                    
                    Spacer()
                }.frame(height: 30)
                    .foregroundColor(Color.black)
                VStack{
                    if showSearchBar {
                        SearchBar(text: $searchText).onChange(of: searchText, perform: handleTextChange).frame(alignment: .top)
                    }
                    ZStack {
                        
                        Image("reportingNil")
                            .resizable()
                            .edgesIgnoringSafeArea(.all)
                        if selectedTab == 0 {
                            
                            List {
                                //                                ReportingCell(Status: "Pending", ReportingType: "Minor news", Description: "This is the description", Date: "12/3/1992", Name: "Asad Irfan", mapAction: {}, delete: deleteRecord, update: updateRecord, attachment: showAttachment)
                                if showSearchBar == false {
                                    ForEach(reportingType.indices, id: \.self) { index in
                                        let formattedDate = convertDate(inputDate: reportingType[index].sdt ?? "", inputFormat: "yyyy-MM-dd HH:mm:ss", outputFormat: "dd MMM yyyy")
                                        var statusType = reportingType[index].status ?? 0
                                        
                                        var fin = getStatusString(for: statusType)
                                        
                                        
                                        ReportingCell(Status: fin,
                                                      ReportingType: reportingType[index].type_name ?? "",
                                                      Description: reportingType[index].details ?? "",
                                                      Date: formattedDate ?? "",
                                                      Name: reportingType[index].added_by?.user_full_name ?? "") {
                                            // Action closure
                                        } delete: {
                                            reportID=reportingType[index].report_id ?? ""
                                            showingDeleteAlert=true
                                        } update: {
                                            if selectedTab == 0 {
                                                isUpdateView = true
                                                
                                                isComplaint = 0
                                                reportID=reportingType[index].report_id ?? ""
                                                reportType=reportingType[index].type_name ?? ""
                                                description=reportingType[index].details ?? ""
                                                
                                            } else {
                                                isUpdateView = true
                                                isComplaint = 1
                                                reportID=reportingType[index].report_id ?? ""
                                                reportType=reportingType[index].type_name ?? ""
                                                description=reportingType[index].details ?? ""
                                            }
                                        } attachment: {
                                            // Action closure
                                        }
                                    }
                                } else {
                                    ForEach(reportingType.indices, id: \.self) { index in
                                        if searchText.isEmpty || reportingType[index].type_name?.contains(searchText) ?? false {
                                            let formattedDate = convertDate(inputDate: reportingType[index].sdt ?? "", inputFormat: "yyyy-MM-dd HH:mm:ss", outputFormat: "dd MMM yyyy")
                                            
                                            var statusType = reportingType[index].status ?? 0
                                            
                                            var fin = getStatusString(for: statusType)
                                            
                                            ReportingCell(Status: fin,
                                                          ReportingType: reportingType[index].type_name ?? "",
                                                          Description: reportingType[index].details ?? "",
                                                          Date: formattedDate ?? "",
                                                          Name: reportingType[index].added_by?.user_full_name ?? "") {
                                                // Action closure
                                                //  addRecord()
                                            } delete: {
                                                reportID=reportingType[index].report_id ?? ""
                                                showingDeleteAlert=true
                                            } update: {
                                                if selectedTab == 0 {
                                                    isUpdateView = true
                                                    isComplaint=0
                                                    reportID=reportingType[index].report_id ?? ""
                                                    reportType=reportingType[index].type_name ?? ""
                                                    description=reportingType[index].details ?? ""
                                                    
                                                } else {
                                                    isUpdateView = true
                                                    isComplaint=1
                                                    reportID=reportingType[index].report_id ?? ""
                                                    reportType=reportingType[index].type_name ?? ""
                                                    description=reportingType[index].details ?? ""
                                                }
                                            } attachment: {
                                                // Action closure
                                            }
                                            
                                        }
                                    }
                                }
                            }
                            VStack{
                                Spacer()
                                AddButton(action: fin, label: "")
                                    .fullScreenCover(isPresented: $showingAddReportingView) {
                                        AddReportScreenView(onDismiss: {
                                            ListReport()
                                        })
                                    }                                }
                        }
                        else{
                            
                        }
                        
                        
                        
                        
                    }
                }
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .topLeading)
                
                
            }
            .alert(isPresented: $showingDeleteAlert) {
                Alert(title: Text("Alert"), message: Text("Are you sure you want to delete?"), primaryButton: .default(Text("Yes")) {
                    deleteRecord(reportId: reportID)
                    print("Button 1 tapped")
                }, secondaryButton: .cancel(Text("No")) {
                    // Action for Button 2
                    print("Button 2 tapped")
                })
            }
            
            
//            NavigationLink("", destination: UpdateScreenView(reportId: reportID, isComplaint: isComplaint, description: description, typeReport:reportType), isActive: $isUpdateView)
//                .hidden()
            
        }
        
        .onAppear{
            ListReport()
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
    func fin()
    {
        showingAddReportingView = true
    }
    
    func listReporting()
    {
        showingAddReportingView = true
    }
    
    func showAttachment()
    {
        print("attachment")
    }
    
    
    
    
    func handleTextChange(_ newText: String) {
        // Perform any actions based on the new text
        print("New text: \(newText)")
    }
    
    func ListReport()
    {
        
        isLoading = true
        let token = UserDefaults.standard.object(forKey: Constants.USER_SESSION_TOKEN) as! String
        
        print(token)
        let headers:HTTPHeaders = [
            // "Content-Type":"application/x-www-form-urlencoded",
            "x-access-token": token
        ]
        var userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!,
            
            
        ]
        
        let reportingModel = ReportingViewModel()
        
        reportingModel.ListReport(parameters: parameters , headers: headers) { result in
            // isShowingLoader.toggle()
            isLoading = false
            switch result {
                
            case .success(let Response):
                
                if Response.rescode == 1 {
                    //
                    //                    alertService.show(title: "Alert", message: Response.message!)
                    print(Response.data?.count)
                    reportingType = Response.data!
                    //  self.presentationMode.wrappedValue.dismiss()
                    //  ContestingElectionScreenView.loadContestElection()
                    
                }else{
                    //                    alertService.show(title: "Alert", message: Response.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
        
    }
    
    struct ReportingCell: View {
        var Status: String
        var ReportingType: String
        var Description: String
        var Date: String
        var Name: String
        
        
        var mapAction: () -> Void
        
        var delete: () -> Void
        var update: () -> Void
        var attachment: () -> Void
        
        
        
        
        var body: some View {
            HStack {
                
                VStack{
                    HStack{
                        Text(Status)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .font(.subheadline)
                            .foregroundColor(.blue)
                        // .background(CColors.MainThemeColor)
                            .underline()
                            .fontWeight(.bold)
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity,
                                   maxHeight: .infinity,
                                   alignment: .leading)
                        
                        
                        
                        Text(Date)
                            .font(.footnote)
                        
                        Text(Name)
                            .font(.footnote).padding(-5)
                        
                    }
                    
                    
                    
                    
                    HStack{
                        Text("Type:")
                            .font(.footnote)
                            .font(.system(size: 10, weight: .heavy))
                        Text(ReportingType)
                            .font(.footnote)
                            .font(.system(size: 10, weight: .medium))
                    }
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity,
                           alignment: .leading)
                    
                    
                    
                    
                    HStack{
                        Text("Description:")
                            .font(.footnote)
                        
                        Text(Description)
                            .font(.footnote).padding(-5)
                        
                        //  .multilineTextAlignment(.leading)
                        //  .padding(.trailing)
                        
                        
                        
                    }
                    
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity,
                           alignment: .leading)
                    
                    HStack(spacing: 10){
                        
                        Button(action: attachment) {
                            Image(systemName: "paperclip")
                                .imageScale(.large)
                                .foregroundColor(.black)
                        }
                        .onTapGesture {
                            attachment()
                            
                        }
                        
                        Button(action: {
                            
                        }) {
                            Image(systemName: "pencil")
                                .imageScale(.large)
                                .foregroundColor(.black)
                        }
                        
                        .onTapGesture {
                            update()
                            
                        }
                        
                        
                        Image(systemName: "trash")
                            .imageScale(.large)
                            .foregroundColor(.black)
                            .onTapGesture {
                                delete()
                            }
                        
                        
                        //Spacer()
                        
                        Button(action: mapAction) {
                            Image(systemName: "mappin.and.ellipse")
                                .imageScale(.large)
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity,
                               alignment: .trailing)
                        
                        .onTapGesture {
                            mapAction()
                            
                        }
                        
                        
                    } .frame(maxWidth: .infinity,
                             maxHeight: .infinity,
                             alignment: .leading)
                    
                }
                //.frame(width: 300, height: 100)
                
                
            }.listRowInsets(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)) // Adjust the values to set the desired spacing
            
            
        }
        
    }
    
    func deleteRecord(reportId: String) {
        let token = UserDefaults.standard.object(forKey: Constants.USER_SESSION_TOKEN) as! String
        
        let headers: HTTPHeaders = [
            "x-access-token": token
        ]
        
        var userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        
        let parameters: [String: Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!,
            "report_id": reportId
        ]
        
        let reportingModel = ReportingViewModel()
        
        reportingModel.DeleteReport(parameters: parameters, headers: headers) { result in
            switch result {
            case .success(let response):
                if response.rescode == 1 {
                    // Successful deletion, update the reportingType array
                    if let index = reportingType.firstIndex(where: { $0.report_id == reportId }) {
                        reportingType.remove(at: index)
                    }
                    alertService.show(title: "Alert", message: response.message!)
                    
                } else {
                    alertService.show(title: "Alert", message: response.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
}



struct ReportingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ReportingScreenView()
    }
}


