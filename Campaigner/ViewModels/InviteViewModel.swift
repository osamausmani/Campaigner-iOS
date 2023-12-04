//
//  InviteViewModel.swift
//  Campaigner
//
//  Created by Macbook  on 02/11/2023.
//

import Foundation
import Alamofire

class InviteViewModel: ObservableObject {
    
    func InviteMemberRequest(parameters: [String:Any]?, completion:  @escaping (Result<BaseResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.InviteMember
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
}
