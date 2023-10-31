//
//  ComplaintsViewModel.swift
//  Campaigner
//
//  Created by Osama Usmani on 26/10/2023.
//

import Foundation


class ComplaintsViewModel: ObservableObject {
    
    func GetComplaintsType(parameters: [String:Any]?, completion: @escaping (Result<ComplaintTypeResponseData, Error>) -> Void) {
        let REQ_URL = ApiPaths.ListComplaintTypes
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func AddComplaint(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.AddComplaint
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func GetOwnedComplaints(parameters: [String:Any]?, completion: @escaping (Result<ComplaintListResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.ListOwnedComplaints
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func GetPublicComplaints(parameters: [String:Any]?, completion: @escaping (Result<ComplaintListResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.ListPublicComplaints
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func UpdateComplaint(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.UpdateComplaint
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func DeleteComplaint(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.DeleteComplaint
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func AddComplaintComment(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.AddComplaintComment
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func DeleteComplaintComment(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.DeleteComplaintComment
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    func ListComplaintComments(parameters: [String:Any]?, completion: @escaping (Result<ComplaintCommentResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.ListComplaintComment
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func AddEndorseComplaint(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.AddComplaintEndosrement
        NetworkManager.shared.RequestSecure( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
}
