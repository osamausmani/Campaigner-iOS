//
//  ReportingResponse.swift
//  Campaigner
//
//  Created by Macbook  on 11/07/2023.
//

import Foundation


struct ReportingResponse : Codable {
    
    let bin : [String]?
    let data : [Reporting]?
    let extra : [String]?
    let message : String?
    let more : [String]?
    let rescode : Int?
    
}

struct Reporting : Codable {
    
    let added_by : AddedBy?
    let details : String?
    let file : String?
    let is_complaint : Int?
    let loc_desc : String?
    let loc_lat : String?
    let loc_lng : String?
    let report_id : String?
    let sdt : String?
    let status : Int?
    let type_id : String?
    let type_name : String?
}

struct AddedBy : Codable {
    
    let ar_value : String?
    let id_text : String?
    let is_admin : Int?
    let user_full_name : String?
    let user_id_text : String?
    let user_image : String?
    let user_name : String?
    let user_status : Int?
}
