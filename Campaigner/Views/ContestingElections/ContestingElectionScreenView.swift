//
//  ContestingElectionScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 30/05/2023.
//

import SwiftUI
import Alamofire




struct ContestingElectionScreenView: View {
    
   
    @State var showingContestingElectionPopup = false
    @State private var isLoading = false
    @State var fin = [ContestingElection]()
    @State private var selectedCellIndex: Int?
   // @State private var refreshFlag = false
    
    @StateObject private var alertService = AlertService()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    private let dataPublisher = NotificationCenter.default.publisher(for: Notification.Name("NewDataNotification"))
   
    var body: some View {
        
        
        NavigationView {
            ZStack {
                BaseView(alertService: alertService)
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
                        //Spacer()
                        Text("Contesting Election")
                            .font(.headline)
                            .frame(width: 260)
                        
                        Spacer()
                        Button(action: {
                            // Perform action for bell icon
                        }) {
//                            Image(systemName: "bell")
//                                .imageScale(.large)
                            
                        }
                    } .foregroundColor(CColors.MainThemeColor)
                        .padding()
                        .navigationBarHidden(true)
                    
                    
                    
                    
                    ZStack {

                        List {

                            
                            ForEach(fin.indices, id: \.self) { index in
                                CustomCell(Assembly: fin[index].assembly_type! == 1 ? "National Assembly" : "Provencial Assembly" , DistrictName: fin[index].district!, ConstituencyName: fin[index].constituency!, ReferralsCount: fin[index].refferal_no!, ProvinceName: fin[index].province!, delete: {selectedCellIndex = index
                                    delete()
                                }, update: update, action: action).onTapGesture {

                                }
                            }
//                            CustomCell(Assembly: "National Assembly", DistrictName: "Bahawalnagaraaa", ConstituencyName: "NA - 12 Bahawalgnbar", ReferralsCount: "", ProvinceName: "Azad jummu kashmir") {
//
//                            } update: {
//
//                            } action: {
//
//                            }

                            
                            
                        }
                        AddButton(action: addContestent, label: "")
                            .popover(isPresented: $showingContestingElectionPopup)
                        {
                                ContestingElectionPopUpScreenView().onDisappear{
                                    listElection()
                                }
                        }
                            .border(Color.gray, width: 1) // Add border with gray color and 1 point width
                      
                        
                    }
                }
            }
            
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




struct CustomCell: View {
    var Assembly: String
    var DistrictName: String
    var ConstituencyName: String
    var ReferralsCount: String
    var ProvinceName: String
    
    var delete: () -> Void
    var update: () -> Void
    var action: () -> Void
    
    
    
    
    var body: some View {
        HStack {
            HStack {
                VStack{
                    HStack{
                        Text(Assembly)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                    }
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .background(CColors.MainThemeColor)
                    .fontWeight(.bold)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity,
                           alignment: .leading)
                
                    
                    HStack{
                        Text("District:")
                            .font(.footnote)
                            .font(.system(size: 10, weight: .heavy))
                        Text(DistrictName)
                            .font(.footnote)
                            .font(.system(size: 10, weight: .medium))
                    }
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity,
                           alignment: .leading)
                    .foregroundColor(CColors.MainThemeColor)
                    
                    
                    
                    HStack{
                        Text("Constituency:")
                            .font(.footnote)
                        
                        Text(ConstituencyName)
                            .font(.footnote).padding(-5)
                            
                          //  .multilineTextAlignment(.leading)
                          //  .padding(.trailing)
                            
                        
                        
                    }
                   
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity,
                           alignment: .leading)
                    
                    
                    .foregroundColor(CColors.MainThemeColor)
                    
                }
                .frame(width: 200, height: 100)
                
                //  Spacer()
                VStack{
                    HStack{
                        Text("Referrals:")
                            .font(.footnote)
                            .fontWeight(.bold)
                        Text(ReferralsCount)
                            .font(.footnote)
                    }
                    .foregroundColor(CColors.MainThemeColor)
                    .padding(.horizontal, 0)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity,
                           alignment: .topTrailing)
                    // Spacer().frame(height: 0) // Adjust the height of the Spacer
                    
                    HStack{
                        Text("Province:")
                            .font(.footnote)
                            .fontWeight(.bold)
                        
                        Text(ProvinceName)
                            .font(.footnote).padding(-5)
                            
                    }
                    .foregroundColor(CColors.MainThemeColor)
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity,
                           alignment: .topTrailing)
                    // Spacer().frame(height: 0) // Adjust the height of the Spacer
                    
                    
                    HStack(spacing: 30){
                        Button(action: {
                            // Perform action for Icon Button 1
                            //Update record
                           
                        }) {
                            Image(systemName: "person.circle")
                                .imageScale(.medium)
                                .foregroundColor(.blue)
                        }.onTapGesture {
                            
                        }
                        
                        Button(action: {
                            // Perform action for Icon Button 2
                            // Edit Record
                          
                            
                        }) {
                            Image(systemName: "paperclip")
                                .imageScale(.medium)
                                .foregroundColor(.green)
                        }.onTapGesture {
                            
                        }
                        
                        Button(action: delete) {
                            Image(systemName: "trash")
                                .imageScale(.medium)
                                .foregroundColor(.orange)
                        }}.frame(maxWidth: .infinity,
                                 maxHeight: .infinity,
                                 alignment: .topTrailing)
                        .onTapGesture {
                            delete()
                           
                        }
                    
                    
                }
                //                .padding(.horizontal, 0)
                //                .padding(.vertical, 20)
                
                
            }
        }.listRowInsets(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5)) // Adjust the values to set the desired spacing
        
        
    }
    
    
    
    
    
}
struct ContestingElectionScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ContestingElectionScreenView( )
    }
}
