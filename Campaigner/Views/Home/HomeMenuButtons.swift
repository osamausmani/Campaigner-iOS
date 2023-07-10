//
//  HomeMenuButtons.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/05/2023.
//

import SwiftUI

struct HomeMenuButtons: View {
    
 var electionID = ""
    
     //@State private var value = ""
    
    
    
    @State private var contestingScreenView = false
    @State private var surveyScreenView = false
    @State private var reportingScreenView = false
    @State private var complaintsScreenView = false
    
    @State private var electionResultsScreenView = false
    @State private var postResultsScreenView = false
    
    @State private var teamsScreenView = false
   

    
    var symbols = [
        1: ["title": "Surveys", "symbol": "surveys"],
        2: ["title": "Reporting", "symbol": "reporting"],
        3: ["title": "Complaints", "symbol": "complaints"],
        4: ["title": "Election Results", "symbol": "post-result"],
        5: ["title": "Post Results", "symbol": "post-result"],
        6: ["title": "Teams", "symbol": "teams"]
    ]
    
    var layout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),

    ]
    
    var body: some View {
                LazyVGrid(columns: layout, spacing: 20) {
                    ForEach(symbols.keys.sorted(), id: \.self) { id in
                        if let symbolData = symbols[id],
                           let title = symbolData["title"],
                           let symbolName = symbolData["symbol"] {
                            VStack {

                                
                                Button(action: {
                                // Perform action for burger icon
                                    buttonTapped(id)
                                            }) {
                                Image(symbolName)
                                .resizable()
                                .padding()
                                .frame(width: 100, height: 100)
                                .cornerRadius(15)
                   
                                            }.id(symbols.keys.sorted())
                                Text(title).foregroundColor(.black).fontWeight(.bold)

                               
                            }
                        }
                    }.fullScreenCover(isPresented: $contestingScreenView) {
                        ContestingElectionScreenView()
                    }
                    .fullScreenCover(isPresented: $surveyScreenView) {
                        SurveyScreenView()
                    }
                    .fullScreenCover(isPresented: $reportingScreenView) {
                        ReportingScreenView()
                    }
                    
                    .fullScreenCover(isPresented: $complaintsScreenView) {
                        ComplaintsScreenView()
                    }
                    .fullScreenCover(isPresented: $electionResultsScreenView) {
                        SearchElectionScreenView()
                    }
                    .fullScreenCover(isPresented: $postResultsScreenView) {
                        PostResultsView()
                    }
                    .fullScreenCover(isPresented: $teamsScreenView) {
                        TeamsScreenView(value: electionID)
                    }
                    
                 
                 
            }
        }
    
    func buttonTapped(_ number: Int) {
         print("Button tapped: \(number)")
         // Perform any other actions you need here
        
        if number == 1
        {
            surveyScreenView = true
            
        }
        else if number == 2  {
            
            reportingScreenView = true
            
        }
        else if number == 3  {
            
            complaintsScreenView = true
            
        }
        else if number == 4  {
            
            electionResultsScreenView = true
            
        }
        else if number == 5  {
            
            postResultsScreenView = true
            
        }
        else if number == 6
        {
            teamsScreenView = true
        }
        
        
     }
}

struct HomeMenuButtons_Previews: PreviewProvider {
    static var previews: some View {
        HomeMenuButtons(electionID: "")
    }
}

