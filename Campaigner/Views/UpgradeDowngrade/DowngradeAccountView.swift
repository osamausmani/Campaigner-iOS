//
//  DowngradeAccountView.swift
//  Campaigner
//
//  Created by Macbook  on 05/12/2023.
//

import SwiftUI
import SwiftAlertView
import Alamofire
struct DowngradeAccountView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("splash_background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    
                    ZStack {
                        
                        VStack(alignment:.leading,spacing: 10) {
                            Text("")
                                .padding(.bottom,90)
                            FeatureRow(icon: "tick", title: "Surveys:", description: "New surveys cannot be conducted.")
                            FeatureRow(icon: "tick", title: "Complaints:", description: "Complaints of the constituents are not accessible directly.")
                            FeatureRow(icon: "tick", title: "Reports:", description: "Reports submitted by the team leads and members will not be accessible.")
                            FeatureRow(icon: "tick", title: "Notifications:", description: "Option of sending out notifications will not remain available.")
                        }
                        .padding(.vertical)
                        
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                    }
                    .overlay{
                        
                        VStack(spacing: 0) {
                            Image("downgrade")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.32)
                            Text("halka")
                                .offset(y: -geometry.size.height * 0.0)
                                .font(.title)
                        }
                        .offset(y: -geometry.size.height * 0.2)
                        
                        
                    }
                    
                    VStack {
                        
                        MainButton(action: {
                            SwiftAlertView.show(title: "Alert",
                                                message: "Are you sure to downgrade your account?",
                                                buttonTitles: "Cancel", "OK")
                            .onButtonClicked { _, buttonIndex in
                                print("Button Clicked At Index \(buttonIndex)")
                                if buttonIndex == 1{
                                    DowngradeAccount()
                                }
                                
                                
                                
                            }
                        } ,label: "Swicth to halka Basic account?")
                        .padding(.horizontal,50)
                    }
                    .padding(.top, 10)
                }
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .center)
                
            }
        }
        .navigationBarHidden(false)
    }
    func DowngradeAccount(){
        
        let token = UserDefaults.standard.object(forKey: Constants.USER_SESSION_TOKEN) as! String
        let headers:HTTPHeaders = [
            "x-access-token": token
        ]
        
        var userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!
        ]
        
        let contestentViewModel = ContestentViewModel()
        
        contestentViewModel.DegradeAccount(parameters: parameters ) { result in
            switch result {
                
            case .success(let response):
                print(response.message!)
                SwiftAlertView.show(title: "Alert",
                                    message: "Degraded",
                                    buttonTitles:  "OK")
                .onButtonClicked { _, buttonIndex in
                    print("Button Clicked At Index \(buttonIndex)")
                    self.presentationMode.wrappedValue.dismiss()
                }

            case .failure(let error):
                print(error)
                
            }
            
        }
    }
}
struct DowngradeAccountView_Previews: PreviewProvider {
    static var previews: some View {
        DowngradeAccountView()
    }
}
