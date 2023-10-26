//
//  ContestingElectionScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 30/05/2023.
//

import SwiftUI
import Alamofire


struct ContestingElectionScreenView: View {
    
   
    @State var isUpdate = false
    @State var showingContestingElectionPopup = false
    @State var showingContestingElectionUpdatePopup = false
    @State private var isLoading = false
    @State var fin = [ContestingElection]()
    @State private var selectedCellIndex: Int?
   // @State private var refreshFlag = false
    @State private var isPresentHome:Bool=false
    @State private var isPresentMode:Bool=false
    @StateObject private var alertService = AlertService()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    private let dataPublisher = NotificationCenter.default.publisher(for: Notification.Name("NewDataNotification"))
   
    var body: some View {
        
        
        NavigationView {
            ZStack {
//                BaseView(alertService: alertService)
                    Image("logo")
                    .resizable()
                    .frame(maxHeight: 400,alignment: .center)
                        .opacity(0.1)
                
                VStack {
                   
                    CustomNavBar(title: "Manage Constituency", destinationView: HomeScreenView( presentSideMenu: $isPresentMode), isActive: $isPresentHome)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                    
                    
                    
                    
                    ZStack {
                        
                        List {
                            
                            
                            ForEach(fin.indices, id: \.self) { index in
                                CustomCell(Assembly: fin[index].assembly_type! == 1 ? "National Assembly" : "Provencial Assembly" , DistrictName: fin[index].district!, ConstituencyName: fin[index].constituency!, ReferralsCount: fin[index].refferal_no!, ProvinceName: fin[index].province!, delete: {selectedCellIndex = index
                                    delete()
                                }, update: {
                                    selectedCellIndex = index
                                    update()
                                    
                                }, action: {
                                    action()
                                    selectedCellIndex = index
                                }).onTapGesture {
                                    
                                }
                            }
                            //                            CustomCell(Assembly: "National Assembly", DistrictName: "Bahawalnagaraaa", ConstituencyName: "NA - 12 Bahawalgnbar", ReferralsCount: "123", ProvinceName: "Azad jummu kashmir") {
                            //
                            //                            } update: {
                            //
                            //                            } action: {
                            //
                            //                            }
                            
                            
                            
                        }
                        
                        VStack{
                            Spacer()
                        HStack{
                            Spacer()
                            AddButton(action: addContestent, label: "")
                                .padding(.trailing,10)
                                .popover(isPresented: $showingContestingElectionPopup)
                            {
                                ContestingElectionPopUpScreenView().onDisappear
                                {
                                    listElection()
                                }
                            }
                            
                        }
                    }
                    }
                }
            }
            
        }
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $showingContestingElectionUpdatePopup) {
            ContestingElectionUpdateScreenView(oAssembly: "",oProvince: "" , oDistrict: "" , oConstituency: "")
            
            
        }
        .onAppear
        {
          listElection()
        }
       
