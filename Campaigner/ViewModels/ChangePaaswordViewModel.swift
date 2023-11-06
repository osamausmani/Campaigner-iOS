//
//  ChangePaaswordViewModel.swift
//  Campaigner
//
//  Created by Macbook  on 03/11/2023.
//

import Foundation
import Alamofire

class ChangePasswordViewModel: ObservableObject {
    
    func ChangePasswordRequest(parameters: [String:Any]?, completion:  @escaping (Result<BaseResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.changePassword
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
}
