//
//  LookupsViewModel.swift
//  Campaigner
//
//  Created by Macbook  on 07/06/2023.
//

import Foundation
import Alamofire

class LookupsViewModel: ObservableObject {
    
    
    func ListProvinces(parameters: [String:Any]?, completion: @escaping (Result<ListProvinceResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.ListProvinces
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func ListDistricts(parameters: [String:Any]?, completion: @escaping (Result<ListDistrictResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.ListDistrict
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func ListConstituency(parameters: [String:Any]?, completion: @escaping (Result<ListConstituencyResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.ListConstituency
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func ListVoterConstituency(parameters: [String:Any]?, completion: @escaping (Result<ConstituencyVoterList, Error>) -> Void) {
        let REQ_URL = ApiPaths.VoterBasePath
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func ListVoterCandidates(parameters: [String:Any]?, completion: @escaping (Result<PoliticianListResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.VoterBasePath
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func ListVoterElectionConstituenciesResult(parameters: [String:Any]?, completion: @escaping (Result<ElectionConstituenciesListResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.VoterBasePath
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func ListVoterElectionCandidateResult(parameters: [String:Any]?, completion: @escaping (Result<ElectionCandidateResultResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.VoterBasePath
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    
    
    func ListPollingStations(parameters: [String:Any]?, headers: HTTPHeaders? = nil , completion: @escaping (Result<ListPollingStations, Error>) -> Void) {
        let REQ_URL = ApiPaths.ListPollingStations
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!,headers: headers, completion: completion)
    }
    
    func ListPollingStation(parameters: [String:Any]?, headers: HTTPHeaders? = nil , completion: @escaping (Result<ListPollingStations, Error>) -> Void) {
        let REQ_URL = ApiPaths.ListPollingStation
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!,headers: headers, completion: completion)
    }
    
    
    func ListReportingTypes(parameters: [String:Any]?, headers: HTTPHeaders? = nil , completion: @escaping (Result<ListReportingTypeResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.ListReportingType
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!,headers: headers, completion: completion)
    }
    
    func ListParties(parameters: [String:Any]?, completion: @escaping (Result<ListPartiesResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.ListParties
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    
}
