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
    var action: (Int) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(imageUrls.indices, id: \.self) { index in
                    VStack {
                        Button(action: {
                            action(index)
                        }) {
                            VStack {
                                if let url = URL(string: imageUrls[index]) {
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
                                }
                                Text(text[index])
                                    .font(.caption)
                                    .foregroundColor(.black).lineLimit(1)
                            }.padding(4)
                        }
                    }
                    .frame(width: 120, height: 100).padding(4)
                }
            }
        }
    }
}

//struct ImageSelectorView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageSelectorView(imageUrls: [], text: []) {
//            
//        }
//    }
//}
