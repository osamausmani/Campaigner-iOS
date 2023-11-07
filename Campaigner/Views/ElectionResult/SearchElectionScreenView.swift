//
//  Election.swift
//  Campaigner
//
//  Created by Macbook  on 13/06/2023.
//



import SwiftUI
import Alamofire

struct SearchElectionScreenView: View {
    
    @State private var selectedOption = DropDownModel()
    @State private var selectedYear = DropDownModel()
    @State private var selectedAssembly = DropDownModel()
    @State private var selectedConstituency = DropDownModel()
    @State private var selectedCandidate = DropDownModel()
    @State private var isShowingLoader = false
    @State private var isLoading = false
    @State private var selectedOptionTitle = "Election History"
    @State private var isCandidateSelected = false
    @State private var isConstituencySelected = false

    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var alertService = AlertService()
    
    var optionList: [DropDownModel] = [
        DropDownModel(id: "0", value: "By Constituency"),
        DropDownModel(id: "1", value: "By Candidate"),
    ]

    var assemblyList: [DropDownModel] = [
        DropDownModel(id: "1", value: "National Assembly"),
        DropDownModel(id: "2", value: "Punjab"),
        DropDownModel(id: "3", value: "Sindh"),
        DropDownModel(id: "4", value: "Balochistan"),
        DropDownModel(id: "5", value: "Khyber Pakhtunkhwa"),
    ]
        
    var electionYearList: [DropDownModel] = [
        DropDownModel(id: "1", value: "2018"),
    ]

    
    @State var constituencyList = [DropDownModel]()
    @State var candidateList = [DropDownModel]()
    
    
    @State private var isElectionHistoryListScreenViewActive = false
    
    
    var body: some View {
        
        
        
        ZStack {
            NavigationLink(destination: ElectionHistoryListScreenView(selectedOption: selectedOption.id, selectedConstituenceyID: selectedConstituency.id, selectedCandidateID: selectedCandidate.id, title: selectedOptionTitle), isActive: $isElectionHistoryListScreenViewActive) {
            }
            ZStack{
                ZStack{
                    Image("splash_background")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                }
                ScrollView{
                    VStack {
                        
                        DropDown(label: "Select Option", placeholder: "Select Option", selectedObj:  $selectedOption, menuOptions: optionList )
                        
                        if selectedOption.id == "0"{
                            DropDown(label: "Election Year", placeholder: "Select Election Year", selectedObj:  $selectedYear, menuOptions: electionYearList )
                            
                            DropDown(label: "Assembly", placeholder: "Select Assembly", selectedObj:  $selectedAssembly, menuOptions: assemblyList )
                            
                            SearchableDropDown(label: "Constituency", placeholder: "Select Constituency", selectedObj:  $selectedConstituency, menuOptions: constituencyList )
                            
                            
                            
                        }
                        if selectedOption.id == "1"{
                            
                            SearchableDropDown(label: "Candidate", placeholder: "Select Candidate", selectedObj:  $selectedCandidate, menuOptions: candidateList )
                        }
                        
                        
                        Spacer()
                        
                        if selectedOption.id == "0" || selectedOption.id == "1"  {
                            MainButton(action: {
                                clearStates()
                                SearchAction()
                            }, label: "Search").padding(.top,5)
                        }
                        
                    }.padding(16)
                    
                    
                }
                
            }
            
            
        } .onChange(of: selectedAssembly) { newValue in
            constituencyList.removeAll()
            GetConstituencies()
            
        }
        .onChange(of: selectedOption) { newValue in
            if selectedOption.id == "1" {
                GetCandidates()
            }
            
            
        }
        
        
        
        .offset(y: kGuardian.slide).animation(.easeInOut(duration: 1.0))
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        
        .navigationBarHidden(false)
        .navigationTitle("Election")
        
        .overlay(
            Group {
                if isLoading {
                    ProgressHUDView()
                }
            }
        )
        
    }
    
    func GetConstituencies(){
        let parameters: [String:Any] = [
            "target": "constituency",
            "action": "liststatsbyassembly",
            "id": selectedAssembly.id,
        ]
        let ViewModel = LookupsViewModel()
        ViewModel.ListVoterConstituency(parameters: parameters ) { result in
            switch result {
            case .success(let response ):
                let newOptions = response.data?.map { data in
                    DropDownModel(id: (data.constituency_id!), value: (data.name!))
                }
                constituencyList.append(contentsOf: newOptions!)
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    func GetCandidates(){
        let parameters: [String:Any] = [
            "target": "politician",
            "action": "listbylimit",
        ]
        let ViewModel = LookupsViewModel()
        ViewModel.ListVoterCandidates(parameters: parameters ) { result in
            switch result {
            case .success(let response ):
                let newOptions = response.data?.map { data in
                    DropDownModel(id: (data.id!), value: (data.fullname!))
                }
                candidateList.append(contentsOf: newOptions!)
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    
    
    
    
    
    func SearchAction() {
        if selectedOption.id == "0" {
            isCandidateSelected = false
            isConstituencySelected = true
            selectedOptionTitle = "Election History - Constituency"
        } else if selectedOption.id == "1" {
            isCandidateSelected = true
            isConstituencySelected = false
            selectedOptionTitle = "Election History - Candidate"
        }
        isElectionHistoryListScreenViewActive.toggle()
    }

    
    func clearStates() {
        selectedOption = DropDownModel()
        selectedYear = DropDownModel()
        selectedAssembly = DropDownModel()
        selectedConstituency = DropDownModel()
        selectedCandidate = DropDownModel()
        isShowingLoader = false
        isLoading = false
        constituencyList.removeAll()
        candidateList.removeAll()
    }

    
    
    
    
}

struct Election_Previews: PreviewProvider {
    static var previews: some View {
        SearchElectionScreenView()
    }
}
