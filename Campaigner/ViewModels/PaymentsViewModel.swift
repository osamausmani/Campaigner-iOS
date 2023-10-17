//
//  PaymentsViewModel.swift
//  Campaigner
//
//  Created by Macbook  on 20/06/2023.
//

import Foundation
import Alamofire


class PaymentsViewModel: ObservableObject {
    
    func payFeeRequest(parameters: [String:Any]?, completion: @escaping (Result<ListBanksResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.payFee
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func bankListRequest(parameters: [String:Any]?, completion: @escaping (Result<ListBanksResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.bankList
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    
    func paymentHistoryRequest(parameters: [String:Any]?, headers: HTTPHeaders? = nil, completion: @escaping (Result<ListBanksResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.paymentHistory
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!,headers: headers, completion: completion)
    }
    
    func listPendingPayments(parameters: [String:Any]?, headers: HTTPHeaders? = nil, completion: @escaping (Result<ListPendingPaymentsResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.pendingPayments
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!,headers: headers, completion: completion)
    }
    
    func payFee(parameters: [String:Any]?, headers: HTTPHeaders? = nil, completion: @escaping (Result<ListPendingPaymentsResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.payFee
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!,headers: headers, completion: completion)
    }
}



