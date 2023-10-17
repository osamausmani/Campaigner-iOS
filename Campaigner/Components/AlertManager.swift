//
//  AlertManager.swift
//  Campaigner
//
//  Created by Macbook  on 06/06/2023.
//


//import SwiftUI
//
//class AlertService: ObservableObject {
//    @Published var showAlert = false
//    @Published var alertContent: AlertContent?
//
//    func show(title: String, message: String) {
//        alertContent = AlertContent(title: title, message: message)
//        showAlert = true
//    }
//
//    struct AlertContent {
//        let title: String
//        let message: String
//
//
//    }
//}


import SwiftUI

class AlertService: ObservableObject {
    @Published var showAlert = false
    @Published var alertContent: AlertContent?
    var onDismiss: (() -> Void)?
    
    func show(title: String, message: String, onDismiss: (() -> Void)? = nil) {
        alertContent = AlertContent(title: title, message: message)
        self.onDismiss = onDismiss
        showAlert = true
    }
    
    struct AlertContent {
        let title: String
        let message: String
    }
}

