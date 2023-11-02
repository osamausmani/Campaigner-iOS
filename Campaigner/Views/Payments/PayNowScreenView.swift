//
//  PayNowScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 15/06/2023.
//


import SwiftUI
import Alamofire

struct PayNowScreenView: View {
    
    
    @Binding var selectedPayment : [ListPendingPayments]
    @State private var showActionSheet = false
    
    @State private var fvBank = DropDownModel()
    @State private var fvAccountTitle = ""
    @State private var fvAccountNumber = ""
    @State private var fvAmount = ""
    @State private var fvReferenceNumber = ""
    //@State private var fvConfirmPassword = ""
    
    @State private var bankList = [ListBanks]()
    
    @State private var showRegisterScreen = false
    @State private var isShowingLoader = false
    @State private var mediaData : Data?
    @State private var sourceType = 0
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    @State var showStoreDropDown: Bool = false
    
    @StateObject private var alertService = AlertService()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
   // @EnvironmentObject var dataStore: DataStorePayments

    @State var selectedImage: UIImage?
    
    @State private var showImagePicker = false
    
 @State  private var bankOptions: [DropDownModel] = [
//        DropDownModel(id: "1", value: "MCB"),
//        DropDownModel(id: "2", value: "UBL"),
//        DropDownModel(id: "3", value: "HBL"),
//        DropDownModel(id: "4", value: "SILK"),
//        DropDownModel(id: "5", value: "ALLIED"),
    ]
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                BaseView(alertService: alertService)
                
                ZStack{
                    
                    Image("splash_background")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    
                    ScrollView{
                        
                        // Navigation bar
                        HStack {
                            Button(action: {
                                // Perform action for burger icon
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "chevron.left").tint(CColors.MainThemeColor).font(.system(size: 18))
                                Text("Back").tint(CColors.MainThemeColor).font(.system(size: 18))
    
                            }
                          //  Spacer()
                            Text("Pay Now")
                                .font(.headline)
                               // .multilineTextAlignment(.center)
                               // .padding(.leading)
                                .frame(width: 250)
    
                            Spacer()
    
                        }.foregroundColor(CColors.MainThemeColor)
                            .padding()
                            .navigationBarHidden(true)
    
                      //  Divider()
                        
                        VStack {
                            
                            
                            DropDown(label: "Bank", placeholder: "Select Bank", selectedObj:  $fvBank, menuOptions: bankOptions )
                            
                            FormInputField(label: "Account Title", placeholder: "Enter Account Title", text: $fvAccountTitle)
                            
                            FormInputField(label: "Account Number", placeholder: "Enter Account Number", text: $fvAccountNumber)

                            FormInputField(label: "Amount", placeholder: "Enter Amount", text: $fvAmount)
                            FormInputField(label: "Reference Number", placeholder: "Enter Reference Number", text: $fvReferenceNumber)
                            
                            HStack{
                                Text("File upload:")
                                MainButton(action: {
                                  //
                                    showActionSheet = true
                                   // promptForImageSelection()
                                    
                                }, label: "Attachment").frame(maxWidth: 180,maxHeight: 80,alignment: .topTrailing).actionSheet(isPresented: $showActionSheet) {
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
                                
                                if let image = selectedImage {
                                               Image(uiImage: image)
                                                   .resizable()
                                                   .aspectRatio(contentMode: .fit)
                                                   .frame(width: 50, height: 50)
                                           } else {
                                               Text("No image selected")
                                           }
                            }
                            MainButton(action: {
                                RegisterAction()
                            }, label: "Submit").padding(.top,20)
                            
                            
                            
                            
                        }.padding(16)
                        
                    }
                    
                    if isShowingLoader {
                        Loader(isShowing: $isShowingLoader)
                            .edgesIgnoringSafeArea(.all)
                    }
                }
                
                
            }
            .sheet(isPresented: $showImagePicker)
               {
                ImageUploader(selectedImage: $selectedImage, sourceTypeNo: sourceType)
                }
            .offset(y: kGuardian.slide).animation(.easeInOut(duration: 1.0))
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
          
            
            
        }.navigationBarHidden(false)
            .navigationTitle("Sign Up")
            .onAppear{
                getBankList()
            }
    }
    
    
    
    
