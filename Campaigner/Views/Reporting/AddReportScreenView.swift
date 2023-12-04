//
//  ReportingScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 05/06/2023.
//

import SwiftUI
import Alamofire

struct AddReportScreenView: View {
@StateObject private var alertService = AlertService()
@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
var onDismiss: () -> Void
@State private var isLoading = false
@State private var cProvince = DropDownModel()
// @State private var isOn1 = true
@State private var isChecked = false
@State private var fvDescription = ""
@State var selectedImage: UIImage?
@State var reportingType = [ListReportingType]()
@State private var sourceType = 0
@State private var showImagePicker = false
@State private var showActionSheet = false
@State private var currentLocation = ""
@State private var isAddLocationView = false
@State var alertMsg = "Alert"
@State private var showSimpleAlert = false
@State private var canGoBack = false
@State  var reportingTypeName : [DropDownModel] = []

var body: some View {

ZStack {
BaseView(alertService: alertService)

ZStack{
//                    Image("splash_background")
//                        .resizable()
//                        .edgesIgnoringSafeArea(.all)

VStack{
HStack {
Button(action: {
self.presentationMode.wrappedValue.dismiss()
}) {

Image("back_arrow")
.resizable()
.frame(width: 24, height: 24).tint(CColors.MainThemeColor)
Spacer()
Text("Post a Report").tint(CColors.MainThemeColor).font(.system(size: 18))
Spacer()



}

}

.foregroundColor(.black)
.padding()
dividerline()

//   ScrollView{
VStack(spacing: 10) {

DropDown(label: "Type", placeholder: "Select type", selectedObj:  $cProvince, menuOptions: reportingTypeName).padding([.leading,.trailing],10)



// MultiLineTextField( title: "Description").padding(16)
MultilineFormInput(label: "Description", placeholder: "Enter Description", text: $fvDescription).padding([.leading,.trailing],10)

LocationField(label: "Address", placeholder: "", text: $currentLocation, buttonAction: {
isAddLocationView = true

})
.padding([.leading,.trailing],10)
HStack{

CheckboxFieldView(isChecked: $isChecked, label: "Mark as complaint")

//CustomButton(text: "Attachments", image: "paperclip").frame(width: 200, height: 40)
Text("File upload")
.bold()
.font(.system(size: 14))
CustomButton(text: "Attachment", image: "paperclip", action: {
showActionSheet = true
})
.actionSheet(isPresented: $showActionSheet) {
ActionSheet(title: Text("Select Image"), message: nil, buttons: [
.default(Text("Photo Library")) {
// Handle selection from photo library
self.sourceType = 0
self.showImagePicker = true
},
.default(Text("Camera"))
{
// Handle selection from camera
self.sourceType = 1
self.showImagePicker = true
},
.cancel()
])
}


}.padding(5)
// Spacer()

if let image = selectedImage {
Image(uiImage: image)
.resizable()
.aspectRatio(contentMode: .fit)
.frame(width: 150, height: 150)
} else {
Text("No image selected")
}

Divider()
Spacer()
//     CustomButton(text: "Submit" , image: "")

MainButton(action: {
addReport()
onDismiss()
}, label: "Submit").frame(maxWidth: 180,maxHeight: 40,alignment: .center) .frame(maxWidth: .infinity,
                                                     maxHeight: .infinity,
                                                     alignment: .top)

}
.background(Color.white)
.cornerRadius(10)

.shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 5)
.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 0))
.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
.padding([.leading,.trailing],10)


}
}
.background(CColors.CardBGColor)

NavigationLink(destination: AddLocationView(), isActive: $isAddLocationView) {
}
.navigationBarHidden(true)
}.sheet(isPresented: $showImagePicker)
{
ImageUploader(selectedImage: $selectedImage, sourceTypeNo: sourceType)
}
.background(CColors.CardBGColor)
//  }
.onAppear{
listReportingType()
    
}
.alert(isPresented: $showSimpleAlert) {
Alert(
title: Text("Alert"),
message: Text(alertMsg),
dismissButton: .default(Text("Ok")) {
// Optional completion block
if canGoBack {
DispatchQueue.main.asyncAfter(deadline: .now()) {
self.presentationMode.wrappedValue.dismiss()
}
}

}
)
}


}


func listReportingType(){
// isShowingLoader.toggle()
isLoading = true

let token = UserDefaults.standard.string(forKey: Constants.USER_SESSION_TOKEN)
let headers:HTTPHeaders = [
"Content-Type":"application/x-www-form-urlencoded",
"x-access-token": token!
]

let userID = UserDefaults.standard.string(forKey: Constants.USER_ID)



print(token!)

let parameters: [String:Any] = [
"plattype": Global.PlatType,
"user_id": userID!

]

//let registerViewModel = RegisterViewModel()
var newDropDownData : [DropDownModel] = []

let lookupViewModel = LookupsViewModel()

lookupViewModel.ListReportingTypes(parameters: parameters,headers: headers ) { result in
// isShowingLoader.toggle()
isLoading = false
print(result)
switch result {

case .success(let Response):

if Response.rescode == 1 {

print(Response)

//                    fin = loginResponse.data!
//
//                    provinceName

reportingType = Response.data!

for i in reportingType
{
let dropDownModel = DropDownModel(id: i.type_id!, value: i.type_name!)
newDropDownData.append(dropDownModel)
}
//  provinceName = []
//   provinceName.append(contentsOf: newDropDownData)

reportingTypeName = newDropDownData

//  self.presentationMode.wrappedValue.dismiss()


}else{
alertService.show(title: "Alert", message: Response.message!)
}

case .failure(let error):
alertService.show(title: "Alert", message: error.localizedDescription)
}
}
}
func addReport()
{

isLoading = true

var finReportType = ""
for i in reportingType{
if( i.type_name == cProvince.value)
{
finReportType = i.type_id ?? ""
}
}


let token = UserDefaults.standard.object(forKey: Constants.USER_SESSION_TOKEN) as! String

print(token)
let headers:HTTPHeaders = [
// "Content-Type":"application/x-www-form-urlencoded",
"x-access-token": token
]

var userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
let parameters: [String:Any] = [
"plattype": Global.PlatType,
"user_id": userID!,
"report_type": finReportType,
"report_desc": fvDescription,
"is_complaint": isChecked == true ? "1":"0",
"loc_lat": "0",
"loc_lng": "0",
"loc_text": "abc",
"file": ""



]

let reportingModel = ReportingViewModel()

reportingModel.AddReport(parameters: parameters , headers: headers) { result in
// isShowingLoader.toggle()
isLoading = false
switch result {

case .success(let addResponse):

if addResponse.rescode == 1 {
alertMsg = addResponse.message!
canGoBack = true
showSimpleAlert = true

}
else{
alertMsg = addResponse.message!
canGoBack = false
showSimpleAlert = true
}
case .failure(let error):
alertService.show(title: "Alert", message: error.localizedDescription)
}
}

}

func addAttachment()
{

}

func getReportType()
{

}


func submit()
{

}
}


struct AddReportScreenView_Previews: PreviewProvider {
static var previews: some View {
AddReportScreenView(onDismiss: {

})
}
}
