//
//  SurveyScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 04/06/2023.
//

import SwiftUI

struct SurveyScreenView: View {
    
    @State private var showSearchBar = false
    
    
    @State private var searchText = ""
    
    @State private var showAddSurveyScreen = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationView {
            
            ZStack{
                Image("splash_background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    
                    HStack {
                        Button(action: {
                            // Perform action for burger icon
                            print("actionAddSurvey")
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            // Image(systemName: "line.horizontal.3")
                            Image(systemName: "arrowshape.left")
                                .imageScale(.large)
                        }
                        
                        Spacer()
                        
                        Text("Surveys")
                            .font(.headline)
                        
                        Spacer()
                        
                        Button(action: {
                            // Perform action for searchbar icon
                            showSearchBar.toggle()
                        }) {
                            Image(systemName: "magnifyingglass")
                                .imageScale(.large)
                        }
                        
                        
                        
                        
                    }
                    .foregroundColor(.black)
                    .padding()
                    
                    VStack{
                        
                        if showSearchBar {
                            SearchBar(text: $searchText).onChange(of: searchText, perform: handleTextChange)
                        }
                        
                        CounterTabView(heading: "Total Surveys:")
                        Spacer()
                        
                        ZStack{
                            List{
                                SurveysCell(Team: "Support Team", TeamMessage: "Description Goes here ", tehsilTown: "Rawalpindi", polingStation: "Rawalpindi")
                            }
                            AddButton(action: addSurverys, label: "")
                        }
                    }
                    .frame(maxWidth: .infinity,
                             maxHeight: .infinity,
                             alignment: .topLeading)
                    .padding()
                    
                    NavigationLink(destination: AnyView(AddSurveyScreenView()), isActive: $showAddSurveyScreen) {

                    }
                }
            }
        }
        
    }
    
    func addSurverys()
    {
        showAddSurveyScreen = true
    }
    
    struct SurveysCell: View {
        
        
        var Team : String
        var TeamMessage: String
        
        var tehsilTown : String
        
        var polingStation : String
        
        
        var body: some View {
            
            VStack{
                HStack {
                    Text(Team)
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        // Perform action for Icon Button 2
                        // Edit Record
                        
                    }) {
                        Image(systemName: "arrowshape.forward")
                            .imageScale(.small)
                            .foregroundColor(.black)
                    }
                }
                Spacer()
                HStack{
                    Text("Tehsil/Town: \(tehsilTown)")
                        .font(.system(size: 11))
                    Spacer()
                    Text("Polling Station: \(polingStation)")
                        .font(.system(size: 11))
                    
                }
                
                HStack{
                    Text("The Description Goes hereThe Description Goes hereThe Description Goes hereThe Description Goes here")
                        .font(.footnote).frame(maxWidth: .infinity,
                                                  maxHeight: .infinity,
                                                  alignment: .topLeading)
                    
                    
                }
                
                
            }
         
            
            
        }
        
    }
    
    
    func handleTextChange(_ newText: String) {
        // Perform any actions based on the new text
        print("New text: \(newText)")
    }
}


struct SurveyScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyScreenView()
    }
}
