//
//  CustomListStyle.swift
//  Campaigner
//
//  Created by Macbook  on 22/10/2023.
//

import Foundation
import SwiftUI
struct CustomListStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.green.opacity(1))
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

extension View {
    func customListStyle() -> some View {
        self.modifier(CustomListStyle())
    }
}
