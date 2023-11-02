//
//  SurveyResponse.swift
//  Campaigner
//
//  Created by Macbook  on 03/07/2023.
//

import Foundation


struct SurveyListResponse: Codable {
    let rescode: Int?
    let message: String?
    let data: [SurveyListData]?
}

struct SurveyListData: Codable {
    let survey_id_text: String?
    let survey_title: String?
    let survey_description: String?
    let creator_id: String?
    let creator_name: String?
    let anon_allowed: Int?
    let district_id: String?
    let tehsil_id: String?
    let na_id: String?
    let district_name: String?
    let tehsil_name: String?
    let constituency_na: String?
    let pa_id: String?
    let constituency_pa: String?
    let survey_uc: String?
    let survey_block: String?
    let survey_multi_attempt: Int?
    let survey_sdt: String?
    let survey_type: Int?
    let survey_status: Int?
    let user_image: String?
    let user_full_name: String?
    let survey_submitted: String?
    let attempt_count: Int?
    let question_count: Int?
    let stats_url: String?
}


struct SurveyDetailsResponse: Codable {
    let rescode: Int?
    let message: String?
    let data: [SurveyData]?
    let extra: [String]?
    let more: [String]?
    let bin: [String]?
}

struct SurveyData: Codable {
    let survey_id_text: String?
    let survey_title: String?
    let survey_description: String?
    let creator_id: String?
    let creator_name: String?
    let anon_allowed: Int?
    let district_id: String?
    let tehsil_id: String?
    let na_id: String?
    let constituency_na: String?
    let pa_id: String?
    let constituency_pa: String?
    let survey_uc: String?
    let survey_block: String?
    let survey_multi_attempt: Int?
    let survey_sdt: String?
    let survey_status: Int?
    let district: String?
    let tehsil: String?
    let survey_submitted: String?
    let question_data: [SurveyQuestion]?
    let answer_data: [String]?
    let polling_station: [String]?
}

struct SurveyQuestion: Codable {
    let question_id_text: String?
    let question_type: Int?
    let question_title: String?
    let question_status: Int?
    let question_option: [SurveyQuestionOption]?
}

struct SurveyQuestionOption: Codable {
    let question_option: String?
    let question_option_id_text: String?
}
