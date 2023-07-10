//
//  PostResultsView.swift
//  Campaigner
//
//  Created by Macbook  on 13/06/2023.
//

import SwiftUI

struct PostResultsView: View {
    @State private var showSearchBar = false
    
    
    @State private var searchText = ""
    
    @State private var cTitle = DropDownModel()
    @State private var cDescription = DropDownModel()
    
    @State  var Title : [DropDownModel] = []
    @State  var Description : [DropDownModel] = []
    
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
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            // Image(systemName: "line.horizontal.3")
//                            Image(systemName: "arrowshape.left")
//                                .imageScale(.large)
                            Image(systemName: "chevron.left").tint(CColors.MainThemeColor).font(.system(size: 18))
                            Text("Back").tint(CColors.MainThemeColor).font(.system(size: 18))
                                
                        }
                        
                       // Spacer()
                        
                        Text("Post Results")
                            .font(.headline)
                            .frame(width: 250)
                        
                        Spacer()
                        
//                        Button(action: {
//                            // Perform action for searchbar icon
//                            showSearchBar.toggle()
//                        }) {
//                            Image(systemName: "magnifyingglass")
//                                .imageScale(.large)
//                        }
                        
                        
                        
                        
                    }
                    .foregroundColor(.black)
                    .padding()
                    
                    VStack{
                        
                        //                        if showSearchBar {
                        //                            SearchBar(text: $searchText).onChange(of: searchText, perform: handleTextChange)
                        //                        }
                        
                       // CounterTabView(heading: "Total Surveys:")
                        DropDown(label: "", placeholder: "Select Polling Station", selectedObj:  $cTitle, menuOptions: Title ).padding(14)
                        Spacer()
                        //
                        //                        ZStack{
                        //                            List{
                        //                                SurveysCell(Team: "Support Team", TeamMessage: "Description Goes here ", tehsilTown: "Rawalpindi", polingStation: "Rawalpindi")
                        //                            }
                        //                            AddButton(action: addSurverys, label: "")
                        //                        }
                        //                    } .frame(maxWidth: .infinity,
                        //                             maxHeight: .infinity,
                        //                             alignment: .topLeading)
                                           
                        
                    } .padding()
                    
                    AddButton(action: fin, label: "")
                }
            }
        }
    }
    
    func fin()
    {
        
    }
}

struct PostResultsView_Previews: PreviewProvider {
    static var previews: some View {
        PostResultsView()
    }
}
