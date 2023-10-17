//
//  OTPInputView.swift
//  Campaigner
//
//  Created by Macbook  on 03/07/2023.
//
import SwiftUI

struct OTPInputView: View {
    @State private var otpDigits: [String] = Array(repeating: "", count: 4)

    var body: some View {
        VStack {
            Text("Enter OTP")
                .font(.title)

            HStack(spacing: 16) {
                ForEach(0..<otpDigits.count, id: \.self) { index in
                    OTPFieldView(digit: $otpDigits[index], nextResponder: {
                        if index < otpDigits.count - 1 {
                            // Move focus to the next box
                            DispatchQueue.main.async {
                                withAnimation {
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }
                                otpDigits[index + 1] = "" // Clear the next box
                            }
                        } else {
                            // Trigger a function when the last box is filled
                            verifyOTP()
                        }
                    }, isLastField: index == otpDigits.count - 1)
                }
            }

            Button(action: verifyOTP) {
                Text("Verify OTP")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
        }
        .padding()
    }

    private func verifyOTP() {
        // Implement your verification logic here
        let otp = otpDigits.joined()
        print("Verifying OTP: \(otp)")
    }
}
