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
    case wallet = 1
    case inviteMembers = 2
    case payments = 3
    case upgradeAccunt = 4
    case manageConstituencey = 5
    case degradeAccount = 6
    case changepassword = 7
    case termsofuse = 8
    case contactus = 9
    case logout = 10
    
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
        case .wallet:
            return "Wallet"
        case .upgradeAccunt:
            return "Upgrade Account"
        case .manageConstituencey:
            return "Manage Constituencey"
        case .degradeAccount:
            return "Degrade Account"
        }
    }
    
    var iconName: String{
        switch self {
        case .profile:
            return "proifile_side"
        case .inviteMembers:
            return "invite_member_side"
        case .payments:
            return "payment_side"
        case .changepassword:
            return "change-password"
        case .termsofuse:
            return "term-of-services"
        case .contactus:
            return "contact_us_siden"
        case .logout:
            return "logout_side"
        case .wallet:
            return "wallet_side"
        case .upgradeAccunt:
            return "down_account_side"
        case .manageConstituencey:
            return "manage_cons_side"
        case .degradeAccount:
            return "down_account_side"
        }
    }
}
