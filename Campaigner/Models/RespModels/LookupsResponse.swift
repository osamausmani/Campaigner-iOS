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

struct ListPollingStations : Codable
{
    
        let bin : [String]?
        let data : [PollingStations]?
        let extra : [String]?
        let message : String?
        let more : [String]?
        let rescode : Int?
 
}

struct PollingStations : Codable
{
    let pol_desc : String?
    let pol_name : String?
    let station_id : String?

}

struct ListReportingTypeResponse : Codable
{
    let bin : [String]?
    let data : [ListReportingType]?
    let extra : [String]?
    let message : String?
    let more : [String]?
    let rescode : Int?
}

struct ListReportingType: Codable
{
    
    let type_id : String?
    let type_name : String?
    
}
