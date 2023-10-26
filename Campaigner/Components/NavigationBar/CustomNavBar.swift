//
//  CustomNavBar.swift
//  Campaigner
//
//  Created by Macbook  on 17/10/2023.
//

import SwiftUI
struct CustomNavBar<Destination: View>: View {
    let title: String
    var destinationView: Destination
    @Binding var isActive: Bool
    var trailingView: AnyView? = nil

    var body: some View {
        HStack {
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
            
            Spacer()
            
            Text(title)
                .font(.headline)
            
            Spacer()
            
            if let trailing = trailingView {
                trailing
            }
        }
        .padding(.top, 40)
        .frame(height: 100)
        .background(Color.white)
        .edgesIgnoringSafeArea(.top)
        .border(Color.black, width: 1)
    }
}


//struct CustomNavBar_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomNavBar(title: "abc")
//    }
//}
