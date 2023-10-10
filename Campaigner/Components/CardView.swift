//
//  CardView.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/10/2023.
//

import Foundation
import SwiftUI

import SwiftUI

struct CardView<Content: View>: View {
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: geometry.size.width, height: geometry.size.height) // Dynamic height

                    .cornerRadius(10) // Adjust corner radius as needed
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2) // Add shadow
                    .overlay(
                        content
                    )
            }
        }
    }
}


