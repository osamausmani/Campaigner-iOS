//
//  UpgradeAccountView.swift
//  Campaigner
//
//  Created by Macbook  on 05/12/2023.
//

import SwiftUI
import SwiftAlertView
struct UpgradeAccountView: View {
    @State private var isProAccount: Bool = false
    @State private var isPresentMode: Bool = true

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("splash_background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    ZStack {
                      
                    VStack(alignment: .leading, spacing: 10) {
                    Text("")
                            .padding(.bottom,90)
                        FeatureRow(icon: "tick", title: "Surveys:", description: "Create tailored surveys to acquire the exact information instantly.")

                        FeatureRow(icon: "tick", title: "Complaints:", description: "Learn about the latest problems that your constituents are facing as soon as they arise. Update the public as soon as you solve their problems.")
                        FeatureRow(icon: "tick", title: "Reports:", description: "Directly communicate the problems to your team members and enable your team leads and members to communicate to you and identify outstanding issues.")
                        FeatureRow(icon: "tick", title: "Notifications:", description: "Send out instant notifications to your constituents and keep them engaged before and after your election campaigns.")
                        
                    }
                    .padding(.vertical)
                    .background(Color.white)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                        
                }
                    
                    .overlay{
                        VStack(spacing: 0) {
                            Image("upgrade")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.32)
                            Text("halka Pro")
                                .offset(y: -geometry.size.height * 0.0)
                                .font(.title)
                        }
                        .offset(y: -geometry.size.height * 0.26)
                      
                    }
                    VStack {
                        Text("Upgrade and Utilize the complete scope of halka pro Services.")
                            .bold()
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        MainButton(action: {
                            SwiftAlertView.show(title: "Alert",
                                                message: "Are you sure to upgrade your account?",
                                                buttonTitles: "Cancel", "OK")
                                .onButtonClicked { _, buttonIndex in
                                    print("Button Clicked At Index \(buttonIndex)")
                                    if buttonIndex == 1 {
                                        UpgradeAccount()
                                    }                                 }
                        }, label: "Upgrade account now")
                        .padding(.horizontal, 50)
                        .padding(.bottom, 20)
                    }

                    Spacer()
                }
            }
            .navigationBarHidden(false)
        }
    }
    func UpgradeAccount(){
     
        var userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!
        ]
        
        let contestentViewModel = ContestentViewModel()
        
        contestentViewModel.UpgradeAccount(parameters: parameters ) { result in
            switch result {
                
            case .success(let response):
                print(response.message!)
                SwiftAlertView.show(title: "Alert",
                                    message: "Upgraded",
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
struct UpgradeAccountView_Previews: PreviewProvider {
    static var previews: some View {
        UpgradeAccountView()
    }
}
