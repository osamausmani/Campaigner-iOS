//
//  LogoutViewModel.swift
//  Campaigner
//
//  Created by Macbook  on 06/06/2023.
//

import Foundation
import Alamofire
import SwiftUI

class LogoutViewModel: ObservableObject {
    
    func loginoutRequest(parameters: Parameters?, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.LoginOut
        NetworkManager.shared.Request(url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    
    
}