      //  .onReceive(Publisher, perform: <#T##(Publisher.Output) -> Void#>)
//        .onReceive(dataPublisher) { newData in
//            listElection()
//        }
        
    }
    
    func addContestent()
    {
        showingContestingElectionPopup = true
    }
    
    func delete()
    {
        print(selectedCellIndex)
        isLoading = true
        let headers:HTTPHeaders = [
            "x-access-token": UserDefaults.standard.object(forKey: Constants.USER_SESSION_TOKEN) as! String
        ]
        let userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        let token = UserDefaults.standard.string(forKey: Constants.USER_SESSION_TOKEN)
        
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!,
            "election_id": String(fin[selectedCellIndex!].election_id!)
            
        ]
        let contestentViewModel = ContestentViewModel()

        contestentViewModel.deleteContestentRequest(parameters: parameters ,headers: headers ) { result in
            // isShowingLoader.toggle()
            isLoading = false
            print(result)
            switch result {
                
            case .success(let deleteResponse):
                
                if deleteResponse.rescode == 1 {
                    
                    alertService.show(title: "Alert", message: deleteResponse.message!)
                    print(deleteResponse)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.fin.remove(at: selectedCellIndex!)
                        listElection()
                    }
      
                }else{
                    alertService.show(title: "Alert", message: deleteResponse.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    func update()
    {
        showingContestingElectionUpdatePopup = true
    }
    
    func action()
    {
        
    }
    
   
    
     func loadContestElection(){
        // isShowingLoader.toggle()
        isLoading = true
        let headers:HTTPHeaders = [
            // "Content-Type":"application/x-www-form-urlencoded",
            "x-access-token": UserDefaults.standard.object(forKey: Constants.USER_SESSION_TOKEN) as! String
        ]
        let userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        let token = UserDefaults.standard.string(forKey: Constants.USER_SESSION_TOKEN)
        
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!,
            
        ]
        
        //let registerViewModel = RegisterViewModel()
        
        
        let contestentViewModel = ContestentViewModel()
        
        
        
        contestentViewModel.listElections(parameters: parameters ,headers: headers ) { result in
            // isShowingLoader.toggle()
            isLoading = false
            print(result)
            switch result {
                
            case .success(let loginResponse):
                
                if loginResponse.rescode == 2 {
                    
                    print(loginResponse)
                    
                    
                    //  self.presentationMode.wrappedValue.dismiss()
                    
                }else{
                    alertService.show(title: "Alert", message: loginResponse.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }

    func updateContestElection(){
        // isShowingLoader.toggle()
        isLoading = true
        
        let userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!,
            
        ]
        
        //let registerViewModel = RegisterViewModel()
        
        
        let contestentViewModel = ContestentViewModel()
        
        contestentViewModel.listElections(parameters: parameters ) { result in
            // isShowingLoader.toggle()
            isLoading = false
            switch result {
                
            case .success(let loginResponse):
                
                if loginResponse.rescode == 1 {
                    
                    alertService.show(title: "Alert", message: loginResponse.message!)
                    
                    //  self.presentationMode.wrappedValue.dismiss()
                    
                }else{
                    alertService.show(title: "Alert", message: loginResponse.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    
    func deleteContestElection(){
        // isShowingLoader.toggle()
        isLoading = true
        let userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!,
            
        ]
        
        //let registerViewModel = RegisterViewModel()
        
        
        let contestentViewModel = ContestentViewModel()
        
        contestentViewModel.listElections(parameters: parameters ) { result in
            // isShowingLoader.toggle()
            isLoading = false
            print(result)
            switch result {
                
            case .success(let loginResponse):
                
                if loginResponse.rescode == 1 {
                    
                    
                    print(loginResponse)
                    //  self.presentationMode.wrappedValue.dismiss()
                    
                }else{
                    alertService.show(title: "Alert", message: loginResponse.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
 
    func listElection(){
        // isShowingLoader.toggle()
        isLoading = true
        
        let token = UserDefaults.standard.string(forKey: Constants.USER_SESSION_TOKEN)
        let headers:HTTPHeaders = [
            // "Content-Type":"application/x-www-form-urlencoded",
            "x-access-token": token!
        ]
        
        let userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        
        
        
        print(token!)
        
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!
            
        ]
        
        //let registerViewModel = RegisterViewModel()
        
        
        let contestentViewModel = ContestentViewModel()
        
        contestentViewModel.listElections(parameters: parameters,headers: headers ) { result in
            // isShowingLoader.toggle()
            isLoading = false
            print(result)
            switch result {
                
            case .success(let loginResponse):
                
                if loginResponse.rescode == 1 {
                    
                    print(loginResponse)
                    
                    fin = loginResponse.data!
                    
                    //  self.presentationMode.wrappedValue.dismiss()
                    
                    
                }else{
                    alertService.show(title: "Alert", message: loginResponse.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
  
}





struct ContestingElectionScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ContestingElectionScreenView( )
    }
}
