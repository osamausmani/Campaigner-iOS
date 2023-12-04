//
//  NotificationViewModel.swift
//  Campaigner
//
//  Created by Macbook  on 27/11/2023.
//

import Foundation
import Alamofire
class NotificationViewModel: ObservableObject {
    func AddNotification(parameters: [String:Any]?, completion: @escaping (Result<AddNotification, Error>) -> Void) {
        let REQ_URL = ApiPaths.addNotification
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func AudienceCount(parameters: [String:Any]?, headers: HTTPHeaders? = nil , completion: @escaping (Result<AudienceCountData, Error>) -> Void) {
        let REQ_URL = ApiPaths.audenceMemberCount
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    func AddAudience(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.addAudience
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    func ListScheduleNotifications(parameters: [String:Any]?, headers: HTTPHeaders? = nil , completion: @escaping (Result<ListSchNotification, Error>) -> Void)
    {
        let REQ_URL = ApiPaths.listScheduleNotification
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
}
