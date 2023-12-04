//
//  LoginViewModel.swift
//  Campaigner
//
//  Created by Osama Usmani on 23/05/2023.
//

import Foundation
import Alamofire
import SwiftUI

class LoginViewModel: ObservableObject {
    
    func loginRequest(parameters: Parameters?, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.Login
        NetworkManager.shared.Request(url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func loginSocialRequest(parameters: [String:Any]?, completion:  @escaping (Result<LoginResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.Register
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    
}
