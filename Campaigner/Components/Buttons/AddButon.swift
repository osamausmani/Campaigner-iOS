//
//  AddButon.swift
//  Campaigner
//
//  Created by Macbook  on 19/10/2023.
//

import SwiftUI

struct AddButon: View {
    var image: String
    
    var body: some View {
        Button(action: {
            // Handle button action
        }) {
            Image(systemName: image)
                .foregroundColor(.white)
                .font(.system(size: 24))
                .frame(width: 50, height: 50) // Equal width and height to form a circle
                .background(CColors.MainThemeColor)
                .clipShape(Circle()) // Clip the button to a circular shape
                .padding() // You can adjust this padding if necessary
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}


struct AddButon_Previews: PreviewProvider {
    static var previews: some View {
        AddButon(image: "plus")
    }
}
