//
//  ReportingScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 13/06/2023.
//

import SwiftUI

struct ReportingScreenView: View {
    
    @State private var selectedTab = 0
    @State var showingAddReportingView = false
    @State private var isLoading = false
    
    @StateObject private var alertService = AlertService()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        
        NavigationView {
            ZStack {
                BaseView(alertService: alertService)
                
                
                //                    Image("splash_background")
                //                        .resizable()
                //                        .edgesIgnoringSafeArea(.all)
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
                        // Spacer()
                        Text("Reporting")
                            .font(.headline)
                            .frame(width: 250)
                        
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
                    
                    Divider()
                    
                    HStack(spacing: 0)
                    {
                        Spacer()
                        
                        TabBarButton(text: "Own", isSelected: selectedTab == 0) {
                            selectedTab = 0
                            // listMembers()
                        }
                        
                        Spacer()
                        
                        TabBarButton(text: "Other(s)", isSelected: selectedTab == 1)
                        {
                            selectedTab = 1
                            // listTeams()
                        }
                        
                        Spacer()
                    }.frame(height: 40)
                        .foregroundColor(Color.black)
                    
                    ZStack {
                        Image("reportingNil")
                            .resizable()
                            .edgesIgnoringSafeArea(.all)
                        // to test viww there is sample list uncommit it and commit the onLoad function
                        List {
                            
                            
                            
                            
                        }
                        
                        if selectedTab == 0 {
                            
                            AddButton(action: fin, label: "")
                                .fullScreenCover(isPresented: $showingAddReportingView) {
                                    AddReportScreenView()
                                }
                        }else
                        {
                            
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
    
    func listReporting()
    {
        showingAddReportingView = true
    }
    
}



struct ReportingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ReportingScreenView()
    }
}
