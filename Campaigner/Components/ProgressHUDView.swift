//
//  ProgressHUDView.swift
//  Campaigner
//
//  Created by Macbook  on 09/06/2023.
//

import SwiftUI

struct ProgressHUDView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ActivityIndicator(style: .large)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                
                Text("Loading...")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            .padding()
        }
    }
}

struct ActivityIndicator: UIViewRepresentable {
    var style: UIActivityIndicatorView.Style
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        uiView.startAnimating()
    }
}


struct ProgressHUDView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressHUDView()
    }
}
