//
//  NotificationScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 06/06/2023.
//

import SwiftUI

struct NotificationScreenView: View {
@StateObject private var alertService = AlertService()
@State private var isNavBarLinkActive = false
@State private var isPresentNode:Bool=false
@State private var showCreateNotification = false
@State private var listNotification=[ScheduleDatum]()
@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
let height = UIScreen.main.bounds.height
let width = UIScreen.main.bounds.width

var body: some View {
ZStack {
BaseView(alertService: alertService)
if listNotification.isEmpty==false {
Image("logo")
.resizable()
.frame(width: width*0.8, height: height*0.5)
.opacity(0.09)
}

VStack {
//                    CustomNavBarBack(title: "Create Notification")
HStack {
Button(action: {
self.presentationMode.wrappedValue.dismiss()

}) {

Image("back_arrow")
.resizable()
.frame(width: 24, height: 24).tint(CColors.MainThemeColor)
Spacer()
Text("Create Promotion").tint(CColors.MainThemeColor).font(.system(size: 18))
Spacer()



}

}
.foregroundColor(.black)
.padding()
dividerline()

// Content
if listNotification.isEmpty {
VStack {
Image("no_record")

Text("No notification found")
.padding(.top, 30)
Text("Press + button to create notifications")
}
Spacer()
} else {
ScrollView{
ForEach(listNotification.indices, id: \.self) { index in
// Calculate Status and StatusColor based on your logic
let status = listNotification[index].status == 0 ? "Pending" : "Approved"
let statusColor = listNotification[index].status == 0 ? Color.blue : CColors.MainThemeColor

NotificationCustomCard(
statusText: status,
subjectText: listNotification[index].notifyTitle ?? "",
dateText: listNotification[index].notifyDtm ?? "",
detailText: listNotification[index].notifyDesc ?? "",
statusColor: statusColor,
detailImageTapAction: {

},
deleteImageTapAction: {
// Handle delete image tap action
}
)
.padding([.leading,.trailing],10)
Spacer()
}

}
}
}
VStack {


Spacer()
HStack {
Spacer()
AddButton(action: {
self.showCreateNotification.toggle()
}, label: "Add")
.padding()
}
}
NavigationLink("", destination: CreateNotificationView(), isActive: $showCreateNotification)
.hidden()


}

.navigationBarHidden(true)
.onAppear{
getNotification()
}
}
    
func getNotification() {
let parameters: [String: Any] = [
"plattype": Global.PlatType,
"user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!
]

let viewModel = NotificationViewModel()
viewModel.ListScheduleNotifications(parameters: parameters) { result in
switch result {
case .success(let response):
if let responseData = response.data {
// Use responseData directly, as it's already an array
listNotification = responseData
}

case .failure(let error):
alertService.show(title: "Alert", message: error.localizedDescription)
}
}
}

}





