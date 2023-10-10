//
//  NetworkManager.swift
//  Campaigner
//
//  Created by Osama Usmani on 23/05/2023.
//

import Foundation
import Alamofire
import SwiftUI

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func Request<T: Decodable>(url: URLConvertible, method: HTTPMethod , parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        
        print("==========================================================")
        print("HEADERS  ", headers)
        print("API REQ URL ", url)
        print("PARAMETERS ", parameters)
        
        AF.request(url, method: method, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: T.self) { response in
                print(response)
                switch response.result {
                case .success(let decodedResponse):
                    completion(.success(decodedResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    
    func RequestSecure<T: Decodable>(url: URLConvertible, method: HTTPMethod , parameters: Parameters? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        
        let headers:HTTPHeaders = [
             "Content-Type":"application/x-www-form-urlencoded",
            "x-access-token": UserDefaults.standard.object(forKey: Constants.USER_SESSION_TOKEN)! as! String
        ]
        
        print("==========================================================")
        print("HEADERS  ", headers)
        print("API REQ URL ", url)
        print("PARAMETERS ", parameters)

        AF.request(url, method: method, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: T.self) { response in
                print("RESPONSE ", response)
                switch response.result {
                case .success(let decodedResponse):
                    completion(.success(decodedResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    

}
