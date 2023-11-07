//
//  ElectionHistoryListScreenView.swift
//  Campaigner
//
//  Created by Osama Usmani on 29/10/2023.
//

import Foundation

import SwiftUI


struct ElectionHistoryListScreenView: View {
    @State public var selectedOption : String?
    
    @State public var selectedOptionID : String?
    @State public var selectedConstituenceyID : String?
    @State public var selectedCandidateID : String?
    @StateObject private var alertService = AlertService()
    
    @State var constituenciesResults = [ElectionConstituenciesListDetails]()
    @State var candidateResults = [ElectionCandidateResultDetails]()
    var title: String
    
    var body: some View {
        VStack(spacing: 20) {
            ScrollView{
                if selectedOption == "0" {
                    ForEach(constituenciesResults.indices, id: \.self) { index in
                        ElectionHistoryCandidateRow(item: $constituenciesResults[index])
                    }
                }
                else{
                    ForEach(candidateResults.indices, id: \.self) { index in
                        ElectionHistoryCandidateRowCandidate(item: $candidateResults[index])
                    }
                }
            }
        }.onAppear{
            
            if selectedOption == "0" {
                GetConstituenciesResults()
            }
            else{
                GetCandidatesResults()
            }
        }
        .navigationTitle(title)
    }
    
    func GetConstituenciesResults(){
        let parameters: [String:Any] = [
            "target": "constituency",
            "action": "listbyid",
            "id": selectedConstituenceyID!
            
        ]
        let ViewModel = LookupsViewModel()
        ViewModel.ListVoterElectionConstituenciesResult(parameters: parameters ) { result in
            switch result {
            case .success(let response ):
                constituenciesResults.removeAll()
                constituenciesResults = response.data ?? []
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    func GetCandidatesResults(){
        let parameters: [String:Any] = [
            "target": "politician",
            "action": "listelectionhist",
            "id": selectedCandidateID!
            
        ]
        let ViewModel = LookupsViewModel()
        ViewModel.ListVoterElectionCandidateResult(parameters: parameters ) { result in
            switch result {
            case .success(let response ):
                candidateResults.removeAll()
                candidateResults = response.data ?? []
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    
    
    
}

struct ElectionHistoryCandidateRow: View {
    
    @Binding public var item : ElectionConstituenciesListDetails
    
    
    var body: some View {
        ZStack{
            HStack(spacing: 16) {
                VStack{
                    HStack{
                        Image("default_large_image")
                            .resizable().scaledToFill()
                            .frame(width: 40, height: 40 )
                            .cornerRadius(20)
                            .padding(0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 1) // Adjust the width as needed
                            )
                        
                        
                        VStack(alignment: .leading) {
                            Text(item.cand ?? "Candidate Name")
                                .font(.headline).foregroundColor(Color.blue).underline()
                            
                            
                            Text(DateFormatterHelper().formatDateStringYMD(item.electDate ?? "")!)
                                .foregroundColor(.gray)
                            Text("( " + item.designation! + " " + item.description! + " )")
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("Total Votes").font(.system(size: 14)).padding(.bottom,-7)
                            VStack{
                                Text(item.votescand ?? "0")
                                    .font(.headline).padding(8)
                            }.background(CColors.TextInputBgColor)
                            
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                            
                            
                            
                        }
                    }
                    Divider()
                    HStack{
                        
                        HStack{
                            Image("batch")
                                .resizable().scaledToFill()
                                .frame(width: 30, height: 30 )
                                .padding(.top, 4).padding(.leading,8).padding(.bottom,4)
                            
                            Text(
                                
                                item.candpos == "1" ? "1st" :
                                    item.candpos == "2" ? "2nd" :
                                    item.candpos == "3" ? "3rd" :
                                    (
                                        item.candpos! + "th"
                                    )
                                
                            ).font(.system(size: 18)).bold()
                                .foregroundColor(.white).padding(.trailing,50)
                        }.background(
                            item.candpos == "1" ? CColors.MainThemeColor :
                                item.candpos == "2" ? Color.yellow :
                                item.candpos == "3" ? Color.green : .blue
                            
                            
                        ).cornerRadius(4)
                        
                        Spacer()
                        
                        
                    }
                    
                    
                }
                
                
                
            }
            .padding(8)
            .background(CColors.CardBGColor)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 5)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        }.padding(8)
            .navigationTitle("Election History")
            .navigationBarHidden(false)
    }
}


struct ElectionHistoryCandidateRowCandidate: View {
    
    @Binding public var item : ElectionCandidateResultDetails
    
    
    var body: some View {
        ZStack{
            HStack(spacing: 16) {
                VStack{
                    HStack{
                        Image("default_large_image")
                            .resizable().scaledToFill()
                            .frame(width: 40, height: 40 )
                            .cornerRadius(20)
                            .padding(0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        
                        
                        VStack(alignment: .leading) {

                            Text(item.electType! + " ("  + item.electYear! + ")")
                                .foregroundColor(.gray)
                            
                            Text(item.constituency ?? "-")
                                .font(.headline).foregroundColor(Color.blue).underline()

                            
                            
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("Total Votes").font(.system(size: 14)).padding(.bottom,-7)
                            VStack{
                                Text(item.votescand ?? "0")
                                    .font(.headline).padding(8)
                            }.background(CColors.TextInputBgColor)
                            
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                            
                            
                            
                        }
                    }
                    Divider()
                    HStack{
                        
                        HStack{
                            Image("batch")
                                .resizable().scaledToFill()
                                .frame(width: 30, height: 30 )
                                .padding(.top, 4).padding(.leading,8).padding(.bottom,4)
                            
                            Text(
                                
                                item.position == "1" ? "Won" : "Lost"
                                    
                                
                            ).font(.system(size: 18)).bold()
                                .foregroundColor(.white).padding(.trailing,50)
                        }.background(
                            item.position == "1" ? CColors.MainThemeColor : .red
                             
                            
                            
                        ).cornerRadius(4)
                        
                        Spacer()
                        
                        
                    }
                    
                    
                }
                
                
                
            }
            .padding(8)
            .background(CColors.CardBGColor)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 5)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        }.padding(8)
            .navigationTitle("Election History")
            .navigationBarHidden(false)
    }
}




struct ElectionHistoryListScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ElectionHistoryListScreenView( title: "")
            .preferredColorScheme(.light)
    }
}

