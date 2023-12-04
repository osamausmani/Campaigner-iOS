//
//  CoinsView.swift
//  Campaigner
//
//  Created by Macbook  on 28/11/2023.
//

import SwiftUI

struct AudienceView: View {


let title: String
let totalAudienceMember: String
let crossButtonAction: () -> Void
let audienceCount: Binding<Int>
let Submit: () -> Void

var body: some View {
VStack(alignment: .center) {
HStack {
Text(title)
.font(.headline)
.padding()
.foregroundColor(.white)

Spacer()

Button(action: crossButtonAction) {
Image(systemName: "xmark.circle.fill")
.font(.title)
.padding()
}
.foregroundColor(.white)
}
.background(CColors.MainThemeColor)

HStack {
Text("Audience Members:")
.font(.headline)
.bold()

Text(totalAudienceMember)
.font(.headline)
.bold()
}

Image("man")
.resizable()
.frame(width: 80, height: 80)

TextField("", text: Binding(
get: { String(audienceCount.wrappedValue) },
set: { newValue in
if let intValue = Int(newValue) {
audienceCount.wrappedValue = intValue
}
}
))
.multilineTextAlignment(.center)
.background(Color.gray)
.frame(width: 80)

Text("Each respondent will be awarded a given number of coins from your wallet if you so designated. How many respondents do you want for this notification?")
.padding(.horizontal, 20)
.multilineTextAlignment(.center)
.frame(maxWidth: .infinity)

Divider()

MainButton(action: Submit, label: "Submit")
.padding([.leading,.trailing],60)
.padding(.bottom,20)
}
.background(.white)
.padding()
.frame(height: 750)
}
}


struct CoinsView_Previews: PreviewProvider {
static var previews: some View {
AudienceView(
title: "Notification",
totalAudienceMember: "0",
crossButtonAction: {},
audienceCount: .constant(00),
Submit: {}
)
}
}

