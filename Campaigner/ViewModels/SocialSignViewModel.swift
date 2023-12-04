//
//  SocialSignViewModel.swift
//  Campaigner
//
//  Created by Osama Usmani on 24/11/2023.
//

import Foundation
import SwiftUI
import GoogleSignIn
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit


class SocialSignViewModel: ObservableObject {
    
    @Published var isLogin: Bool = false
    @Published var errorMessage: String?

    // Define a callback type
    typealias GoogleSignInCallback = (Result<(email: String, accessToken: String), Error>) -> Void
    
    // Add a callback parameter to the function
    func signUpWithGoogle(callback: @escaping GoogleSignInCallback) {
        guard let clientId = FirebaseApp.app()?.options.clientID else {
            callback(.failure(NSError(domain: "YourDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Missing client ID"])))
            return
        }
        
        let config = GIDConfiguration(clientID: clientId)
        
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: ApplicationUtility.rootViewController) { user, error in
            if let error = error {
                // Call the callback with an error if there's an issue
                callback(.failure(error))
                return
            }
            
            guard
                let idToken = user?.user.idToken?.tokenString,
                let accessToken = user?.user.accessToken.tokenString
            else {
                callback(.failure(NSError(domain: "YourDomain", code: 2, userInfo: [NSLocalizedDescriptionKey: "Missing ID token or access token"])))
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
            Auth.auth().signIn(with: credential) { [self] authResult, error in
                if let error = error {
                    // Call the callback with an error if there's an issue
                    callback(.failure(error))
                    return
                }
                
                guard let user = authResult?.user else {
                    callback(.failure(NSError(domain: "YourDomain", code: 3, userInfo: [NSLocalizedDescriptionKey: "Failed to get user information"])))
                    return
                }
                
                // Call the callback with the user's email and access token on success
                let result = (email: user.email ?? "", accessToken: idToken)
                callback(.success(result))
                isLogin.toggle()
            }
        }
    }
    
    
    
    
    // Define a callback type
       typealias FacebookSignInCallback = (Result<(accessToken: AccessToken, email: String), Error>) -> Void
    // Add a callback parameter to the signInWithFacebook function
        func signInWithFacebook(callback: @escaping FacebookSignInCallback) {
            LoginManager().logIn(permissions: ["public_profile", "email"], from: nil) { result, error in
                if let error = error {
                    self.errorMessage = "Facebook login failed: \(error.localizedDescription)"
                    callback(.failure(error))
                    return
                }

                guard let result = result else {
                    self.errorMessage = "Facebook login failed: No result"
                    callback(.failure(NSError(domain: "YourDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "No result"])))
                    return
                }

                if result.isCancelled {
                    self.errorMessage = "Facebook login was cancelled"
                    callback(.failure(NSError(domain: "YourDomain", code: 2, userInfo: [NSLocalizedDescriptionKey: "Login cancelled"])))
                } else {
                    self.fetchFacebookProfile(callback: callback)
                }
            }
        }

        // Update fetchFacebookProfile to include the callback parameter
        func fetchFacebookProfile(callback: @escaping FacebookSignInCallback) {
            let connection = GraphRequestConnection()
            connection.add(GraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"])) { httpResponse, result, error in
                if let error = error {
                    self.errorMessage = "Failed to fetch Facebook profile: \(error.localizedDescription)"
                    callback(.failure(error))
                    return
                }

                guard let result = result as? [String: Any] else {
                    self.errorMessage = "Failed to parse Facebook profile result"
                    callback(.failure(NSError(domain: "YourDomain", code: 3, userInfo: [NSLocalizedDescriptionKey: "Failed to parse profile result"])))
                    return
                }

                if let email = result["email"] as? String {
                    print("Facebook login successful. Email: \(email)")

                    // Retrieve the access token
                    guard let accessToken = AccessToken.current else {
                        callback(.failure(NSError(domain: "YourDomain", code: 4, userInfo: [NSLocalizedDescriptionKey: "Access token not found"])))
                        return
                    }

                    // Call the callback with the access token and email on success
                    let result = (accessToken: accessToken, email: email)
                    callback(.success(result))
                    self.isLogin = true
                }
            }
            connection.start()
        }
}
