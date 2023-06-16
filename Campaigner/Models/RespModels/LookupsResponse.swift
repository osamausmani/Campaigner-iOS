//
//  ListProvinceResponse.swift
//  Campaigner
//
//  Created by Macbook  on 07/06/2023.
//

import Foundation
struct ListProvinceResponse: Codable {
    let rescode: Int?
    let message: String?
    var data: [ProvinceResponseModel]?
    
}


struct ProvinceResponseModel: Codable {
    var province : String?
    var province_id : String?
}

struct ListDistrictResponse: Codable {
    let rescode: Int?
    let message: String?
    var data: [DistrictResponseModel]?
    
}


struct DistrictResponseModel: Codable
{
    var district_id : String?
    var district_name : String?
}


struct ListConstituencyResponse: Codable {
    let rescode: Int?
    let message: String?
    var data: [ConstituencyResponseModel]?
    
}


struct ConstituencyResponseModel: Codable
{
        var constituency : String?
        var digit : Int?
        var district : String?
        var id_text : String?
        var province : String?
        var type : Int?

}
