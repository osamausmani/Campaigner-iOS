//
//  CampaignerApp.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/05/2023.

import SwiftUI
import GoogleMaps




@main
struct CampaignerApp: App {
    @StateObject var appDelegate = AppDelegate()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var socialSignUpVM = SocialSignViewModel()

    var body: some Scene {
        WindowGroup {
            SplashScreenView().environmentObject(socialSignUpVM)
        }
    }
}
