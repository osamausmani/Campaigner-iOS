//
//  FeatureRow.swift
//  Campaigner
//
//  Created by Macbook  on 05/12/2023.
//

import SwiftUI

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(spacing: 5) {
            Image(icon)
                .resizable()
                .frame(width: 40, height: 40)

            VStack(alignment: .leading, spacing: 2) {
                Text(title + description)
                    .font(.system(size: 16))
                    
            }
        }
    }
}
struct FeatureRow_Previews: PreviewProvider {
    static var previews: some View {
        FeatureRow(icon: "tick", title: "Surveys", description: "aaaaaabasbjabsjabsjabsjbajsbjabsjabsjbajsbjabsjbajsbajsbjabsjbajsbajsbjabsjbajsbajsbjabsjabsjbajsbjabsjbajbsjabsjb")
    }
}
