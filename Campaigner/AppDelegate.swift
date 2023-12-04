//
//  AppDelegate.swift
//  Campaigner
//
//  Created by Osama Usmani on 28/10/2023.
//

import SwiftUI
import GoogleMaps
import Firebase
import GoogleSignIn
import FBSDKCoreKit


//class AppDelegate: ObservableObject {
//    init() {
//        GMSServices.provideAPIKey("AIzaSyCojkH-SLSkXaZgy_mywsy9AgbHqTEi-a4")
//        // Other app setup if needed
//    }
//}


class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject  {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Settings.shared.appID = "1077346733630579" //fb app id
        FBSDKCoreKit.ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        
        FirebaseApp.configure()
        GMSServices.provideAPIKey("AIzaSyCojkH-SLSkXaZgy_mywsy9AgbHqTEi-a4")
        return true
    }
    
    func application(_ app: UIApplication,
                     open url : URL, options: [UIApplication.OpenURLOptionsKey : Any]? = nil) -> Bool {
        
        return GIDSignIn.sharedInstance.handle(url)
    }
    
    

}
