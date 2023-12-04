//
//  NotificationResponse.swift
//  Campaigner
//
//  Created by Macbook  on 27/11/2023.
//

import Foundation
struct AudienceCountData: Codable {
    let rescode: Int?
    let message: String?
    let data: [Datum]?
}

struct Datum: Codable {
    let totalCount, coins: Int?
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case coins
    }
}
struct AddNotification: Codable {
    let rescode: Int?
    let message: String?
    let data:String?
   
}
struct ListSchNotification: Codable {
    let rescode: Int?
    let message: String?
    let data: [ScheduleDatum]?
    let extra: [String]?
    let more: [String]?
    let bin: [String]?
}


// MARK: - ScheduleDatum
struct ScheduleDatum: Codable {
    let notifyImage: String?
    let schedID, transID, notifyTitle, notifyDesc: String?
    let notifyURL: String?
    let notifyType: Int?
    let notifyDtm, sdt: String?
    let addedBy: AddedBy?
    let status, approvalStatus: Int?
    let sentCount : Int?
    let approvalBy, startDtm, endDtm: String?

    enum CodingKeys: String, CodingKey {
        case notifyImage = "notify_image"
        case schedID = "sched_id"
        case transID = "trans_id"
        case notifyTitle = "notify_title"
        case notifyDesc = "notify_desc"
        case notifyURL = "notify_url"
        case notifyType = "notify_type"
        case notifyDtm = "notify_dtm"
        case sdt
        case addedBy = "added_by"
        case status
        case approvalStatus = "approval_status"
        case approvalBy = "approval_by"
        case sentCount = "sent_count"
        case startDtm = "start_dtm"
        case endDtm = "end_dtm"
    }
}
