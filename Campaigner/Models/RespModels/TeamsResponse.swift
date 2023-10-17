//
//  TeamsResponse.swift
//  Campaigner
//
//  Created by Macbook  on 05/07/2023.
//

import Foundation




struct TeamsResponse : Codable {
    
    
    
    let bin : [String]?
    let data : [TeamsData]?
    let extra : [String]?
    let message : String?
    let more : [String]?
    let rescode : Int?
    
    
}


struct TeamsData : Codable {
    
        let group_sdt : String?
        let members : [Member]?
        let members_count : Int?
        let poll_station_id : String?
        let poll_station_name : String?
        let sdt : String?
        let team_desc : String?
        let team_id : String?
        let team_name : String?
 
    
}

struct Member : Codable {
    
    let is_lead : Int?
    let is_member : Int?
    let mem_id : String?
    let msisdn : String?
    let user_cnic : String?
    let user_full_name : String?
    let user_id : String?
}
