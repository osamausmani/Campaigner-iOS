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
    public static var Register = BasePath + "/signup"

    public static var ForgotPassword = BasePath + "/account/forget/password"
    public static var SendVerifitcationCode = BasePath + "/account/send/verifycode"
    public static var ForgotPasswordChange = BasePath + "/account/verify/code"



}
