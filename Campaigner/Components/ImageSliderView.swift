//
//  ImageSliderView.swift
//  Campaigner
//
//  Created by Osama Usmani on 30/05/2023.
//

import SwiftUI

struct ImageSlider: View {
    
    // 1
    private let images = ["1", "1"]
    
    var body: some View {
        // 2
        TabView {
            ForEach(images, id: \.self) { item in
                 //3
                 Image(item)
                    .resizable()
                    .scaledToFill()
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct ImageSlider_Previews: PreviewProvider {
    static var previews: some View {
        // 4
        ImageSlider()
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
