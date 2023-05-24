//
//  LoginResponse.swift
//  Campaigner
//
//  Created by Osama Usmani on 23/05/2023.
//

import Foundation

struct LoginResponse: Codable {
    var rescode: Int?
    var message: String?
    var data: [LoginResponseData]?
}

struct LoginResponseData: Codable {
    var userId     : String?
    var userGender : Int?
    var token      : String?
    var cnic       : String?
    var phone      : String?
    var name       : String?
    var userImage  : String?
}
