//
//  ForgotPassViewModel.swift
//  Campaigner
//
//  Created by Osama Usmani on 24/05/2023.
//

import Foundation


class ForgotPassViewModel: ObservableObject {
    
    func SendForgotRequest(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.ForgotPassword
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func SendVerifitcationCodeRequest(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.SendVerifitcationCode
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
    func ForgotPasswordChangeRequest(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.ForgotPasswordChange
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    func VerifyVerificationCodeeRequest(parameters: [String:Any]?, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        let REQ_URL = ApiPaths.VerifyVerificationCode
        NetworkManager.shared.Request( url: REQ_URL, method: .post, parameters: parameters!, completion: completion)
    }
    
}
