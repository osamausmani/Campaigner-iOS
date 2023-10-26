//
//  dividerline.swift
//  Campaigner
//
//  Created by Macbook  on 17/10/2023.
//

import Foundation
import SwiftUI
struct dividerline: View {
    var body: some View {
        Rectangle()
            .fill(Color.black)
            .frame(height: 1)
    }
}
struct dividerline_Previews: PreviewProvider {
    static var previews: some View {
        dividerline()
    }
}
