//
//  OTPFieldView.swift
//  Campaigner
//
//  Created by Macbook  on 03/07/2023.
//

import SwiftUI

struct OTPFieldView: View {
    @Binding var digit: String
    var nextResponder: (() -> Void)?
    var isLastField: Bool
    
    var body: some View {
        TextField("", text: Binding(
            get: { digit },
            set: { newValue in
                if newValue.count <= 1 {
                    digit = newValue
                    if newValue.count == 1 {
                        if isLastField {
                            nextResponder?()
                        } else {
                            DispatchQueue.main.async {
                                nextResponder?()
                            }
                        }
                    }
                }
            }
        ))
        .frame(width: 40, height: 40)
        .font(.title)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .multilineTextAlignment(.center)
        .keyboardType(.numberPad)
        
    }
}
