//
//  AppDelegate.swift
//  Campaigner
//
//  Created by Osama Usmani on 28/10/2023.
//

import SwiftUI
import GoogleMaps

class AppDelegate: ObservableObject {
    init() {
        GMSServices.provideAPIKey("AIzaSyCojkH-SLSkXaZgy_mywsy9AgbHqTEi-a4")
        // Other app setup if needed
    }
}
