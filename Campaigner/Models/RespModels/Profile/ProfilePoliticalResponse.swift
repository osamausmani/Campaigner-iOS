//
//  ProfilePoliticalResponse.swift
//  Campaigner
//
//  Created by Osama Usmani on 05/11/2023.
//

import Foundation


struct ListPoliticalResponse: Codable {
    let rescode: Int?
    let message: String?
    let data: [ListPoliticalResponseData]?
    let extra: [String]?
    let more: [String]?
    let bin: [String]?
}


struct ListPoliticalResponseData: Codable {
    let record_id: String?
    let party_id: String?
    let party_name: String?
    let exp_to: String?
    let exp_from: String?
}
