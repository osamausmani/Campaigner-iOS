//
//  PoliticalPartyAdd.swift
//  Campaigner
//
//  Created by Osama Usmani on 04/11/2023.
//

import Foundation
import SwiftUI
import SwiftAlertView

struct PoliticalPartyAdd: View {
    
    @State private var selectedParty = DropDownModel()
    @State private var partyOptions: [DropDownModel] = []
    @State private var isShowingLoader = false
    
    @State  var dateFromObj = Date()
    @State  var dateFrom = ""
    @State  var dateTo = ""
    @State  var dateToObj = Date()
    
    @State  var minimumDate = Date()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var isEdit = false
    var recordItem :ListPoliticalResponseData?
    
    
    var body: some View {
        ZStack{
            Image("splash_background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                CustomNavBarBack(title: "Political Career")
                ScrollView{
                    VStack{
                        HStack{
                            VStack {
                                DropDown(label: "Party", placeholder: "Select Political Party", isMandatory: true, selectedObj:  $selectedParty, menuOptions: partyOptions )
                                HStack{
                                    DataPicker(label: "From", placeholder: "From", selectedDate:$dateFromObj, sDate: $dateFrom, minimumDate: $minimumDate )
                                    DataPicker(label: "To", placeholder: "To", selectedDate: $dateToObj, sDate: $dateTo, minimumDate: $dateFromObj  )
                                }
                                MainButton(action: SubmitAction, label:  isEdit ? "Update" : "Add").padding(.top,20)
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
            minimumDate = getDateForYear(1973)!
            
            if(isEdit){
                selectedParty = DropDownModel(id: (recordItem?.party_id)!, value: (recordItem?.party_name)!)
                dateFrom = (recordItem?.exp_from)!
                dateTo = (recordItem?.exp_to)!
            }
            
        }

    }
    
    
    public func getDateForYear(_ year: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = 1
        dateComponents.day = 1
        let calendar = Calendar.current
        return calendar.date(from: dateComponents)
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
    
    func SubmitAction(){
        
        if selectedParty.id == nil{
            SwiftAlertView.show(title: "Alert", message: "Party Selection is Required", buttonTitles: "OK")
        }
        
        if dateFrom == ""{
            SwiftAlertView.show(title: "Alert", message: "From Date is Required", buttonTitles: "OK")
        }
        
        if dateTo == ""{
            SwiftAlertView.show(title: "Alert", message: "To Date is Required", buttonTitles: "OK")
        }else{
            
            isEdit ? UpdatePartyInfo() : AddPartyInfo()
            
            
        }
        
        
        
    }
    
    func AddPartyInfo(){
        
        isShowingLoader.toggle()
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "from_date": dateFrom,
            "to_date": dateTo,
            "party_id": selectedParty.id,
        ]
        let ViewModel = ProfileViewModel()
        ViewModel.PoliticalCareerAdd(parameters: parameters ) { result in
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
    
    func UpdatePartyInfo(){
        
        isShowingLoader.toggle()
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "from_date": dateFrom,
            "to_date": dateTo,
            "party_id": selectedParty.id,
            "record_id": (recordItem?.record_id)!
            
        ]
        let ViewModel = ProfileViewModel()
        ViewModel.PoliticalCareerUpdate(parameters: parameters ) { result in
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

struct PoliticalPartyAdd_Previews: PreviewProvider {
    static var previews: some View {
        PoliticalPartyAdd( )
    }
}
