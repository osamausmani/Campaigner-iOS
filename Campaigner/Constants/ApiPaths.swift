//
//  ApiPaths.swift
//  Campaigner
//
//  Created by Osama Usmani on 23/05/2023.
//

import Foundation
public class ApiPaths {
    
    public static var BasePath = "https://staging.halka.pk/api"

    public static var VoterBasePath = "https://voter.syntracx.com/mini-process.php"
    
    public static var Login = BasePath + "/login"
    public static var LoginOut = BasePath + "/logout"
    public static var Register = BasePath + "/signup"
    
    public static var ForgotPassword = BasePath + "/account/forget/password"
    public static var SendVerifitcationCode = BasePath + "/account/send/verifycode"
    public static var ForgotPasswordChange = BasePath + "/account/verify/code"
    
    
    
    //Profile
    public static var UserProfileBasicInfo = BasePath + "/view/user/basic/info"
    public static var UserProfileInfoUpdate = BasePath + "/update/user/basic/info"

    public static var PoliticalCareerAdd = BasePath + "/insert/user/political/info"
    public static var PoliticalCareerUpdate = BasePath + "/update/user/political/info"
    public static var PoliticalCareerDelete = BasePath + "/delete/user/political/info"
    public static var PoliticalCareerList = BasePath + "/view/user/political/info"

    public static var ElectoralExpAdd = BasePath + "/insert/user/electoral/info"
    public static var ElectoralExpUpdate = BasePath + "/update/user/electoral/info"
    public static var ElectoralExpDelete = BasePath + "/delete/user/electoral/info"
    public static var ElectoralExpList = BasePath + "/view/user/electoral/info"

    
    
    //News
    public static var NewsDetails = BasePath + "/detail/news"
    public static var NewsLike = BasePath + "/like/news"
    public static var NewsDislike = BasePath + "/dislike/news"
    public static var NewsAddComment = BasePath + "/add/news/comment"

    
    
    // Lookups
    public static var ListProvinces = BasePath + "/list/dynamic/province"
    public static var ListDistrict = BasePath + "/list/dynamic/district"
    public static var ListTehsils = BasePath + "/list/dynamic/tehsil"
    public static var ListConstituency = BasePath + "/list/profile/constituency"
    public static var ListReportingType = BasePath + "/list/reporting/type"
    public static var TermandCondition = BasePath + "/list/terms"
    
    
    //Contesting Elections
    public static var addElection = BasePath + "/add/elections"
    public static var updateElection = BasePath + "/update/elections"
    public static var deleteElection = BasePath + "/delete/elections"
    
    
    public static var ListElection = BasePath + "/list/elections"
    public static var ListElectionMembers = BasePath + "/list/elections/members"
    public static var ListPollingStations = BasePath + "/list/election/polling/station"
    public static var ListPollingResult = BasePath + "/list/election/polling/result"
    public static var postElectionResult = BasePath + "/post/election/polling/result"
    
    //Invite Member Via Sms
    public static var inviteMember = BasePath + "/add/election/member"
    //Change Password
    public static var changePassword = BasePath + "/account/change/password"
    
    
    
    
    
    
    
    
    
    
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
    public static var ListPollingStation = BasePath + "/list/pollstation"
    
    
    //Reporting
    public static var addReport = BasePath + "/add/reporting"
    public static var updateReport = BasePath + "/update/reporting"
    public static var deleteReport = BasePath + "/delete/reporting"
    public static var listReport = BasePath + "/list/reporting"
    public static var changeStatusReport = BasePath + "/change/reporting/status"
    
    
    //Complaints
    public static var ListComplaintTypes = BasePath + "/list/complaint/type"
    public static var AddComplaint = BasePath + "/add/complaint"
    public static var ListOwnedComplaints = BasePath + "/list/complaint/owned"
    public static var ListPublicComplaints = BasePath + "/list/complaint/public"
    public static var UpdateComplaint = BasePath + "/update/complaint"
    public static var DeleteComplaint = BasePath + "/delete/complaint"
    public static var AddComplaintComment = BasePath + "/add/complaint/comment"
    public static var UpdateComplaintComment = BasePath + "/update/complaint/comment"
    public static var DeleteComplaintComment = BasePath + "/delete/complaint/comment"
    public static var ListComplaintComment = BasePath + "/list/complaint/comment"
    public static var AddComplaintEndosrement = BasePath + "add/complaint/endorsement"

    // Surveys
    public static var ListSurveyByUserID = BasePath + "/list/survey/userid"
    public static var SurveyDetails = BasePath + "/detail/survey"
    public static var SurveySubmitAnswers = BasePath + "/add/door/answer"

    public static var ListParties = BasePath + "/list/parties"

}
