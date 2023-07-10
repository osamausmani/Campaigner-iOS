//
//  HomeResponse.swift
//  Campaigner
//
//  Created by Macbook  on 16/06/2023.
//

import Foundation
struct HomeResponse: Codable {
    var rescode: Int!
    var message: String!
    var data: [User]!
   
}


struct User: Codable {

    var can_add_election : Int!
    var election_id : String!
    var is_lead : Int!
    var news : [News]!
    var notify_count : Int!
    var pending_amount : Int!
    var referral_name : String!
    var referral_no : String!
    var sliders : [Slider]!
    var user_role : Int!


}



struct Slider : Codable {

    let extra_url : String?
    let file_desc : String?
    let file_title : String?
    let from_dtm : String?
    let id_text : String?
    let image_path : String?
    let sdt : String?
    let status : Int?
    let to_dtm : String?


}

struct News : Codable {

    let news_id : String?
    let nw_added_By : NwAddedBy?
    let nw_desc : String?
    let nw_id : String?
    let nw_media : String?
    let nw_sdt : String?
    let nw_source : String?
    let nw_tags : String?
    let nw_title : String?

}

struct NwAddedBy : Codable {

    let ar_value : String?
    let id_text : String?
    let is_admin : Int?
    let user_full_name : String?
    let user_id_text : String?
    let user_image : String?
    let user_name : String?
    let user_status : Int?


}