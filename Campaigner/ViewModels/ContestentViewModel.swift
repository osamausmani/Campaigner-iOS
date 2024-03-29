//
//  ContestentViewModel.swift
//  Campaigner
//
//  Created by Macbook  on 31/05/2023.
//

import Foundation
import Alamofire

class ContestentViewModel: ObservableObject {
    
    
  
    
    func addContestentRequest(parameters: [String:Any]?, headers: HTTPHeaders? = nil , completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.addElection
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, headers: headers, completion: completion)
    }
    
    func updateContestentRequest(parameters: [String:Any]?, headers: HTTPHeaders? = nil , completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.updateElection
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, headers: headers, completion: completion)
    }
    
    func deleteContestentRequest(parameters: [String:Any]?, headers: HTTPHeaders? = nil, completion: @escaping (Result<ContestingElectionResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.deleteElection
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, headers: headers , completion: completion)
    }
    
    
    func listElections(parameters: [String:Any]?, headers: HTTPHeaders? = nil ,completion: @escaping (Result<ContestingElectionResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.ListElection
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, headers: headers, completion: completion)
    }
    
    
    func ListElectionsMembers(parameters: [String:Any]?,headers: HTTPHeaders? = nil, completion: @escaping (Result<ElectionMembersResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.ListElectionMembers
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    
    func listPollingStations(parameters: [String:Any]?, completion: @escaping (Result<ContestingElectionResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.ListPollingStations
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    
    func listMyPollingStations(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.ListElectionMembers
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    
    func postElectionResult(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.ListElectionMembers
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    
    func UpgradeAccount(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.upgradeAccount
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    func DegradeAccount(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.degradeAccount
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    

    
    
    
    
    
    
//    func listElectionsMembers(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
//        let REQ_URL = ApiPaths.listElectionMembers
//        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
//    }
    
    
    
}