//    private func promptForImageSelection() {
//        let actionSheet = ActionSheet(title: Text("Select Image"), message: nil, buttons: [
//            .default(Text("Photo Library")) {
//                sourceType = 0
//                showImagePicker = true
//            },
//            .default(Text("Camera")) {
//                sourceType = 1
//                showImagePicker = true
//            },
//            .cancel()
//        ])
//
//        // Present the action sheet
//        showActionSheet = true
//    }
    
    // Add Other Swift Functions Below Here
    
//    private func promptForImageSelection() {
//        let alertController = UIAlertController(title: "Select Image", message: nil, preferredStyle: .actionSheet)
//
//        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
//           //photo
//            sourceType = 0
//            showImagePicker = true
//          // ImageUploader(selectedImage: <#T##Binding<UIImage?>#>, sourceTypeNo: 0)
//
//        }
//        alertController.addAction(photoLibraryAction)
//
//        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
//            //ImageUploader(sourceType: .camera)
//            //camera
//            sourceType = 1
//            showImagePicker = true
//        }
//        alertController.addAction(cameraAction)
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        alertController.addAction(cancelAction)
//
//        UIApplication.shared.windows.last?.rootViewController?.present(alertController, animated: true, completion: nil)
//    }
    
//    private func promptForImageSelection() {
//        let alertController = UIAlertController(title: "Select Image", message: nil, preferredStyle: .actionSheet)
//
//        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
//            self.sourceType = 0
//            self.showImagePicker = true
//        }
//        alertController.addAction(photoLibraryAction)
//
//        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
//            self.sourceType = 1
//            self.showImagePicker = true
//        }
//        alertController.addAction(cameraAction)
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        alertController.addAction(cancelAction)
//
//        // Check if another UIAlertController is already being presented
//        if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
//            if let presentedViewController = rootViewController.presentedViewController {
//                presentedViewController.dismiss(animated: true) {
//                    rootViewController.present(alertController, animated: true, completion: nil)
//                }
//            } else {
//                rootViewController.present(alertController, animated: true, completion: nil)
//            }
//        }
//    }
    
    func RegisterAction(){
        validateInputs()
    }
    
    
    func validateInputs(){
        if(fvBank.value.isEmpty){
            alertService.show(title: "Alert", message: "Bank is required")
        }
        
        else if(fvAccountTitle.isEmpty){
            alertService.show(title: "Alert", message: "Account Number is required")
        }
        
        else if(fvAccountNumber.isEmpty){
            alertService.show(title: "Alert", message: "Account Number is required")
        }
        
        else if(fvAmount.isEmpty){
            alertService.show(title: "Alert", message: "Amount is required")
        }
        else if(Int(fvAmount)! < selectedPayment[0].fee_value!){
            alertService.show(title: "Alert", message: "Amount cannot be less than \(selectedPayment[0].fee_value)")
        }
        else if (selectedImage == nil)
        {
            alertService.show(title: "Alert", message: "Please select an image")
        }
        
//        else if(fvReferenceNumber.isEmpty){
//            alertService.show(title: "Alert", message: "Password is required")
//        }
        

        else{
            payFee()
        }
    }
    
    
//    func payFee(){
//        isShowingLoader.toggle()
//
//        let userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
//        let parameters: [String:Any] = [
//            "plattype": Global.PlatType,
//            "user_cnic": userID ?? "",
//            "fee_id": dataStore.fee_id,
//            "amount": fvAmount,
//            "fee_method" : "3",
//            "bank_id": fvBank.id
//            "file"
//
//
//        ]
//
//        let paymentViewModel = PaymentsViewModel()
//
//        paymentViewModel.payFeeRequest(parameters: parameters ) { result in
//            isShowingLoader.toggle()
//
//            switch result {
//
//            case .success(let payFeeResponse):
//
//                if payFeeResponse.rescode == 1 {
//
//                    alertService.show(title: "Alert", message: payFeeResponse.message!)
//
//                    self.presentationMode.wrappedValue.dismiss()
//
//                }else{
//                    alertService.show(title: "Alert", message: payFeeResponse.message!)
//                }
//
//            case .failure(let error):
//                alertService.show(title: "Alert", message: error.localizedDescription)
//            }
//        }
//    }
    

