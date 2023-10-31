//
//  ComplaintListResponse.swift
//  Campaigner
//
//  Created by Osama Usmani on 28/10/2023.
//

import Foundation

struct ComplaintListResponse: Codable {
    let rescode: Int?
    let message: String?
    let data: [ComplaintListDataItem]?
    let extra: [String]?
    let more: [String]?
    let bin: [String]?
}

struct ComplaintListDataItem: Codable {
    let complaint_id: String?
    let type_id: String?
    let type_name: String?
    let details: String?
    let file: String?
    let is_internal: Int?
    let loc_lat: String?
    let loc_lng: String?
    let loc_desc: String?
    let added_by: ComplaintListAddedBy?
    let status: Int?
    let sdt: String?
    let province_id: String?
    let province: String?
    let district_id: String?
    let district: String?
    let poll_station_id: String?
    let pol_name: String?
    let const_type: Int?
    let constituency_id: String?
    let constituency: String?
    let tehsil_id: String?
    let tehsil: String?
    let total_endorsed: Int?
    let url: String?
    let media: [String]?
}

struct ComplaintListAddedBy: Codable {
    let user_op: Int?
    let id_text: String?
    let ar_value: String?
    let user_id_text: String?
    let user_full_name: String?
    let user_name: String?
    let user_status: Int?
    let user_image: String?
    let is_admin: Int?
}
