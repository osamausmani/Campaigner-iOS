//
//  ProfileElectoralExpResponse.swift
//  Campaigner
//
//  Created by Osama Usmani on 06/11/2023.
//

import Foundation

// Define the structure for the "data" array element
struct ElectoralExpResponseItem: Codable {
    let id_text: String?
    let elect_year: String?
    let elect_type: Int?
    let elect_assembly: Int?
    let elect_const: String?
    let elect_party: String?
    let elect_result: Int?
    let elect_vote: Int?
    let elect_position: Int?
    let elect_ministry: String?
    let constituency: String?
    let constituency_id: String?
    let party_name: String?
}

// Define the structure for the JSON response
struct ProfileElectoralExpResponse: Codable {
    let rescode: Int?
    let message: String?
    let data: [ElectoralExpResponseItem]?
    let extra: [String]?
    let more: [String]?
    let bin: [String]?
}
