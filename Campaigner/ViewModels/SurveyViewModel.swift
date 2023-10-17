//
//  SurveyViewModel.swift
//  Campaigner
//
//  Created by Macbook  on 03/07/2023.
//

import Foundation



import Alamofire

class SurveyViewModel: ObservableObject {
    
    
    func ListSurvey(parameters: [String:Any]?, headers: HTTPHeaders? = nil , completion: @escaping (Result<SurveyResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.listAllSurveys
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!,headers: headers, completion: completion)
    }
    
//    func ListSurveyById(parameters: [String:Any]?, headers: HTTPHeaders? = nil , completion: @escaping (Result<SurveyResponse, Error>) -> Void)
//    {
//        let REQ_URL = ApiPaths.listSurveyById
//        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!,headers: headers, completion: completion)
//    }
//    
    
    
  
    
}
