//
//  TermOfUseView.swift
//  Campaigner
//
//  Created by Macbook  on 03/11/2023.
//

import SwiftUI

struct TermOfUseView: View {
    @State private var isShowingLoader = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var alertService = AlertService()
    
    @State private var termOfUseResponse: TermOfUseResponse?
    @State private var isActiveScreen = false
    @State private var isPresentHome = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
            
                ZStack { 
                    BaseView(alertService: alertService)
                    VStack{
////                        CustomNavBar(title: "Term of Conditions", destinationView: HomeScreenView(presentSideMenu: $isPresentHome), isActive: $isActiveScreen)
//                            .edgesIgnoringSafeArea(.top)
                        ScrollView {
                            VStack {
                        
                                if var data = termOfUseResponse?.data.first {
                                    Text( data.terms)
                                        .padding(20)
                                     
                                }
                                    
                            }
                            .background(Color.white)
                            .cornerRadius(15)
                            .padding(.horizontal)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                          
    
                        }

                    }
                   
                      
                    
                    
                    
                }
            }
            .background(Color.gray)
            
        }
        .navigationTitle("Term of Conditions")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(false)
        .onAppear {
            getTermOfUse()
        }
       
    }
    
    func getTermOfUse() {
        isShowingLoader.toggle()
        
        let parameters: [String: Any] = [
            "plattype": Global.PlatType,
            "type": 1,
        ]
        
        let lookUpViewModel = LookupsViewModel()
        
        lookUpViewModel.TermOfUse(parameters: parameters) { result in
            isShowingLoader.toggle()
            
            switch result {
            case .success(let lookupresponse):
                print(lookupresponse)
                termOfUseResponse = lookupresponse
                
//                if lookupresponse.rescode == 1 {
//                    alertService.show(title: "Alert", message: lookupresponse.message)
//                    self.presentationMode.wrappedValue.dismiss()
//                } else {
//                    alertService.show(title: "Alert", message: lookupresponse.message)
//                }
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
}

struct TermOfUseView_Previews: PreviewProvider {
    static var previews: some View {
        TermOfUseView()
    }
}
