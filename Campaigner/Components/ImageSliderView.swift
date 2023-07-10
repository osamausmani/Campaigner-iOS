//
//  ImageSliderView.swift
//  Campaigner
//
//  Created by Osama Usmani on 30/05/2023.
//

import SwiftUI

struct ImageSlider: View {
     var images: [String] = []

    var body: some View {
        TabView {
            ForEach(images, id: \.self) { imageURL in
                if let url = URL(string: imageURL) {
                                   AsyncImage(url: url) { image in
                                       image
                                           .resizable()
                                           .scaledToFill()
                                   } placeholder: {
                                       ProgressView()
                                   }
                               } else {
                                   Image(systemName: "default_large_image")
                                       .resizable()
                                       .scaledToFit()
                                       .foregroundColor(.gray)
                               }
                           }
                       }
                       .tabViewStyle(PageTabViewStyle())
                   }


}

struct ImageSlider_Previews: PreviewProvider {
    static var previews: some View {
        ImageSlider(images: [])
            .previewLayout(.fixed(width: 400, height: 150))
    }
}
