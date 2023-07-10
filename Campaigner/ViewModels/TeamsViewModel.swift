//
//  TeamsViewModel.swift
//  Campaigner
//
//  Created by Macbook  on 05/07/2023.
//

import Foundation
import Alamofire



class TeamsViewModel: ObservableObject {
    
    
    func ListMembers(parameters: [String:Any]?, headers: HTTPHeaders? = nil , completion: @escaping (Result<TeamsResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.listMemebers
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!,headers: headers, completion: completion)
    }
    
    func ListTeams(parameters: [String:Any]?, headers: HTTPHeaders? = nil , completion: @escaping (Result<TeamsResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.listTeam
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!,headers: headers, completion: completion)
    }
    
    
    func AddTeam(parameters: [String:Any]?, headers: HTTPHeaders? = nil , completion: @escaping (Result<BaseResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.addTeam
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!,headers: headers, completion: completion)
    }
    
    func DeleteTeam(parameters: [String:Any]?, headers: HTTPHeaders? = nil , completion: @escaping (Result<BaseResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.deleteTeam
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!,headers: headers, completion: completion)
    }
    
    
    func UpdateTeam(parameters: [String:Any]?, headers: HTTPHeaders? = nil , completion: @escaping (Result<BaseResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.updateTeam
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!,headers: headers, completion: completion)
    }
    
    
    
    
//    func listPollingStations(parameters: [String:Any]?, headers: HTTPHeaders? = nil , completion: @escaping (Result<ListPollingStations, Error>) -> Void) {
//        let REQ_URL = ApiPaths.listPollingStation
//        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!,headers: headers, completion: completion)
//    }
}
