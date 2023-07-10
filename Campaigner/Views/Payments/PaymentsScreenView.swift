//
//  PaymentsScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 14/06/2023.
//

import SwiftUI
import Alamofire

//class DataStorePayments: ObservableObject {
//    @Published var fee_id: String = ""
//    @Published var amount: Int = 0
//}

struct PaymentsScreenView: View {
    @State private var selectedTab = 0
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var isLoading = false
    
    @State private var paymentView = false
    @State private var paymentHistoryView = false
    @State private var selectedCellIndex: Int?
    @State private var payNowView = false
    @State private var selectedPayment = [ListPendingPayments]()
    
    
    @State var pendingPayments = [ListPendingPayments]()
    
   // @EnvironmentObject var dataStore: DataStorePayments
    
    
    @StateObject private var alertService = AlertService()
    
    
    var body: some View {
        NavigationView {
            
            ZStack{
                
                //                Image("splash_background")
                //                    .resizable()
                //                    .edgesIgnoringSafeArea(.all)
                
                VStack {

                    HStack(spacing: 0) {
                   
                        
                        TabBarButton(text: "Payment", isSelected: selectedTab == 0)
                        {
                            selectedTab = 0
                            listPendingPayments()
                        }
                        
                        //Spacer()
                        
                        TabBarButton(text: "Subscription", isSelected: selectedTab == 1) {
                            selectedTab = 1
                        }
                        
                       // Spacer()
                        
                        TabBarButton(text: "Payment History", isSelected: selectedTab == 2) {
                            selectedTab = 2
                            listPaymentHistory()
                        }
                        
            
                    }//.frame(height: 60)
                        .foregroundColor(Color.black)
                        .padding(20)
                    
                    
                    ZStack{
                        
                        VStack {
                            if selectedTab == 0 {
                                // Table view

                                
                                List {
                                    ForEach(pendingPayments.indices, id: \.self) { index in
                                        let payment = pendingPayments[index]
                                        PaymentCell(paymentType: payment.fee_type_text ?? "", dueAmount: String(payment.fee_value!) , dueDate: payment.pay_due_date ?? "", action: {
                                            selectedCellIndex = index
//                                            dataStore.fee_id = payment.fee_id ?? ""
//                                            dataStore.amount = payment.fee_value ?? 0
                                            selectedPayment.append(payment)
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
//                .fullScreenCover(isPresented: $paymentHistoryView)
//                {
//                    AddTeamView(title: .constant(""), description: .constant(""), message: .constant(""))
//                }
                .fullScreenCover(isPresented: $payNowView) {
                    PayNowScreenView(selectedPayment: $selectedPayment)
                }
                .overlay(
                    Group {
                        if isLoading {
                            ProgressHUDView()
                        }
                    }
                )
            }
        }.navigationBarTitle("Payment", displayMode: .inline )
           // .navigationBarItems(leading: backButton, trailing: EmptyView())
            .onAppear{
              listPendingPayments()
            }
    }
    
    private var backButton: some View {
        Button(action: {
            // Handle back button action here
            self.presentationMode.wrappedValue.dismiss()
            
        }) {
            Image(systemName: "chevron.left").tint(CColors.MainThemeColor).font(.system(size: 18))
            Text("Back").tint(CColors.MainThemeColor).font(.system(size: 18))
        }
    }
    
    func payNow()
    {
        payNowView = true
        
    }
    
    func listPaymentHistory(){
        // isShowingLoader.toggle()
        isLoading = true
        
        let token = UserDefaults.standard.string(forKey: Constants.USER_SESSION_TOKEN)
        let headers:HTTPHeaders = [
             "Content-Type":"application/x-www-form-urlencoded",
            "x-access-token": token!
        ]
        
        let userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        
        
        
        print(token!)
        
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!
            
        ]
        
        //let registerViewModel = RegisterViewModel()
        
        
        let paymentsViewModel = PaymentsViewModel()
        
        paymentsViewModel.paymentHistoryRequest(parameters: parameters,headers: headers ) { result in
            // isShowingLoader.toggle()
            isLoading = false
            print(result)
            switch result {
                
            case .success(let paymentHistoryResponse):
                
                if paymentHistoryResponse.rescode == 1 {
                    
                    print(paymentHistoryResponse)
                    
                //    fin = loginResponse.data!
                    
                    //  self.presentationMode.wrappedValue.dismiss()
                    
                    
                }else{
                    alertService.show(title: "Alert", message: paymentHistoryResponse.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    
     func listPendingPayments(){
        // isShowingLoader.toggle()
        isLoading = true
        
        let token = UserDefaults.standard.string(forKey: Constants.USER_SESSION_TOKEN)
        let headers:HTTPHeaders = [
             "Content-Type":"application/x-www-form-urlencoded",
            "x-access-token": token!
        ]
        
        let userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        
        
        
        print(token!)
        
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!
            
        ]
        
        //let registerViewModel = RegisterViewModel()
        
        
        let paymentsViewModel = PaymentsViewModel()
        
        paymentsViewModel.listPendingPayments(parameters: parameters,headers: headers ) { result in
            // isShowingLoader.toggle()
            isLoading = false
            print(result)
            switch result {
                
            case .success(let pendingPaymentResponse):
                
                if pendingPaymentResponse.rescode == 1 {
                    
                    print(pendingPaymentResponse)
                    
                //    fin = loginResponse.data!
                    
                    pendingPayments = pendingPaymentResponse.data!
                    
                    
                    //  self.presentationMode.wrappedValue.dismiss()
                    
                    
                }else{
                    alertService.show(title: "Alert", message: pendingPaymentResponse.message!)
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
            VStack(spacing: -15) {
                HStack {
                    Spacer()
                    VStack(alignment: .leading){
                        
                        Text("Payment Type")
                            .font(.subheadline)
                         //   .lineLimit(nil)
                          
                        Spacer()
                        Text("Due Amount")
                            .font(.subheadline)
                          
                        Spacer()
                        
                        Text("Due Date")
                            .font(.subheadline)
                           Spacer()
                        
                    }
              

                    .fontWeight(.semibold)
                    
//                    .frame(maxWidth: .infinity,
//                           maxHeight: .infinity,
//                           alignment: .topLeading)
                    .padding(20)

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

                    }.fontWeight(.medium)
                 
                       
                        .fontWeight(.semibold)
                        .padding(20)
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity,
                               alignment: .topLeading)
                    
                }
                
                
                SecondaryButton(action: {
                    
                }, label: "Pay Now").onTapGesture {
                //    DataStorePayments.value = pendingPayments[selectedCellIndex].fee_id
                   action()
                } .padding(10)//.padding(.top)
                    //.frame(height: 40)
                
                
            }
            .border(Color.gray, width: 2)
//            .padding(.horizontal, 10)
//            .padding(.vertical, 20)
            
            .scaledToFit()
            .background(.clear)
            
         
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
            .border(Color.gray, width: 2)
            
         
        }
        
    
        
    }
    
    func listBanks()
    {
       
        isLoading = true
//        let headers:HTTPHeaders = [
//            "x-access-token": UserDefaults.standard.object(forKey: Constants.USER_SESSION_TOKEN) as! String
//        ]
        let userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
       // let token = UserDefaults.standard.string(forKey: Constants.USER_SESSION_TOKEN)
        
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!,
         //   "election_id": String(fin[selectedCellIndex!].election_id!)
            
        ]
        let paymentViewModel = PaymentsViewModel()

        paymentViewModel.bankListRequest(parameters: parameters  ) { result in
            // isShowingLoader.toggle()
            isLoading = false
            print(result)
            switch result {
                
            case .success(let deleteResponse):
                
                if deleteResponse.rescode == 1 {
                    
                    alertService.show(title: "Alert", message: deleteResponse.message!)
                    print(deleteResponse)
                   // listElection()
      
                }else{
                    alertService.show(title: "Alert", message: deleteResponse.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
   
}

struct PaymentsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentsScreenView()
    }
}
