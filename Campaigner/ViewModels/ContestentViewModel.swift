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
    
    func updateContestentRequest(parameters: [String:Any]?, completion: @escaping (Result<ContestingElectionResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.updateElection
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func deleteContestentRequest(parameters: [String:Any]?, headers: HTTPHeaders? = nil, completion: @escaping (Result<ContestingElectionResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.deleteElection
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, headers: headers , completion: completion)
    }
    
    
    func listElections(parameters: [String:Any]?, headers: HTTPHeaders? = nil ,completion: @escaping (Result<ContestingElectionResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.listElection
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, headers: headers, completion: completion)
    }
    
    
    func listElectionsMembers(parameters: [String:Any]?,headers: HTTPHeaders? = nil, completion: @escaping (Result<ContestingElectionResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.listElectionMembers
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    
    func listPollingStations(parameters: [String:Any]?, completion: @escaping (Result<ContestingElectionResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.listPollingStations
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    
    func listMyPollingStations(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.listElectionMembers
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    
    func postElectionResult(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.listElectionMembers
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    
    
    
    
    
    
//    func listElectionsMembers(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
//        let REQ_URL = ApiPaths.listElectionMembers
//        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
//    }
    
    
    
}
