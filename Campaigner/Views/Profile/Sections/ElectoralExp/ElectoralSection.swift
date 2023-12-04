//
//  ElectoralSection.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/05/2023.
//

import Foundation
import SwiftUI
import Alamofire
import AlertToast
import SwiftAlertView

struct ElectoralSection: View {
    @State var isNoRecordFound = true
    @State var isElectoralExpAddActive = false
    
    @State var listItems = [ElectoralExpResponseItem]()
    @State var selectedItem : ElectoralExpResponseItem?
    
    
    var body: some View {
        
        VStack {
            NavigationLink(destination: ElectoralExpAdd(), isActive: $isElectoralExpAddActive) {
            }
            if isNoRecordFound{
                VStack{
                    NoRecordView(recordMsg: "Please provide information if you have contested any elections in the past.")
                }
            }
            else{
                ScrollView{
                    ForEach(listItems.indices, id: \.self) { index in
                        CardViewElectoralExp(item:$listItems[index], getData: GetData)
                    }
                }
            }
            AddButton(action: {isElectoralExpAddActive.toggle()}, label:  "Add")
        }.onAppear{
            GetData()
        }
    }
    
    
    func GetData(){
        isNoRecordFound = true
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
        ]
        let ViewModel = ProfileViewModel()
        ViewModel.ElectoralExpList(parameters: parameters ) { result in
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
    
    
    struct CardViewElectoralExp: View {
        @Binding public var item : ElectoralExpResponseItem
        var getData: () -> Void
        @State public var  isEditActive  = false
        
        var body: some View {
            HStack {
                NavigationLink(destination: ElectoralExpAdd(isEdit: true, recordItem: item),  isActive: $isEditActive) {
                }
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text("Party")
                            .font(.headline)
                            .foregroundColor(.black).frame(maxWidth: 100,  alignment: .leading) .multilineTextAlignment(.leading)
                        Spacer()
                        Text(item.party_name!)
                            .font(.body).frame(maxWidth: .infinity,  alignment: .leading)
                    }
                    
                    HStack {
                        Text("Constituencey")
                            .font(.headline)
                            .foregroundColor(.black).frame(maxWidth: 100,  alignment: .leading) .multilineTextAlignment(.leading)
                        Spacer()
                        Text(item.constituency!)
                            .font(.body).frame(maxWidth: .infinity,  alignment: .leading)
                    }
                    
                    HStack {
                        Text("Year")
                            .font(.headline)
                            .foregroundColor(.black).frame(maxWidth: 100,  alignment: .leading) .multilineTextAlignment(.leading)
                        Text(item.elect_year!)
                            .font(.body).frame(maxWidth: .infinity,  alignment: .leading)
                    }
                    HStack {
                        Text("Positions")
                            .font(.headline)
                            .foregroundColor(.black).frame(maxWidth: 100,  alignment: .leading) .multilineTextAlignment(.leading)
                        Text(String(item.elect_position!))
                            .font(.body).frame(maxWidth: .infinity,  alignment: .leading)
                    }
                    
                    HStack {
                        Text("Votes")
                            .font(.headline)
                            .foregroundColor(.black).frame(maxWidth: 100,  alignment: .leading) .multilineTextAlignment(.leading)
                        Text(String(item.elect_vote!))
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
                            Text("Edit").font(.system(size: 13))
                                .foregroundColor(.white).padding(.trailing,4)
                        }
                    }.frame(width:80).background(Color.green)
                        .cornerRadius(8)
                    
                    Button(action: {
                        SwiftAlertView.show(title: "Alert",
                                            message: "Are you sure you want to delete this record?",
                                            buttonTitles: "Cancel", "OK")
                        .onButtonClicked { _, buttonIndex in
                            if buttonIndex == 1 {
                                DeleteItem(id: item.id_text!)
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "trash")
                                .foregroundColor(.white)
                                .frame(width:24, height: 24)
                            Spacer()
                            Text("Delete").font(.system(size: 13))
                                .foregroundColor(.white).padding(.trailing,4)
                        }
                    }.frame(width: 80).background(Color.red)
                        .cornerRadius(8)
                    
                    Spacer()
                }.padding(.top,4).padding(.trailing,4)
            }
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            .shadow(radius: 1)
            .padding(6)
        }
        
        func DeleteItem(id: String){
            let parameters: [String:Any] = [
                "plattype": Global.PlatType,
                "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
                "record_id":id
            ]
            let ViewModel = ProfileViewModel()
            ViewModel.ElectoralExpDelete(parameters: parameters ) { result in
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



struct ElectoralSection_Previews: PreviewProvider {
    static var previews: some View {
        ElectoralSection()
    }
}
