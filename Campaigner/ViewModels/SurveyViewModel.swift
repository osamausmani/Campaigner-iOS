//
//  SurveyViewModel.swift
//  Campaigner
//
//  Created by Macbook  on 03/07/2023.
//

import Foundation



import Alamofire

class SurveyViewModel: ObservableObject {
    
    
    func ListSurveyByUser(parameters: [String:Any]?, headers: HTTPHeaders? = nil , completion: @escaping (Result<SurveyListResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.ListSurveyByUserID
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func GetSurveyDetails(parameters: [String:Any]?, headers: HTTPHeaders? = nil , completion: @escaping (Result<SurveyDetailsResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.SurveyDetails
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }

    func SubmitSurveyAnswers(parameters: [String:Any]?, headers: HTTPHeaders? = nil , completion: @escaping (Result<BaseResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.SurveySubmitAnswers
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    func ListSurveyDetails(parameters: [String:Any]?, headers: HTTPHeaders? = nil , completion: @escaping (Result<SurveyDetailsResponse, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.SurveyDetails
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
  
    
}
