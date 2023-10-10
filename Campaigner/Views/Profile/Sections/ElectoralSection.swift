//
//  ElectoralSection.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/05/2023.
//

import Foundation
import SwiftUI
import Alamofire
import AlertToast

struct ElectoralSection: View {
    var body: some View {
        VStack {
            VStack {
                Text("ElectoralSection")
                    .font(.system(size: 14))
                    .padding()
                    .frame(height: 40)
                    .background(CColors.MainThemeColor)
                    .foregroundColor(.white)
                    .cornerRadius(4)
                Spacer()
            }
        }
    }
}



struct ElectoralSection_Previews: PreviewProvider {
    static var previews: some View {
        ElectoralSection()
    }
}
