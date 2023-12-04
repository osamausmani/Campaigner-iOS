//
//  ElectoralExpAdd.swift
//  Campaigner
//
//  Created by Osama Usmani on 04/11/2023.
//


import Foundation
import SwiftUI
import SwiftAlertView

struct ElectoralExpAdd: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var isShowingLoader = false
    @State public var isEdit = false
    var recordItem :ElectoralExpResponseItem?
    
    
    
    @State private var partyOptions: [DropDownModel] = []
    private let yearsOption: [DropDownModel] = {
        var yearsArray: [DropDownModel] = []
        
        for year in 1996...2023 {
            let yearString = String(year)
            let dropDownModel = DropDownModel(id: yearString, value: yearString)
            yearsArray.append(dropDownModel)
        }
        
        return yearsArray
    }()
    private let electionTypeOptions: [DropDownModel] = [
        DropDownModel(id: "1", value: "General Election"),
        DropDownModel(id: "2", value: "By Election"),
        DropDownModel(id: "3", value: "Other"),
    ]
    private let assemblyOptions: [DropDownModel] = [
        DropDownModel(id: "1", value: "National Assembly"),
        DropDownModel(id: "2", value: "Provincial Assembly"),
    ]
    
    @State private var constituenceyOptions: [DropDownModel] = []
    private let positionOptions: [DropDownModel] = [
        DropDownModel(id: "1", value: "1st"),
        DropDownModel(id: "2", value: "2nd"),
        DropDownModel(id: "3", value: "3rd"),
    ]
    
    @State public var inputVotes = ""
    @State private var selectedParty = DropDownModel()
    @State private var selectedYear = DropDownModel()
    @State private var selectedElectionType = DropDownModel()
    @State private var selectedAssemblyType = DropDownModel()
    @State private var selectedConstituencey = DropDownModel()
    @State private var selectedPositions = DropDownModel()
    
    
    var body: some View {
        
        
        ZStack{
            Image("splash_background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                CustomNavBarBack(title: "Electoral Experience")
                ScrollView{
                    VStack{
                        HStack{
                            VStack {
                                
                                DropDown(label: "Party", placeholder: "Select Party", isMandatory: true, selectedObj:  $selectedParty, menuOptions: partyOptions )
                                
                                DropDown(label: "Election Year", placeholder: "Select Election Year", isMandatory: true, selectedObj:  $selectedYear, menuOptions: yearsOption )
                                
                                DropDown(label: "Election Type", placeholder: "Select Election Type", isMandatory: true, selectedObj:  $selectedElectionType, menuOptions: electionTypeOptions )
                                
                                DropDown(label: "Assembly/Area", placeholder: "Select Assembly/Area", isMandatory: true, selectedObj:  $selectedAssemblyType, menuOptions: assemblyOptions )
                                
                                SearchableDropDown(label: "Constituency", placeholder: "Select Constituency", selectedObj:  $selectedConstituencey,menuOptions: constituenceyOptions, isMandatory: true )
                                
                                DropDown(label: "Position", placeholder: "Select Position", isMandatory: true, selectedObj:  $selectedPositions, menuOptions: positionOptions )
                                
                                
                                FormInputField(label: "Total Votes", placeholder: "E.g. 1234 ", isMandatory: true, text: $inputVotes)
                                
                                MainButton(action: SubmitAction, label: isEdit ? "Update" :  "Add").padding(.top,20)
                                
                                
                            }.frame(width: .infinity, height: .infinity).padding(10)
                            
                        }.background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                        )
                        Spacer()
                    }.padding(10)
                }
            }
            if isShowingLoader {
                Loader(isShowing: $isShowingLoader)
                    .edgesIgnoringSafeArea(.all)
            }
            
        }.ignoresSafeArea(.all) .navigationBarHidden(true).onAppear{
            LoadPartyData()
            if(isEdit){
                selectedParty = DropDownModel(id: (recordItem?.elect_party)!, value: (recordItem?.party_name)!)
                selectedYear = DropDownModel(id: (recordItem?.elect_year)!, value: (recordItem?.elect_year)!)
                
                if let assemType = recordItem?.elect_assembly {
                    let electTypeString = String(assemType)
                    selectedAssemblyType = assemblyOptions.first { $0.id == electTypeString }!
                }
                
                if let electType = recordItem?.elect_type {
                    let electTypeString = String(electType)
                    selectedElectionType = electionTypeOptions.first { $0.id == electTypeString }!
                }
                
                
                if let electAssembly = recordItem?.elect_assembly {
                    let assemString = String(electAssembly)
                    selectedAssemblyType = assemblyOptions.first { $0.id == assemString }!
                }
                selectedConstituencey = DropDownModel(id: (recordItem?.constituency_id)!, value: (recordItem?.constituency)!)
                
                if let electPos = recordItem?.elect_position {
                    let electPosString = String(electPos)
                    selectedPositions = positionOptions.first { $0.id == electPosString }!
                }
                
                if let electVotes = recordItem?.elect_vote {
                    let electVotesString = String(electVotes)
                    inputVotes = electVotesString
                }
            
            }
            
        }
        .onChange(of: selectedAssemblyType) { newValue in
            constituenceyOptions.removeAll()
            LoadConstituencies()
            
        }
    }
    
    
    func LoadPartyData(){
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
        ]
        let ViewModel = LookupsViewModel()
        ViewModel.ListParties(parameters: parameters ) { result in
            switch result {
            case .success(let response ):
                if response.rescode == 1 {
                    let newOptions = response.data?.map { data in
                        DropDownModel(id: (data.id_text!), value: (data.party_name!))
                    }
                    partyOptions.append(contentsOf: newOptions!)
                    
                }else{
                    print("")
                }
            case .failure(let error):
                print("")
            }
        }
    }
    
    func LoadConstituencies() {
        var userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!,
            "assembly": selectedAssemblyType.id,
        ]
        let LookupsViewModel = LookupsViewModel()
        LookupsViewModel.ListConstituency(parameters: parameters ) { result in
            switch result {
            case .success(var response):
                if response.rescode == 1
                {
                    let newOptions = response.data?.map { data in
                        DropDownModel(id: (data.id_text!), value: (data.constituency!))
                    }
                    constituenceyOptions.append(contentsOf: newOptions!)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func SubmitAction(){
        isEdit ? UpdateInfo() : AddInfo()
    }
    
    func AddInfo(){
        isShowingLoader.toggle()
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "election_year": selectedYear.id,
            "election_type": selectedElectionType.id,
            "election_assembly": selectedAssemblyType.id,
            "election_constituency": selectedConstituencey.id,
            "election_party": selectedParty.id,
            "election_position": selectedPositions.id,
            "election_vote": inputVotes ?? "0"
        ]
        let ViewModel = ProfileViewModel()
        ViewModel.ElectoralExpAdd(parameters: parameters ) { result in
            isShowingLoader.toggle()
            switch result {
            case .success(let response ):
                if response.rescode == 1 {
                    SwiftAlertView.show(title: "Alert", message: response.message, buttonTitles: "OK")
                    self.presentationMode.wrappedValue.dismiss()
                }else{
                    SwiftAlertView.show(title: "Alert", message: response.message, buttonTitles: "OK")
                }
            case .failure(let error):
                SwiftAlertView.show(title: "Alert", message: error.localizedDescription, buttonTitles: "OK")
            }
        }
    }
    
    func UpdateInfo(){
        isShowingLoader.toggle()
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "election_year": selectedYear.id,
            "election_type": selectedElectionType.id,
            "election_assembly": selectedAssemblyType.id,
            "election_constituency": selectedConstituencey.id,
            "election_party": selectedParty.id,
            "election_position": selectedPositions.id,
            "election_vote": inputVotes ?? "0",
            "record_id" : (recordItem?.id_text)!
        ]
        let ViewModel = ProfileViewModel()
        ViewModel.ElectoralExpUpdate(parameters: parameters ) { result in
            isShowingLoader.toggle()
            switch result {
            case .success(let response ):
                if response.rescode == 1 {
                    SwiftAlertView.show(title: "Alert", message: response.message, buttonTitles: "OK")
                    self.presentationMode.wrappedValue.dismiss()
                }else{
                    SwiftAlertView.show(title: "Alert", message: response.message, buttonTitles: "OK")
                }
            case .failure(let error):
                SwiftAlertView.show(title: "Alert", message: error.localizedDescription, buttonTitles: "OK")
            }
        }
    }
    
    
}

struct ElectoralExpAdd_Previews: PreviewProvider {
    static var previews: some View {
        ElectoralExpAdd()
    }
}
