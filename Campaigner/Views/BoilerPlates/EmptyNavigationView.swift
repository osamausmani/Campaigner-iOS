//
//  EmptyNavigationView.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/10/2023.
//

import Foundation
import SwiftUI

struct EmptyNavigationView: View {
    @StateObject private var alertService = AlertService()

    var body: some View {
        NavigationView {
            ZStack {
                BaseView(alertService: alertService)
                HStack{
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity).background(CColors.MainThemeColor)
            }
        }
        .navigationBarHidden(false)
        .navigationTitle("NavTitle")
    }
}

struct EmptyNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyNavigationView()
    }
}
