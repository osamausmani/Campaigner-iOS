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
    var elections : [Elections]?
    var pro_type : Int!



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


struct NewsResponse: Codable {
    var rescode: Int!
    var message: String!
    var data: [NewsDetails]!
   
}


struct News : Codable {

    let news_id : String?
    let nw_added_by : NwAddedBy?
    let nw_desc : String?
    let nw_id : String?
    let nw_media : String?
    let nw_sdt : String?
    let nw_source : String?
    let nw_tags : String?
    let nw_title : String?
    
    let like_count : Int?
    let is_liked : Int?
    let nw_comments_count : Int?
    let nw_comments : [CommentsDatum]?

}


struct NewsDetails : Codable {

    let news_id : String?
    let nw_added_by : NwAddedBy?
    let nw_desc : String?
    let nw_id : String?
    let nw_sdt : String?
    let nw_source : String?
    let nw_tags : String?
    let nw_title : String?
    
    let like_count : Int?
    let is_liked : Int?
    let nw_comments_count : Int?
    let nw_comments : [CommentsDatum]?

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

public struct CommentsDatum : Codable, Hashable {
    let comment_id : String?
    let comment_text : String?
    let sdt : String?
    let user_full_name : String?
    let info_image : String?
    let user_id : String?
    let is_liked : Int?
    let like_count : Int?
}

public struct Elections : Codable, Hashable {
    let type : Int?
    let election_type : Int?
    let assembly_type : Int?
    let election_id : String?
    let sdt : String?
    let province_id : String?
    let province : String?
    let district_id : String?
    let district : String?
    let constituency_id : String?
    let constituency : String?
    let refferal_no : String?
    let party_id : String?
    let party_name : String?
    let constituency_id_pa : String?
    let constituency_pa : String?
    let constituency_id_na : String?
    let constituency_na : String?
    let constituency_pa_district : String?
    let constituency_pa_province : String?
    let constituency_na_district : String?
    let constituency_na_province : String?
}
