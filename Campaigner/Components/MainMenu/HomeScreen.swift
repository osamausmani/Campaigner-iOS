//
//  HomeScreen.swift
//  Campaigner
//
//  Created by Macbook  on 03/06/2023.
//

import Foundation

enum HomeMenuRowType: Int, CaseIterable{
    case surveys = 0
    case reporting
    case complaints
    case electionResults
    
    var title: String{
        switch self {
        case .surveys:
            return "Surveys"
        case .reporting:
            return "Reporting"
        case .complaints:
            return "Complaints"
        case .electionResults:
            return "Election Results"
        }
    }
    
    var iconName: String{
        switch self {
        case .surveys:
            return "home"
        case .reporting:
            return "favorite"
        case .complaints:
            return "chat"
        case .electionResults:
            return "profile"
        }
    }
}
