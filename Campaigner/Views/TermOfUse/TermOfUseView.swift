//
//  TermOfUseView.swift
//  Campaigner
//
//  Created by Macbook  on 03/11/2023.
//

import SwiftUI

struct TermOfUseView: View {
    @State private var isShowingLoader = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var alertService = AlertService()
    
    @State private var termOfUseResponse: TermOfUseResponse?

    @State  var tosData = ""
    
    var body: some View {
        VStack{
            CustomNavBarBack(title: "Term of Conditions")
            VStack {
                HTMLTextView(htmlString: $tosData)
                    .padding(4)
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading).padding(.top,-60)

            
 
        }.navigationBarHidden(true)
        
            .onAppear {
                getTermOfUse()
            }
        
    }
    
    func getTermOfUse() {
        isShowingLoader.toggle()
        let parameters: [String: Any] = [
            "plattype": Global.PlatType,
            "type": 1,
        ]
        let lookUpViewModel = LookupsViewModel()
        lookUpViewModel.TermOfUse(parameters: parameters) { result in
            isShowingLoader.toggle()
            switch result {
            case .success(let lookupresponse):
                tosData = lookupresponse.data[0].terms
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct TermOfUseView_Previews: PreviewProvider {
    static var previews: some View {
        TermOfUseView()
    }
}
