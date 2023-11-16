//
//  LocationField.swift
//  Campaigner
//
//  Created by Macbook  on 09/11/2023.
//

import SwiftUI

struct LocationField: View {
    var label: String
    var placeholder: String
    @Binding var text: String
    var buttonAction: () -> Void

    var body: some View {
        VStack {
            Text(label)
                .alignmentGuide(.leading) { _ in 0 }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 15))

            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 10)
                        .font(.system(size: 16))
                }
                Button(action: buttonAction) {
                    TextField("", text: $text)
                        .disabled(true)
                        .foregroundColor(.black)
                        .frame(maxHeight: 30)
                        .padding(10)
                        .font(.system(size: 16))
                    
                    Image("location_blue")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 1)
            )
            .alignmentGuide(.leading) { _ in 0 }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct LocationField_Previews: PreviewProvider {
    @State private static var locationText = ""

    static var previews: some View {
        LocationField(label: "Abc", placeholder: "ddsdsd", text: $locationText, buttonAction: {
            print("Tapped LocationField")
        })
    }
}
