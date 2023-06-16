//
//  ApiPaths.swift
//  Campaigner
//
//  Created by Osama Usmani on 23/05/2023.
//

import Foundation
public class ApiPaths {
    
    public static var BasePath = "https://campaigner.syntracx.com/api"
    public static var Login = BasePath + "/login"
    public static var LoginOut = BasePath + "/logout"
    public static var Register = BasePath + "/signup"

    public static var ForgotPassword = BasePath + "/account/forget/password"
    public static var SendVerifitcationCode = BasePath + "/account/send/verifycode"
    public static var ForgotPasswordChange = BasePath + "/account/verify/code"

    // Lookups
    public static var listProvinces = BasePath + "/list/dynamic/province"
    public static var listDistrict = BasePath + "/list/dynamic/district"
    public static var listConstituency = BasePath + "/list/profile/constituency"
    
    
    
    
    
    //Contesting Elections
    public static var addElection = BasePath + "/add/elections"
    public static var updateElection = BasePath + "/update/elections"
    public static var deleteElection = BasePath + "/delete/elections"
    
    
    public static var listElection = BasePath + "/list/elections"
    public static var listElectionMembers = BasePath + "/list/elections/members"
    public static var listPollingStations = BasePath + "/list/election/polling/station"
    public static var listPollingResult = BasePath + "/list/election/polling/result"
    public static var postElectionResult = BasePath + "/post/election/polling/result"
    
    
    
    
    
    //Team
    public static var addTeam = BasePath + "/add/team"
    public static var updateTeam = BasePath + "/update/team"
    public static var deleteTeam = BasePath + "/delete/team"
    public static var listTeam = BasePath + "/list/team"
    
    
    
    public static var addTeamMember = BasePath + "add/team/member"
    public static var deleteTeamMember = BasePath + "delete/team/member"
    public static var updateTeamMember = BasePath + "/update/team/lead"
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
  
    


}
