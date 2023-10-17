//
//  ConfirmationCodeInput.swift
//  Campaigner
//
//  Created by Macbook  on 02/07/2023.
//

import SwiftUI

struct ConfirmationCodeInput: View {
    @State private var confirmationCode: String = ""
    @State private var isCodeCompleted: Bool = false
    
    var onCodeCompleted: () -> Void
    
    var body: some View {
        VStack {
            Text("Confirmation Code")
                .font(.title)
            
            HStack(spacing: 10) {
                ForEach(0..<4) { index in
                    DigitTextField(text: digitBinding(index))
                        .frame(width: 50, height: 50)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .onChange(of: confirmationCode, perform: { code in
            if code.count == 4 {
                isCodeCompleted = true
                onCodeCompleted()
            } else {
                isCodeCompleted = false
            }
        })
    }
    
    private func digitBinding(_ index: Int) -> Binding<String> {
        let digitIndex = confirmationCode.index(confirmationCode.startIndex, offsetBy: index)
        let digit: String
        
        if confirmationCode.indices.contains(digitIndex) {
            digit = String(confirmationCode[digitIndex])
        } else {
            digit = ""
        }
        
        return Binding<String>(
            get: { digit },
            set: { newValue in
                if newValue.count <= 1 {
                    if confirmationCode.indices.contains(digitIndex) {
                        confirmationCode.replaceSubrange(digitIndex...digitIndex, with: newValue)
                    } else {
                        confirmationCode.insert(contentsOf: newValue, at: digitIndex)
                    }
                }
            }
        )
    }
}

struct DigitTextField: View {
    @Binding var text: String
    
    var body: some View {
        TextField("", text: $text)
            .font(.system(size: 20, weight: .bold))
    }
}


struct ConfirmationCodeInput_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationCodeInput(onCodeCompleted: {
            
        })
    }
}