//    func payFee() {
//        isShowingLoader.toggle()
//
//        let REQ_URL = ApiPaths.payFee
//        let userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
//        guard let token = UserDefaults.standard.string(forKey: Constants.USER_SESSION_TOKEN) else {
//            // Handle missing token
//            return
//        }
//
//        let headers: HTTPHeaders = [
//            "x-access-token": token
//        ]
//
//        var params: [String: Any] = [
//            "plattype": Global.PlatType,
//            "user_cnic": userID ?? "",
//            "fee_id": selectedPayment[0].fee_id ?? "",
//            "amount": fvAmount,
//            "fee_method": "3",
//            "bank_id": fvBank.id
//        ]
//
//        AF.upload(multipartFormData: { multipartFormData in
//            for (key, value) in params {
//                if let imageData = selectedImage?.jpegData(compressionQuality: 0.2) {
//                    multipartFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
//                }
//                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
//            }
//        }, to: REQ_URL, method: .post, headers: headers)
//        .uploadProgress(queue: .main) { progress in
//            // Handle progress updates if needed
//            // For example, update UI progress bar
//        }
//        .validate()
//        .responseData { response in
//            isShowingLoader.toggle()
//
//            switch response.result {
//            case .success(let data):
//                do {
//                    let decoder = JSONDecoder()
//                    let payFeeResponse = try decoder.decode(ListBanksResponse.self, from: data)
//                    // Handle the parsed response
//                    // ...
//                    print(payFeeResponse)
//                } catch {
//                    // Handle parsing error
//                    alertService.show(title: "Alert", message: error.localizedDescription)
//                }
//
//            case .failure(let error):
//                // Handle failure
//                alertService.show(title: "Alert", message: error.localizedDescription)
//            }
//        }
//    }
    
    func payFee() {
        isShowingLoader.toggle()

        let userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        let parameters: [String: Any] = [
            "plattype": Global.PlatType,
            "user_id": userID ?? "",
            "fee_id": selectedPayment[0].fee_id ?? "",
            "amount": fvAmount,
            "fee_method": "3",
            "bank_id": fvBank.id
        ]
print(parameters)
        let imageData = selectedImage?.jpegData(compressionQuality: 0.2)

        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let data = "\(value)".data(using: .utf8) {
                    multipartFormData.append(data, withName: key)
                }
            }
            if let imageData = imageData {
                multipartFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
            }
        }, to: ApiPaths.payFee, method: .post, headers: nil)
        .validate()
        .responseData { response in
            isShowingLoader.toggle()

            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let payFeeResponse = try decoder.decode(ListBanksResponse.self, from: data)
                    // Handle the parsed response
                    // ...
                    print(payFeeResponse)
                } catch {
                    // Handle parsing error
                    alertService.show(title: "Alert", message: error.localizedDescription)
                }

            case .failure(let error):
                // Handle failure
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    
    func getBankList()
    {
        isShowingLoader.toggle()
        
        let userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID ?? ""

        ]
        
        let paymentViewModel = PaymentsViewModel()
        var newDropDownData : [DropDownModel] = []
        
        paymentViewModel.bankListRequest(parameters: parameters ) { result in
            isShowingLoader.toggle()
            
            switch result {
                
            case .success(let bankListResponse):
                
                if bankListResponse.rescode == 1 {
                    
                   // bankList
                    bankList = bankListResponse.data!
                    
                    for i in bankList
                    {
                        let dropDownModel = DropDownModel(id: i.bank_id!, value: i.bank_name!)
                        newDropDownData.append(dropDownModel)
                    }
                    
                    bankOptions = newDropDownData
                    
                }else{
                    alertService.show(title: "Alert", message: bankListResponse.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    
    
}

struct PayNowScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PayNowScreenView(selectedPayment: .constant([]))
    }
}
