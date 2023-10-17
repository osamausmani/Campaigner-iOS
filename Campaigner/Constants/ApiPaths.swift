//
//  ApiPaths.swift
//  Campaigner
//
//  Created by Osama Usmani on 23/05/2023.
//

import Foundation
public class ApiPaths {
    
    //    public static var BasePath = "https://campaigner.syntracx.com/api"
    public static var BasePath = "https://staging.halka.pk/api"
    
    public static var Login = BasePath + "/login"
    public static var LoginOut = BasePath + "/logout"
    public static var Register = BasePath + "/signup"
    
    public static var ForgotPassword = BasePath + "/account/forget/password"
    public static var SendVerifitcationCode = BasePath + "/account/send/verifycode"
    public static var ForgotPasswordChange = BasePath + "/account/verify/code"
    
    
    //Profile
    public static var UserProfileBasicInfo = BasePath + "/view/user/basic/info"
    
    
    //News
    public static var NewsDetails = BasePath + "/detail/news"
    public static var NewsLike = BasePath + "/like/news"
    public static var NewsDislike = BasePath + "/dislike/news"
    public static var NewsAddComment = BasePath + "/add/news/comment"

    
    
    // Lookups
    public static var listProvinces = BasePath + "/list/dynamic/province"
    public static var listDistrict = BasePath + "/list/dynamic/district"
    public static var listConstituency = BasePath + "/list/profile/constituency"
    public static var listReportingType = BasePath + "/list/reporting/type"
    
    
    
    
    
    //Contesting Elections
    public static var addElection = BasePath + "/add/elections"
    public static var updateElection = BasePath + "/update/elections"
    public static var deleteElection = BasePath + "/delete/elections"
    
    
    public static var listElection = BasePath + "/list/elections"
    public static var listElectionMembers = BasePath + "/list/elections/members"
    public static var listPollingStations = BasePath + "/list/election/polling/station"
    public static var listPollingResult = BasePath + "/list/election/polling/result"
    public static var postElectionResult = BasePath + "/post/election/polling/result"
    
    
    
    
    
    
    
    
    
    
    
    
    
    //DashBoard
    public static var mobileDashboard = BasePath + "/list/dashboard/data"
    
    
    
    
    //Payments
    
    public static var payFee = BasePath + "/pay/fee"
    
    public static var bankList = BasePath + "/list/banks"
    
    //Name mistake
    public static var paymentHistory = BasePath + "/list/payment/history"
    public static var pendingPayments = BasePath + "/check/membership/fee"
    
    
    
    
    public static var listUserSubscription = BasePath + "/list/user/subscriptions"
    
    public static var addSubscriptionRequest = BasePath + "/add/user/subscription"
    
    public static var unSubSubscriptiont = BasePath + "/delete/user/subscription"
    
    
    
    
    
    
    //Survey
    
    public static var listAllSurveys = BasePath + "/list/door/survey"
    
    
    
    
    public static var listSurveyByUserId = BasePath + "/list/door/survey/userid"
    
    public static var listSurveyById = BasePath + "/detail/door/survey"
    
    public static var deleteSurvey = BasePath + "/delete/door/survey"
    
    public static var updateSurvey = BasePath + "/update/door/survey"
    
    public static var addSurvey = BasePath + "/add/door/survey"
    
    
    
    
    //Team
    public static var addTeam = BasePath + "/add/team"
    public static var updateTeam = BasePath + "/update/team"
    public static var deleteTeam = BasePath + "/delete/team"
    public static var listTeam = BasePath + "/list/team"
    
    //memeber
    public static var addTeamMember = BasePath + "/add/team/member"
    public static var deleteTeamMember = BasePath + "/delete/team/member"
    public static var changeLeadStatus = BasePath + "/update/team/lead"
    
    
    
    public static var listMemebers = BasePath + "/list/elections/members"
    
    public static var listPollingStation = BasePath + "/list/pollstation"
    
    
    
    //Reporting
    public static var addReport = BasePath + "/add/reporting"
    
    public static var updateReport = BasePath + "/update/reporting"
    
    
    public static var deleteReport = BasePath + "/delete/reporting"
    
    public static var listReport = BasePath + "/list/reporting"
    
    public static var changeStatusReport = BasePath + "/change/reporting/status"
    
    
    
    
    
    
    
    
    
    
    
}
