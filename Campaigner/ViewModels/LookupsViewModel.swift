//
//  LookupsViewModel.swift
//  Campaigner
//
//  Created by Macbook  on 07/06/2023.
//

import Foundation
import Alamofire

class LookupsViewModel: ObservableObject {
    
    
    func listProvinces(parameters: [String:Any]?, completion: @escaping (Result<ListProvinceResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.listProvinces
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func listDistricts(parameters: [String:Any]?, completion: @escaping (Result<ListDistrictResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.listDistrict
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func listConstituency(parameters: [String:Any]?, completion: @escaping (Result<ListConstituencyResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.listConstituency
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
}
