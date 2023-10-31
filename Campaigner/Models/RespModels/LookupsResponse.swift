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
    let data: [ProvinceResponseModel]?
    
}


struct ProvinceResponseModel: Codable {
    let province : String?
    let province_id : String?
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


struct ConstituencyVoterListItem: Codable {
    let constituency_id: String?
    let name: String?
    let justname: String?
    let designation: String?
    let description: String?
    let votestotal: String?
    let votescast: String?
    let votescand: String?
    let votesmale: String?
    let votesfemale: String?
    let votesvalid: String?
    let votesrejected: String?
    let latitude: String?
    let longitude: String?
    let candid: String?
    let cand: String?
    let candpartyid: String?
    let candparty: String?
    let partyflag: String?
    let image: String?
    let electType: String?
    let electYear: String?
    let electDate: String?
    let assembly_id: String?
    let district: String?
    let districtid: String?
}

struct ConstituencyVoterList: Codable {
    let status: Bool?
    let data: [ConstituencyVoterListItem]?
}



struct PoliticianListResponse: Codable {
    let status: Bool
    let data: [PoliticianData]?
}

struct PoliticianData: Codable {
    let id: String?
    let fullname: String?
    let gender: String?
    let dob: String?
    let rating: String?
    let ratingvotes: String?
    let education: String?
    let popular: String?
    let description: String?
    let networth: String?
    let candpartyid: String?
    let politician_current_position: String?
    let candparty: String?
    let candpartyname: String?
    let partyflag: String?
    let dod: String?
    let image: String?
}



struct ElectionConstituenciesListResponse: Codable {
    let status: Bool?
    let data: [ElectionConstituenciesListDetails]?
}

struct ElectionConstituenciesListDetails: Codable {
    let name: String?
    let designation: String?
    let description: String?
    let population: String?
    let votestotal: String?
    let votesmale: String?
    let votesfemale: String?
    let votescast: String?
    let votescand: String?
    let latitude: String?
    let longitude: String?
    let candpos: String?
    let status: String?
    let candid: String?
    let cand: String?
    let candrating: String?
    let candratingvotes: String?
    let candpartyid: String?
    let candparty: String?
    let partyflag: String?
    let image: String?
    let electID: String?
    let electType: String?
    let electYear: String?
    let electDate: String?
    let assembly_id: String?
    let areaid: String?
    let area: String?
}

struct ElectionCandidateResultResponse: Codable {
    let status: Bool?
    let data: [ElectionCandidateResultDetails]?
}

struct ElectionCandidateResultDetails: Codable {
    let election_id: String?
    let constituency_id: String?
    let constituency: String?
    let votescand: String?
    let constituency_designation: String?
    let constituency_name: String?
    let position: String?
    let candpartyid: String?
    let candpartyname: String?
    let candparty: String?
    let partyflag: String?
    let electType: String?
    let electYear: String?
    let assembly_id: String?
    let image: String?
}
