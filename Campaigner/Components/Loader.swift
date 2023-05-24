//
//  Loader.swift
//  Campaigner
//
//  Created by Osama Usmani on 22/05/2023.
//

import Foundation

import SwiftUI
import SwiftUI

struct Loader: View {
    @Binding var isShowing: Bool
       var loaderColor: Color = .blue // Specify the desired loader color
       
       var body: some View {
           ZStack {
               Color.black.opacity(colorOpacity)
                   .edgesIgnoringSafeArea(.all)
                   .opacity(isShowing ? 1 : 0)
                   .animation(.easeInOut)
               
               VStack {
                   ProgressView()
                       .progressViewStyle(CircularProgressViewStyle())
                       .scaleEffect(2)
                       .padding()
                       .foregroundColor(loaderColor) // Set the loader color
                       .opacity(1) // Maintain full opacity for loader color
               }
               .frame(maxWidth: .infinity, maxHeight: .infinity) // Occupy full screen
               .background(loadingViewBackgroundColor)
               .cornerRadius(10)
               .opacity(isShowing ? 1 : 0)
               .animation(.easeInOut)
           }
       }
       
       var colorOpacity: Double {
           return isShowing ? 0.3 : 0
       }
       
       var loadingViewBackgroundColor: Color {
           let lightOpacityColor = Color.white.opacity(colorOpacity)
           let darkOpacityColor = Color.black.opacity(colorOpacity)
           
           return lightOpacityColor
           
       }
   }
