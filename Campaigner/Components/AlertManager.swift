//
//  AlertService.swift
//  Campaigner
//
//  Created by Osama Usmani on 23/05/2023.
//

import SwiftUI

class AlertService: ObservableObject {
    @Published var showAlert = false
    @Published var alertContent: AlertContent?
    
    func show(title: String, message: String) {
        alertContent = AlertContent(title: title, message: message)
        showAlert = true
    }
    
    struct AlertContent {
        let title: String
        let message: String
    }
}
