//
//  CenterTitleModifier.swift
//  Campaigner
//
//  Created by Macbook  on 20/06/2023.
//

import Foundation
import SwiftUI

struct CenterTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .frame(width: geometry.size.width, height: geometry.safeAreaInsets.top)
                        .opacity(0.01)
                }
                .ignoresSafeArea(.all, edges: .top)
            )
    }
}








