//
//  ProfileViewModel.swift
//  Campaigner
//
//  Created by Osama Usmani on 06/10/2023.
//

import Foundation


class ProfileViewModel: ObservableObject {
    
    func GetProfileBasicInfo(parameters: [String:Any]?, completion: @escaping (Result<BasicProfileInfoResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.UserProfileBasicInfo
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    
}
