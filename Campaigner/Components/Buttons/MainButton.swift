//
//  MainButton.swift
//  Campaigner
//
//  Created by Osama Usmani on 22/05/2023.
//

import SwiftUI


struct MainButton : View{
    
    var action: () -> Void
    var label: String
    
    var customHeight:CGFloat?
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .frame(maxWidth: .infinity)
                .padding()
                .background(CColors.MainThemeColor)
                .foregroundColor(.white)
                .font(.headline)
                .cornerRadius(5)
                .frame(maxHeight: customHeight)

        }
    }
}
struct MainButton_Previews: PreviewProvider {
    static var previews: some View {
        MainButton(action: {}, label: "Pay now")
    }
}
