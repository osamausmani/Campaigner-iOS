//
//  SideMenu.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/05/2023.
//

import SwiftUI

struct SideMenu: View {
    @Binding var isShowing: Bool
    var content: AnyView
    var edgeTransition: AnyTransition = .move(edge: .leading)
    var body: some View {
        ZStack(alignment: .bottom) {
            if (isShowing) {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                content
                    .transition(edgeTransition)
                    .background(
                        Color.clear
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
}



enum SideMenuRowType: Int, CaseIterable{
    case profile = 0
    case inviteMembers = 1
    case payments = 2
    case changepassword = 3
    case termsofuse = 4
    case contactus = 5
    case logout = 6
    
    var title: String{
        switch self {
        case .profile:
            return "Profile"
        case .inviteMembers:
            return "Invite Members"
        case .payments:
            return "Payments"
        case .changepassword:
            return "Change Password"
        case .termsofuse:
            return "Term of use"
        case .contactus:
            return "Constact Us"
        case .logout:
            return "Logout"
        }
    }
    
    var iconName: String{
        switch self {
        case .profile:
            return "profile"
        case .inviteMembers:
            return "member_add"
        case .payments:
            return "wallet_side"
        case .changepassword:
            return "change-password"
        case .termsofuse:
            return "term-of-services"
        case .contactus:
            return "contact_us_siden"
        case .logout:
            return "logout"
        }
    }
}
