//
//  ComplaintsResponse.swift
//  Campaigner
//
//  Created by Osama Usmani on 26/10/2023.
//

import Foundation

struct ComplaintTypeResponseData: Codable {
    let rescode: Int?
    let message: String?
    let data: [TypeData?]
}

struct TypeData: Codable {
    let type_id: String?
    let type_name: String?
}
