//
//  BaseView.swift
//  Campaigner
//
//  Created by Osama Usmani on 23/05/2023.
//

import Foundation
import SwiftUI

struct BaseView: View {
    
    
    @StateObject public var alertService:AlertService
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View
    {
        VStack{}.alert(isPresented: $alertService.showAlert) {
            Alert(title: Text(alertService.alertContent?.title ?? ""), message: Text(alertService.alertContent?.message ?? ""), dismissButton: .default(Text("OK")){alertService.onDismiss})
        }
        
    }
    

    
}

