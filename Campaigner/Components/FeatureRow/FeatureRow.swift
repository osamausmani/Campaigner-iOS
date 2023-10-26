//
//  FeatureRow.swift
//  Campaigner
//
//  Created by Macbook  on 24/10/2023.
//

import SwiftUI

struct FeatureRow: View {
    let icon: String
       let title: String
       let description: String
       
       var body: some View {
           HStack(alignment: .top, spacing: 5) {
               Image(icon)
                   .resizable()
                   .frame(width: 30,height: 30)
               VStack(alignment: .leading) {
                   Text(title)
                       .bold()
                   Text(description)
               }
           }
       }
}

struct FeatureRow_Previews: PreviewProvider {
    static var previews: some View {
        FeatureRow(icon: "tick", title: "aaaaaaaaaa", description: "a")
    }
}
