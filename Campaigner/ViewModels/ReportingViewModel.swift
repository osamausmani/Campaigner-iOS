//
//  ReportingViewModel.swift
//  Campaigner
//
//  Created by Macbook  on 10/07/2023.
//

import Foundation
import Alamofire


class ReportingViewModel: ObservableObject
{
    
    func AddReport(parameters: [String:Any]?, headers: HTTPHeaders? = nil , completion: @escaping (Result<BaseResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.addReport
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!,headers: headers, completion: completion)
    }
    
    func ListReport(parameters: [String:Any]?, headers: HTTPHeaders? = nil , completion: @escaping (Result<ReportingResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.listReport
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!,headers: headers, completion: completion)
    }
}
