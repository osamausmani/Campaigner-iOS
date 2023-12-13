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
    
    func ProfileBasicInfoUpdate(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.UserProfileInfoUpdate
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    

    
    func PoliticalCareerAdd(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.PoliticalCareerAdd
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func PoliticalCareerList(parameters: [String:Any]?, completion: @escaping (Result<ListPoliticalResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.PoliticalCareerList
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func PoliticalCareerDelete(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.PoliticalCareerDelete
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func PoliticalCareerUpdate(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.PoliticalCareerUpdate
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func ElectoralExpAdd(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.ElectoralExpAdd
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    func ElectoralExpUpdate(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.ElectoralExpUpdate
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    func ElectoralExpDelete(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.ElectoralExpDelete
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    func ElectoralExpList(parameters: [String:Any]?, completion: @escaping (Result<ProfileElectoralExpResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.ElectoralExpList
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
}
