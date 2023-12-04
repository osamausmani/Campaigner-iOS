//
//  NotificationCustomCard.swift
//  Campaigner
//
//  Created by Macbook  on 01/12/2023.
//

import SwiftUI

struct NotificationCustomCard: View {
let statusText: String
let subjectText: String
let dateText: String
let detailText: String
let statusColor: Color
let detailImageTapAction: () -> Void
let deleteImageTapAction: () -> Void

var body: some View {
VStack(alignment: .leading) {
HStack {
Text(statusText)
.foregroundColor(statusColor)
.bold()
Spacer()
Image("detail")
.resizable()
.frame(width: 20, height: 20)
.onTapGesture {
detailImageTapAction()
}
Image("delete_black")
.resizable()
.frame(width: 20, height: 20)
.onTapGesture {
deleteImageTapAction()
}
}
HStack {
Text(subjectText)
.font(.system(size: 13))
.bold()
Spacer()
Text(dateText)
.font(.system(size: 10))
.frame(alignment: .trailing)
}
Text(detailText)
.font(.system(size: 13))
}
.padding(8)
.background(CColors.CardBGColor)
.cornerRadius(10)
.shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 5)
.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
}
}

#if DEBUG
struct NotificationCustomCard_Previews: PreviewProvider {
static var previews: some View {
NotificationCustomCard(
statusText: "Completed",
subjectText: "Subject",
dateText: "30 November 2023, 3:24 PM",
detailText: "Detail",
statusColor: CColors.MainThemeColor,
detailImageTapAction: {
// Action for detail image tap
print("Detail Image Tapped")
},
deleteImageTapAction: {
// Action for delete image tap
print("Delete Image Tapped")
}
)
.previewLayout(.sizeThatFits)
}
}
#endif
