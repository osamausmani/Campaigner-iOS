//
//  ContestingElectionsResponse.swift
//  Campaigner
//
//  Created by Macbook  on 08/06/2023.
//

import Foundation
struct ContestingElectionResponse: Codable {
    let rescode: Int?
    let message: String?
    let data: [ContestingElection]?
    
}


struct ContestingElection: Codable
{
    var assembly_type : Int?
    var candidate : Candidate?
    var constituency : String?
    var constituency_id : String?
    var district : String?
    var district_id : String?
    var election_id : String?
    var nw_sdt : String?
    var province : String?
    var province_id : String?
    var refferal_no : String?
    var sdt : String?
    
}



struct Candidate: Codable
{
    var ar_value : String?
    var id_text : String?
    var is_admin : Int?
    var user_full_name : String?
    var user_id_text : String?
    var user_image : String?
    var user_name : String?
    var user_status : Int?
}

struct ElectionMembersResponse: Codable {
    let rescode: Int?
    let message: String?
    let data: [ElectionMembers]?
    
}


struct ElectionMembers: Codable
{
    var user_id : String?
    var mem_id : String?
    var user_full_name : String?
    var user_cnic : String?
    var msisdn : String?
    var is_lead : Int?
    var is_member : Int?

    
}
