//
//  RegisterViewModel.swift
//  Campaigner
//
//  Created by Osama Usmani on 23/05/2023.
//

import Foundation
import Alamofire

class RegisterViewModel: ObservableObject {
    
    func registerNewAccountRequest(parameters: [String:Any]?, completion:  @escaping (Result<BaseResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.Register
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
}
