//
//  PaymentsScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 14/06/2023.
//

import SwiftUI
import Alamofire

struct PaymentsScreenView: View {
    @State private var selectedTab = 0
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var isLoading = false
    
    @State private var paymentView = false
    @State private var paymentHistoryView = false
    @State private var selectedCellIndex: Int?
    @State private var payNowView = false
    
    
    
    @State var fin = [ContestingElection]()
    
    @StateObject private var alertService = AlertService()
    
    
    var body: some View {
        NavigationView {
            
            ZStack{
                
                //                Image("splash_background")
                //                    .resizable()
                //                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    
                    // Navigation bar
//                    HStack {
//                        Button(action: {
//                            // Perform action for burger icon
//                            self.presentationMode.wrappedValue.dismiss()
//                        }) {
//                            Image(systemName: "arrowshape.left")
//                                .imageScale(.large)
//
//                        }
//                        Spacer()
//                        Text("Teams")
//                            .font(.headline)
//
//                        Spacer()
//
//                    }.foregroundColor(CColors.MainThemeColor)
//                        .padding()
//                        .navigationBarHidden(true)
//
//                    Divider()
                    
                    HStack(spacing: 0) {
                        Spacer()
                        
                        TabBarButton(text: "Payment", isSelected: selectedTab == 0) {
                            selectedTab = 0
                        }
                        
                        Spacer()
                        
                        TabBarButton(text: "Subscription", isSelected: selectedTab == 1) {
                            selectedTab = 1
                        }
                        
                        Spacer()
                        
                        TabBarButton(text: "Payment History", isSelected: selectedTab == 2) {
                            selectedTab = 2
                        }
                        
                        Spacer()
                    }.frame(height: 40)
                        .foregroundColor(Color.black)
                    
                    
                    ZStack{
                        
                        VStack {
                            if selectedTab == 0 {
                                // Table view
                                List {
                                    ForEach(0..<5) { index in
                                        PaymentCell(paymentType: "Subscription", dueAmount: "Rs 50,000.00", dueDate: "12 April 2023", action: {
                                            selectedCellIndex = index
                                            print(selectedCellIndex!)
                                            payNow()
                                        }).onTapGesture {
                                            
                                        }
                                    }
                                }
                            }
                            else if selectedTab == 1 {
                               // List{
                                GeometryReader { geometry in
                                    VStack{
                                        SubscribeScreenView()
                                    } .frame(width: geometry.size.width,height: geometry.size.height)
                                        
                                    // }
                                }
                            }
                            else {
                                
                                
                                List {
                                    ForEach(0..<5) { index in
                                        PaymentHistoryCell(paymentType: "Subscription", paidAmount:  "Rs 50,000.00", status: "Verified", paidOn: "10 April 2023", referenceNumber: "T23343546")
                                    }
                                }
                            }
                            
                            // Other views...
                        }
                        
                        
                        
                        
                        
                        // Addition sign
                        // AddButton(action: add, label: "")
                        // .padding(.top)
                        
                    }
                    
                }
                .navigationBarHidden(true)
                .fullScreenCover(isPresented: $paymentView) {
                    AddMemberView()
                }
                .fullScreenCover(isPresented: $paymentHistoryView) {
                    AddTeamView()
                }
                .fullScreenCover(isPresented: $payNowView) {
                    PayNowScreenView()
                }
                .overlay(
                    Group {
                        if isLoading {
                            ProgressHUDView()
                        }
                    }
                )
            }
        }
    }
    
    func payNow()
    {
        payNowView = true
        
    }
    
    func listMembers(){
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
    
    func add()
    {
        if selectedTab == 0
        {
            paymentView = true
        }else
        {
            paymentHistoryView = true
        }
        
    }
    
 
    struct PaymentCell: View {
        
        
        
        var paymentType : String
        var dueAmount : String
        var dueDate : String
        
        var action: () -> Void
        
        
        var body: some View {
            VStack {
                HStack {
                    Spacer()
                    VStack(alignment: .leading){
                        
                        Text("Payment Type")
                            .font(.subheadline)
                          
                        Spacer()
                        Text("Due Amount")
                            .font(.subheadline)
                          
                        Spacer()
                        
                        Text("Due Date")
                            .font(.subheadline)
                           Spacer()
                        
                    }
              

                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity,
                           alignment: .topLeading)
                    Spacer()
                    Spacer()
                    Spacer()
                    VStack(alignment: .leading){

                        Text(paymentType)
                            .font(.subheadline)
                            
                        Spacer()
                        Text(dueAmount)
                            .font(.subheadline)
                            
                        Spacer()
                        Text(dueDate)
                            .font(.subheadline)
                           
                        Spacer()

                    }.fontWeight(.light)
                 
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity,
                               alignment: .topLeading)
                        .fontWeight(.semibold)
                    
                }
//                SecondaryButton(action: {
//                    print("selected")
//                    payNow()
//                }, label: "Pay now")
                
                SecondaryButton(action: action, label: "Pay Now").onTapGesture {
                   action()
                }
                
            }
            .padding(.horizontal, 5)
            .padding(.vertical, 20)
            
         
        }
        
    
        
    }
    
    struct PaymentHistoryCell: View {
        
        
        
        var paymentType : String
        var paidAmount : String
        var status : String
        var paidOn : String
        var referenceNumber : String
        
        
        var body: some View {
            VStack {
                HStack {
                    Spacer()
                    VStack(alignment: .leading){
                        
                        Text("Payment Type")
                            .font(.subheadline)
                          
                        Spacer()
                        Text("Paid Amount")
                            .font(.subheadline)
                          
                        Spacer()
                        
                        Text("Status")
                            .font(.subheadline)
                           Spacer()
                        
                        Text("Paid On")
                            .font(.subheadline)
                           Spacer()
                        
                        Text("Referance Number")
                            .font(.subheadline)
                           Spacer()
                        
                    }
              

                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity,
                           alignment: .topLeading)
                    Spacer()
                    Spacer()
                    Spacer()
                    VStack(alignment: .leading){

                        Text(paymentType)
                            .font(.subheadline)
                            
                        Spacer()
                        Text(paidAmount)
                            .font(.subheadline)
                            
                        Spacer()
                        Text(status)
                            .font(.subheadline)
                           
                        Spacer()
                        
                        Text(paidOn)
                            .font(.subheadline)
                           
                        Spacer()
                        
                        Text(referenceNumber)
                            .font(.subheadline)
                           
                        Spacer()

                    }.fontWeight(.light)
                 
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity,
                               alignment: .topLeading)
                        .fontWeight(.semibold)
                    
                }
//                MainButton(action: {
//
//                }, label: "Pay now")
            }
            .padding(.horizontal, 5)
            .padding(.vertical, 20)
            
         
        }
        
    
        
    }
    
   
}

struct PaymentsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentsScreenView()
    }
}
