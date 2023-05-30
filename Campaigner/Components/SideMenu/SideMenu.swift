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
    case invitemembers
    case changepassword
    case logout
    
    var title: String{
        switch self {
        case .profile:
            return "Profile"
        case .invitemembers:
            return "Inivite Members"
        case .changepassword:
            return "Change Password"
        case .logout:
            return "Logout"
        }
    }
    
    var iconName: String{
        switch self {
        case .profile:
            return "home"
        case .invitemembers:
            return "favorite"
        case .changepassword:
            return "chat"
        case .logout:
            return "profile"
        }
    }
}
