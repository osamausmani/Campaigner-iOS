//
//  SurveyResponse.swift
//  Campaigner
//
//  Created by Macbook  on 03/07/2023.
//

import Foundation


struct SurveyResponse : Codable {
    
    
    
    let bin : [String]?
    let data : [SurveyData]?
    let extra : [String]?
    let message : String?
    let more : [String]?
    let rescode : Int?
    
    
}


struct SurveyData : Codable {
    
    let anon_Allowed : Int?
    let constituency_na : String?
    let constituency_pa : String?
    let creator_id : String?
    let creator_name : String?
    let district : String?
    let district_id : String?
    let na_id : String?
    let pa_id : String?
    let survey_block : String?
    let survey_description : String?
    let survey_id_text : String?
    let survey_multi_attempt : Int?
    let survey_questions : [SurveyQuestion]?
    let survey_responses : Int?
    let survey_sdt : String?
    let survey_status : Int?
    let survey_title : String?
    let survey_uc : String?
    let tehsil : String?
    let tehsil_id : String?
    
    
    
    
}


struct SurveyQuestion : Codable {
    
    let question_id_text : String?
    let question_status : Int?
    let question_title : String?
    let question_type : Int?
    
}
