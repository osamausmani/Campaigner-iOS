//
//  CustomNavBar.swift
//  Campaigner
//
//  Created by Macbook  on 31/10/2023.
//

import SwiftUI
struct CustomNavBar<Destination: View>: View {
    let title: String
    var destinationView: Destination
    @Binding var isActive: Bool
    var trailingView: AnyView? = nil
    
    var body: some View {
        ZStack {
            HStack{
                NavigationLink("", destination: destinationView, isActive: $isActive)
                    .hidden() // Hide the default NavigationLink
                
                Button(action: {
                    self.isActive = true
                }) {
                    Image("back_arrow")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                .padding(.leading)
                if let trailing = trailingView {
                    trailing
                }
                Spacer()
            }.frame(maxWidth: .infinity, alignment: .center)
            ZStack{
                Text(title)
                    .font(.headline)
            }.frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.top, 40)
        .frame(height: 100)
        .background(Color.white)
        .edgesIgnoringSafeArea(.top)
        .border(Color.black, width: 1)
    }
}
