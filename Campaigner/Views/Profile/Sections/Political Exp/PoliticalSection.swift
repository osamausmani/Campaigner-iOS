//
//  PoliticalSection.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/05/2023.
//

import Foundation
import SwiftUI
import Alamofire
import AlertToast
import SwiftAlertView

struct PoliticalSection: View {
    @State var isNoRecordFound = false
    @State var isPoliticalPartyAddActive = false
    
    @State var listItems = [ListPoliticalResponseData]()
    @State var selectedItem : ListPoliticalResponseData?
    
    var body: some View {
        
        
        
        
        VStack {
            
            NavigationLink(destination: PoliticalPartyAdd(), isActive: $isPoliticalPartyAddActive) {
            }
            
            if isNoRecordFound{
                VStack{
                    NoRecordView(recordMsg: "Please provide details if you have been, or are, a part of any political party.")
                }
            }
            else{
                ScrollView{
                    ForEach(listItems.indices, id: \.self) { index in
                        CardViewPoliticalCareer(item:$listItems[index], getData: GetCareerData)
                    }
                }
            }
            
            AddButton(action: {isPoliticalPartyAddActive.toggle()}, label:  "Add")
        }.onAppear{
            GetCareerData()
        }
    }
    
    func GetCareerData(){
        isNoRecordFound = true
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
        ]
        let ViewModel = ProfileViewModel()
        ViewModel.PoliticalCareerList(parameters: parameters ) { result in
            switch result {
            case .success(let response ):
                if response.rescode == 1 {
                
                    listItems.removeAll()
                    
                    listItems = response.data ?? []
                    isNoRecordFound = false
                }else{
                    listItems.removeAll()
                }
            case .failure(let error):
                SwiftAlertView.show(title: "Alert", message: error.localizedDescription, buttonTitles: "OK")
            }
        }
    }
    

    
    
    struct CardViewPoliticalCareer: View {
        @Binding public var item : ListPoliticalResponseData
        var getData: () -> Void
        @State public var  isEditActive  = false

        var body: some View {
            HStack {
                NavigationLink(destination: PoliticalPartyAdd(isEdit: true, recordItem: item),  isActive: $isEditActive) {
                }
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("Name")
                            .font(.headline)
                            .foregroundColor(.black).frame(maxWidth: 50,  alignment: .leading) .multilineTextAlignment(.leading)
                        Spacer()
                        Text(item.party_name!)
                            .font(.body).frame(maxWidth: .infinity,  alignment: .leading)
                    }
                    
                    HStack {
                        Text("From")
                            .font(.headline)
                            .foregroundColor(.black).frame(maxWidth: 50,  alignment: .leading) .multilineTextAlignment(.leading)
                        Spacer()
                        Text(DateFormatterHelper().formatDateStringYMD(item.exp_from ?? "")!)
                            .font(.body).frame(maxWidth: .infinity,  alignment: .leading)
                    }
                    
                    HStack {
                        Text("To")
                            .font(.headline)
                            .foregroundColor(.black).frame(maxWidth: 50,  alignment: .leading) .multilineTextAlignment(.leading)
                        Text(DateFormatterHelper().formatDateStringYMD(item.exp_to ?? "")!)
                            .font(.body).frame(maxWidth: .infinity,  alignment: .leading)
                    }
                }
                .padding()
                
                Spacer()
                
                // Action Buttons Column
                VStack(spacing: 4) {
                    
                    Button(action: {
                        isEditActive.toggle()
                    }) {
                        HStack {
                            Image(systemName: "pencil")
                                .foregroundColor(.white)
                                .frame(width: 24, height: 24)
                            Spacer()
                            Text("Edit")
                                .foregroundColor(.white).padding(.trailing,8)
                        }
                    }.frame(width: 90).background(Color.green)
                        .cornerRadius(8)
                    
                    Button(action: {
                        SwiftAlertView.show(title: "Alert",
                                            message: "Are you sure to delete this record?",
                                            buttonTitles: "Cancel", "OK")
                        .onButtonClicked { _, buttonIndex in
                            if buttonIndex == 1 {
                                DeleteCareerItem(careerID: item.record_id!)
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "trash")
                                .foregroundColor(.white)
                                .frame(width: 24, height: 24)
                            Spacer()
                            Text("Delete")
                                .foregroundColor(.white).padding(.trailing,8)
                        }
                    }.frame(width: 90).background(Color.red)
                        .cornerRadius(8)
                }
            }
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            .shadow(radius: 1)
            .padding(6)
        }
        
        func DeleteCareerItem(careerID: String){
            let parameters: [String:Any] = [
                "plattype": Global.PlatType,
                "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
                "record_id":careerID
            ]
            let ViewModel = ProfileViewModel()
            ViewModel.PoliticalCareerDelete(parameters: parameters ) { result in
                switch result {
                case .success(let response ):
                    if response.rescode == 1 {
                        getData()
                    }else{
                        SwiftAlertView.show(title: "Alert", message: response.message, buttonTitles: "OK")
                    }
                case .failure(let error):
                    SwiftAlertView.show(title: "Alert", message: error.localizedDescription, buttonTitles: "OK")
                }
            }
        }
        
        
    }
    

    
    
    
}






struct PoliticalSection_Previews: PreviewProvider {
    static var previews: some View {
        PoliticalSection()
    }
}
