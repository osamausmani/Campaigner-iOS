//
//  NewsViewModel.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/10/2023.
//

import Foundation

class NewsViewModel: ObservableObject {
    
    func GetNewsDetails(parameters: [String:Any]?, completion: @escaping (Result<NewsResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.NewsDetails
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func NewsLike(parameters: [String:Any]?, completion: @escaping (Result<NewsResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.NewsLike
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func NewsDislike(parameters: [String:Any]?, completion: @escaping (Result<NewsResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.NewsDislike
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func NewsAddComment(parameters: [String:Any]?, completion: @escaping (Result<NewsResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.NewsAddComment
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
}
