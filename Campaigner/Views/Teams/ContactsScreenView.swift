//
//  ContactsScreenView.swift
//  Halka
//
//  Created by Osama Usmani on 30/11/2023.
//

import Foundation
import SwiftUI
import Contacts
import SwiftAlertView

struct ContactsScreenView: View {
    @State private var contacts: [PhoneContact] = []
    
    var body: some View {
        ZStack(alignment: .top){
            
            VStack{
                
                CustomNavBarBack(title: "Contacts")
                
                VStack(){
                    
                    ScrollView{
                        ForEach(contacts.indices, id: \.self) { index in
                            HStack{
                                VStack{
                                    HStack{
                                        VStack{
                                            HStack{
                                                Text(contacts[index].name).bold()                        .font(.headline)
                                                Spacer()
                                            }
                                            HStack{
                                                Text(contacts[index].number)
                                                Spacer()
                                            }
                                        }
                                        
                                        Spacer()
                                        VStack{
                                            Button(action: {
                                                InviteMember(index: index)
                                            }) {
                                                Image(systemName: "plus.circle.fill")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(CColors.MainThemeColor)
                                            }
                                        }
                                    }
                                    Divider().background(.black)
                                    
                                }.padding(8)
                            }.background(CColors.CardBGColor)
                        }
                    }
                    
                }
                
            }.background(CColors.CardBGColor).frame(maxHeight: .infinity).edgesIgnoringSafeArea(.top)
            
            
            
            
            
            
        }.frame(maxHeight: .infinity).navigationBarHidden(true).onAppear {
                        fetchContacts()
            
//            contacts.append(PhoneContact(id:UUID() , name: "Osama", number: "03168318248"))
//            contacts.append(PhoneContact(id:UUID() , name: "Talha", number: "03168318248"))
        }
    }
    
    func fetchContacts() {
        let store = CNContactStore()
        
        // Request access to contacts
        store.requestAccess(for: .contacts) { granted, error in
            if granted {
                // Fetch keys (e.g., name and phone number)
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                
                // Fetch request
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                do {
                    try store.enumerateContacts(with: request) { contact, _ in
                        // Process each contact
                        let name = "\(contact.givenName) \(contact.familyName)"
                        if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
                            let newContact = PhoneContact(id: UUID(), name: name, number: phoneNumber)
                            contacts.append(newContact)
                        }
                    }
                } catch {
                    print("Error fetching contacts: \(error)")
                }
            } else {
                print("Access denied")
            }
        }
    }
    
    
    func InviteMember(index:Int){
        
        let parameters: [String:Any] = [
            "plattype": Constants.PLAT_TYPE,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "user_full_name": contacts[index].name,
            "user_msisdn": contacts[index].number,
            
        ]
        
        let RequestModel =  InviteViewModel()
        
        RequestModel.InviteMemberRequest(parameters: parameters ) { result in
            switch result {
            case .success(let response):
                if response.rescode == 1 {
                    SwiftAlertView.show(title: "Alert", message: response.message, buttonTitles: "OK")
                    contacts.remove(at: index)
                }else{
                    SwiftAlertView.show(title: "Alert", message: response.message, buttonTitles: "OK")                }
            case .failure(let error):
                SwiftAlertView.show(title: "Alert", message: error.localizedDescription, buttonTitles: "OK")            }
        }
    }
}

struct ContactsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsScreenView()
    }
}

struct PhoneContact: Identifiable {
    var id: UUID
    var name: String
    var number: String
}
