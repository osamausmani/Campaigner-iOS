//
//  CustomAlertView.swift
//  Campaigner
//
//  Created by Macbook  on 24/10/2023.
//

import SwiftUI

struct CustomAlertView: View {
    let message: String
    let buttonTitle: String
    let CalcelbuttonAction: () -> Void
    let UpgradebuttonAction:()-> Void
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Spacer() 
                
                Button(action: CalcelbuttonAction) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(Color.red)
                }
                .padding(.trailing, 10)
                .padding(.top, 10)
            }
            
            Text(message)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
            
            MainButton(action: UpgradebuttonAction, label: buttonTitle)
                .padding(.horizontal, 100)
                .padding(.vertical, 20)
        }
        .background(Color.white)
        .cornerRadius(20)
        .padding()
        .shadow(radius: 10)
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView(message: "This is a test message", buttonTitle: "Okay") {
            print("Button tapped!")
        } UpgradebuttonAction: {
            
        }
    }
}
