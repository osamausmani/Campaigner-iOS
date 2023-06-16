//
//  ReportingScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 13/06/2023.
//

import SwiftUI

struct ReportingScreenView: View {
    
    
    @State var showingAddReportingView = false
    @State private var isLoading = false

    @StateObject private var alertService = AlertService()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        
        NavigationView {
            ZStack {
                BaseView(alertService: alertService)
             
                    
                    Image("splash_background")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                VStack {
                    //
                    // Navigation Bar
                    
                    HStack {
                        Button(action: {
                            // Perform action for burger icon
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "arrowshape.left")
                                .imageScale(.large)
                            
                        }
                        Spacer()
                        Text("Reporting")
                            .font(.headline)
                        
                        Spacer()
                        Button(action: {
                            // Perform action for bell icon
                        }) {
                            Image(systemName: "bell")
                                .imageScale(.large)
                            
                        }
                    } .foregroundColor(CColors.MainThemeColor)
                        .padding()
                        .navigationBarHidden(true)
                    
                    
                    
                    
                    ZStack {
                        // to test viww there is sample list uncommit it and commit the onLoad function
                        List {
                            //                                                        ForEach(0..<6) { index in
                            //                                                            CustomCell(Assembly: "AAA", DistrictName: "Pujab", ConstituencyName: "Constitution", ReferralsCount: "222", ProvinceName: "Punjabiiii")
                            //                                                        }
                            
                           
                        }
                        
                        AddButton(action: fin, label: "")
                            .fullScreenCover(isPresented: $showingAddReportingView) {
                                AddReportScreenView()
                            }
                    
                        
                        
                        
                    }
                }
            }
            
        }
    }
    
    func fin()
    {
        showingAddReportingView = true
    }
    
}



struct ReportingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ReportingScreenView()
    }
}
