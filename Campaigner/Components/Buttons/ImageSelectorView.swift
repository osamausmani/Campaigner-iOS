//
//  ImageSelectorView.swift
//  Campaigner
//
//  Created by Macbook  on 17/06/2023.
//

import SwiftUI

struct ImageSelectorView: View {
    var imageUrls: [String]
    var text: [String]
    var action: () -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack {
                ForEach(imageUrls.indices, id: \.self) { index in
                    VStack {
                        Button(action: {
                            // Action when image is clicked
                            action()
                        }) {
                            VStack {
                                if let url = URL(string: imageUrls[index]) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                } else {
                                    Image(systemName: "default_large_image")
                                        .resizable()
                                        .scaledToFit()
                                }
                                Text(text[index])
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .frame(width: 120, height: 100)
                }
            }
        }
    }
}

struct ImageSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSelectorView(imageUrls: [], text: []) {
            
        }
    }
}
