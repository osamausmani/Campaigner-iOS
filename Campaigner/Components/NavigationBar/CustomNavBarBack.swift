//
//  CustomNavBarBack.swift
//  Campaigner
//
//  Created by Osama Usmani on 04/11/2023.
//

import Foundation
import SwiftUI

struct CustomNavBarBack: View {
    let title: String
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            HStack{
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image("back_arrow")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                .padding(.leading)

                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .center)

            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.top, 40)
        .frame(height: 100)
        .background(Color.white)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.black) // Set the color of the border line
                .offset(y: 50) // Adjust the position of the line
        )
        .edgesIgnoringSafeArea(.top)
    }
}
struct CustomNavBarBack_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarBack(title: "Your Title")
    }
}
