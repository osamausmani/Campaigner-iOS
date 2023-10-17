//
//  PoliticalSection.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/05/2023.
//

import Foundation
import SwiftUI
import Alamofire
import AlertToast

struct PoliticalSection: View {
    var body: some View {
        VStack {
            VStack {
                Text("PoliticalSection")
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



struct PoliticalSection_Previews: PreviewProvider {
    static var previews: some View {
        PoliticalSection()
    }
}
