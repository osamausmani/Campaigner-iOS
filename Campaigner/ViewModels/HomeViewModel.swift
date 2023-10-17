//
//  HomeViewModel.swift
//  Campaigner
//
//  Created by Macbook  on 16/06/2023.
//

import Foundation
import Alamofire

class HomeViewModel: ObservableObject {
    
    
    func DashboardData(parameters: [String:Any]?, headers: HTTPHeaders? = nil , completion: @escaping (Result<HomeResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.mobileDashboard
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!,headers: headers, completion: completion)
    }
    
  
    
}
