//
//  ComplaintCommentResponse.swift
//  Campaigner
//
//  Created by Osama Usmani on 28/10/2023.
//

import Foundation

public struct ComplaintCommentResponse: Codable, Hashable {
    let rescode: Int?
    let message: String?
    let data: [ComplaintCommentDataum]?
    let extra: [String]?
    let more: [String]?
    let bin: [String]?
}

public struct ComplaintCommentDataum: Codable, Hashable {
    public let comment_id: String?
    public let comment_text: String?
    public let sdt: String?
    public let user_full_name: String?
    public let info_image: String?
    public let user_id: String?
}
