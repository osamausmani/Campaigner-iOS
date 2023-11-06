//
//  ContactUsView.swift
//  Campaigner
//
//  Created by Osama Usmani on 06/11/2023.
//

import SwiftUI

struct ContactUsView: View {
    @State private var isShowingLoader = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var alertService = AlertService()
    @State private var contactUsResponse: ContactUsResponse?
    let icons: [Image] = [Image(systemName: "envelope"), Image(systemName: "globe")]
    var body: some View {
            NavigationView {
                ZStack {
                    BaseView(alertService: alertService)
                    VStack {
                        if let contactUsData = contactUsResponse?.data {
                            List {
                                ForEach(contactUsData.indices, id: \.self) { index in
                                    if index == 1 {             CustomCellView(value: contactUsData[index].value, icon: icons[index])
                                                                          .onTapGesture {
                                                                              if let url = URL(string: "https://www.staging.halka.pk") {
                                                                                  UIApplication.shared.open(url)
                                                                              }
                                                                          }
                                                                  } else {
                                                                      CustomCellView(value: contactUsData[index].value, icon: icons[index])
                                                                  }
                                }
                                
                                
                            }
                           
                           
                           
                        }
                    }
                  
                    

                }

            }
            .navigationTitle("Contact Us")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(false)
            .onAppear {
                getContactUs()
            }
    }
    func getContactUs() {
        isShowingLoader.toggle()
        
        let parameters: [String: Any] = [
            "plattype": Global.PlatType,
        ]
        
        let lookUpViewModel = LookupsViewModel()
        
        lookUpViewModel.ContactUs(parameters: parameters) { result in
            isShowingLoader.toggle()
            
            switch result {
            case .success(let lookupresponse):
                print(lookupresponse)
                contactUsResponse = lookupresponse
            
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }

    
}


struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}


struct CustomCellView: View {
    var value: String
    var icon: Image

    var body: some View {
        HStack {
            icon
                .font(.system(size: 30))
                .foregroundColor(.black)
                .frame(width: 30)
                .padding(.leading,10)
            Text(value)
                .font(.body)
                .foregroundColor(.gray)
                .padding(20)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .padding(.trailing,10)
        }
        .background(.white)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
    }
}
