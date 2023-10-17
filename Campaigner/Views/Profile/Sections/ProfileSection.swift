//
//  ProfileSection.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/05/2023.
//

import Foundation
import SwiftUI
import Alamofire
import AlertToast

struct ProfileSection: View {
    @State private var isShowingLoader = false
    @StateObject var alertService = AlertService()
    
    @State  var userCNIC = UserDefaults.standard.string(forKey: Constants.USER_CNIC)!
    @State  var userDistrict = ""
    @State  var userCity = ""
    @State  var userNA = ""
    @State  var userPA = ""
    
    var body: some View {
        VStack {
            BaseView(alertService: alertService)
            
            HStack {
                Text(userCNIC)
                    .font(.headline)
                
                
                Spacer()
                Button(action: {
                    // Add your button action here
                }) {
                    HStack {
                        HStack{
                            Image(systemName: "pencil")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                            Text("Edit")
                                .font(.headline)
                                .foregroundColor(.white)
                        }.padding(4)
                    }.background(CColors.MainThemeColor)
                    
                        .cornerRadius(4)
                    
                    
                }
            }.padding(.bottom,10)
            Divider()
            HStack() {
                VStack(alignment: .leading) {
                    Text("District")
                        .font(.headline)
                    Text(userDistrict)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading) // Align content to the left
                
                VStack(alignment: .leading) {
                    Text("Tehsil/City/Town")
                        .font(.headline)
                    Text(userCity)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading) // Align content to the left
            }
            Divider()
            
            HStack() {
                VStack(alignment: .leading) {
                    Text("National Assembly")
                        .font(.headline)
                    Text(userNA)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading) // Align content to the left
                
                VStack(alignment: .leading) {
                    Text("Provincial Assembly")
                        .font(.headline)
                    
                    Text(userPA)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading) // Align content to the left
            }.padding(.top,10)
            
        }.padding(10)
            .background(Color.white)
            .cornerRadius(10) // Adjust the corner radius as needed
            .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
            .onAppear {
                SubmitRequest()
            }
        
        if isShowingLoader {
            Loader(isShowing: $isShowingLoader)
                .edgesIgnoringSafeArea(.all)
        }
        
    }
    
    
    
    func SubmitRequest(){
        isShowingLoader.toggle()
        
        
        let parameters: [String:Any] = [
            "plattype": Constants.PLAT_TYPE,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!
        ]
        
        let ProfileViewModel = ProfileViewModel()
        
        ProfileViewModel.GetProfileBasicInfo(parameters: parameters ) { result in
            isShowingLoader.toggle()
            switch result {
            case .success(let response):
                
                if response.rescode == 1 {
                    userDistrict = response.data?[0].district_name ?? ""
                    userCity = response.data?[0].tehsil_name ?? ""
                    userPA = response.data?[0].constituency_pa ?? ""
                    userNA = response.data?[0].constituency_na ?? ""
                }else{
                    alertService.show(title: "Alert", message: response.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    
}



struct ProfileSection_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSection()
    }
}
