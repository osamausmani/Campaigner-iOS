//
//  HomeProRectangle.swift
//  Campaigner
//
//  Created by Macbook  on 17/10/2023.
//
import Foundation
import SwiftUI

struct RoundedRectangleLabelView: View {
    var text: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 1)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.clear))
                .frame(width: 400, height: 115)
            
            Text(text)
                .foregroundColor(.black)
                .font(.title3)
                .bold()
                .padding(.horizontal, 10)
                .background(Color.white) // to cover the rectangle's border under the text
                .padding(.horizontal, 25) // to extend the background a bit more horizontally
                .offset(x: -5, y: -10) // shifting the label to inset into the rectangle
        }
    }
}


struct RoundedRectangleLabelView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectangleLabelView(text: "halka Pro")
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

