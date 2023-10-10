//
//  BasicProfileInfoResponse.swift
//  Campaigner
//
//  Created by Osama Usmani on 06/10/2023.
//

import Foundation
struct BasicProfileInfoResponse : Codable {
    
    let bin : [String]?
    let extra : [String]?
    let message : String?
    let more : [String]?
    let rescode : Int?
    let data : [BasicProfileInfoResponseData]?

    
    struct BasicProfileInfoResponseData: Codable{
        
        let user_op : Int?
        let user_sdt : String?
        let user_gender : Int?
        let user_full_name : String?
        let user_name : String?
        let user_status :Int?
        let user_dob : String?
        let user_image : String?
        let is_admin : Int?
        let constituency_id_na :String?
        let constituency_na : String?
        let constituency_id_pa : String?
        let constituency_pa : String?
        let district_id : String?
        let district_name : String?
        let tehsil_id : String?
        let tehsil_name : String?
        let user_role : Int?
        let referral_no : String?
        let referral_name : String?

        
    }
    
}
