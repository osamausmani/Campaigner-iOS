//
//  CustomAlertView.swift
//  Campaigner
//
//  Created by Macbook  on 31/10/2023.
//

import SwiftUI
struct CustomAlertView: View {
    let message: String
    let buttonTitle: String
    let CancelButtonAction: () -> Void
    let UpgradeButtonAction: () -> Void

    @State private var isAlertVisible = false
    let alertHeight: CGFloat = 160 // Set the alert's height here

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()

                VStack {
                    Spacer()

                    HStack {
                        Spacer()
                        Button(action: CancelButtonAction) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .foregroundColor(Color.red)
                                .padding(.trailing, 10)
                                .padding(.top, 10)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)

                    Text(message)
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                        .frame(maxWidth: .infinity, alignment: .center)

                    MainButton(action: {
                        withAnimation {
                            isAlertVisible = false
                        }
                        UpgradeButtonAction()
                    }, label: buttonTitle)
                    .padding(.horizontal, 60)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                }
                .background(Color.white)
                .frame(width: min(350, geometry.size.width - 40), height: alertHeight)
                .cornerRadius(20)
                .padding()
                .offset(y: isAlertVisible ? 0 : geometry.size.height - alertHeight)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.8)) {
                isAlertVisible = true
            }
        }
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView(message: "This is a test message", buttonTitle: "Okay") {
            print("Button tapped!")
        } UpgradeButtonAction: {
            print("Upgrade button tapped!")
        }
    }
}
