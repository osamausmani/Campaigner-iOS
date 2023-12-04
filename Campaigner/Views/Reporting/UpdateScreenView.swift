//
//  UpdateScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 23/11/2023.
//

import SwiftUI
import Alamofire

struct UpdateScreenView: View {
@StateObject private var alertService = AlertService()
@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

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
@State  var reportingTypeName : [DropDownModel] = []
var reportId: String
var isComplaint: Int
var description:String
var typeReport:String
var image:UIImage?

var body: some View {

ZStack {
BaseView(alertService: alertService)

ZStack{
Image("splash_background")
.resizable()
.edgesIgnoringSafeArea(.all)





VStack(spacing: 10) {

CustomNavBarBack(title: "Post a report")




DropDown(label: "Type", placeholder: "Select type", selectedObj:  $cProvince, menuOptions: reportingTypeName).padding(16)

MultilineFormInput(label: "Description", placeholder: "Enter Description", text: $fvDescription).padding(10)

LocationField(label: "Address", placeholder: "", text: $currentLocation, buttonAction: {

})
.padding(16)
Spacer()
HStack{
CheckboxFieldView(isChecked: $isChecked, label: "Mark as complaint")

//CustomButton(text: "Attachments", image: "paperclip").frame(width: 200, height: 40)

MainButton(action: {
//
showActionSheet = true
// promptForImageSelection()

}, label: "Attachment").frame(maxWidth: 180,maxHeight: 60,alignment: .topTrailing).actionSheet(isPresented: $showActionSheet) {
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
updateReport(reportId: reportId, reportType:typeReport , isComplaint: isComplaint, description: description)
}, label: "Update").frame(maxWidth: 180,maxHeight: 40,alignment: .center) .frame(maxWidth: .infinity,
                                             maxHeight: .infinity,
                                             alignment: .top)

}

}
}.sheet(isPresented: $showImagePicker)
{
ImageUploader(selectedImage: $selectedImage, sourceTypeNo: sourceType)
}
//  }
.onAppear{

}
.navigationBarBackButtonHidden(true)

}




func updateReport(reportId:String,reportType:String,isComplaint: Int,description:String)
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
"report_id":reportId,
"report_type":finReportType ,
"report_desc": fvDescription,
"is_complaint": isChecked ? 1 : 0,
"loc_lat":"",
"loc_lng": "" ,
"loc_text":"" ,
"file":selectedImage ?? ""

]

let reportingModel = ReportingViewModel()

reportingModel.UpdateReport(parameters: parameters , headers: headers) { result in
// isShowingLoader.toggle()
isLoading = false
switch result {

case .success(let Response):

if Response.rescode == 1 {

alertService.show(title: "Alert", message: Response.message!)


}else{
alertService.show(title: "Alert", message: Response.message!)
}

case .failure(let error):
alertService.show(title: "Alert", message: error.localizedDescription)
}
}

}


func getReportType()
{

}


}
