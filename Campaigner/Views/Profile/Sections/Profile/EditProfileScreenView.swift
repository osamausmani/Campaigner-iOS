//
//  EditProfileScreenView.swift
//  Campaigner
//
//  Created by Osama Usmani on 04/11/2023.
//

import Foundation
import SwiftUI
import SwiftAlertView

struct EditProfileScreenView: View {
    @StateObject private var alertService = AlertService()
    
    @State private var inputName = ""
    @State private var selectedCategory = DropDownModel()
    @State private var selectedProvince = DropDownModel()
    @State private var selectedDistrict = DropDownModel()
    
    @State private var description = ""
    @State private var networkOptions: [DropDownModel] = []
    @State private var provinceOptions: [DropDownModel] = []
    @State private var districtOptions: [DropDownModel] = []
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State public var isEdit = false
    @State public var item : ComplaintListDataItem?
    
    
    @State private var isShowingLoader = false
    @State private var showActionSheet = false
    @State private var sourceType = 0
    @State private var showImagePicker = false
    @State var selectedImage: UIImage?
    
    
    
    var body: some View {
        
        
        ZStack{
            Image("splash_background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                CustomNavBarBack(title: "Edit Profile")
                ScrollView{
                    VStack{
                        ZStack {
                            ZStack {
                                Image(uiImage: (selectedImage != nil ? UIImage(cgImage: selectedImage!.cgImage!) : UIImage(named: "default_large_image"))!)
                                    .resizable()
                                    .cornerRadius(60)
                                    .frame(width: 120, height: 120)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 60)
                                            .stroke(Color.black, lineWidth: 1)
                                    )
                                    .alignmentGuide(.bottom) { d in d[.bottom] }
                                HStack{Image("camera_dialog")
                                        .resizable()
                                        .cornerRadius(10)
                                        .frame(width: 24, height: 24).padding(2)
                                }.background(.white).cornerRadius(10).overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.black, lineWidth: 1)
                                ).padding(.top, 80).padding(.leading, 80).onTapGesture {
                                    showActionSheet.toggle()
                                }.actionSheet(isPresented: $showActionSheet) {
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
                            }.padding(20)
                        }
                        
                        HStack{
                            VStack {
                                FormInputField(label: "Name", placeholder: "Enter Name", text: $inputName)
                                DropDown(label: "Gender", placeholder: "Select Gender", selectedObj:  $selectedCategory, menuOptions: networkOptions )
                                DropDown(label: "District", placeholder: "Select District", selectedObj:  $selectedDistrict, menuOptions: districtOptions )
                                DropDown(label: "Tehsil/City/Town", placeholder: "Select Tehsil/City/Town", selectedObj:  $selectedDistrict, menuOptions: districtOptions )
                                DropDown(label: "National Assembly (NA)", placeholder: "Select National Assembly", selectedObj:  $selectedDistrict, menuOptions: districtOptions )
                                DropDown(label: "Provincial Assembly", placeholder: "Select Provincial Assembly", selectedObj:  $selectedDistrict, menuOptions: districtOptions )
                                MainButton(action: SubmitAction, label:  "Update").padding(.top,20)
                            }.frame(width: .infinity, height: .infinity).padding(10)
                            
                        }.background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                        )
                        Spacer()
                    }.padding(10)
                }
            }
            if isShowingLoader {
                Loader(isShowing: $isShowingLoader)
                    .edgesIgnoringSafeArea(.all)
            }
            
        }.ignoresSafeArea(.all) .navigationBarHidden(true).sheet(isPresented: $showImagePicker)
        {
            ImageUploader(selectedImage: $selectedImage, sourceTypeNo: sourceType)
        }
        .onChange(of: selectedImage) { newValue in
            print(newValue)
            
        }
        
    }
    
    func OpenImagePicker(){
        ActionSheet(title: Text("Select Image"), message: nil, buttons: [
            .default(Text("Photo Library")) {
                self.sourceType = 0
                self.showImagePicker = true
            },
            .default(Text("Camera"))
            {
                self.sourceType = 1
                self.showImagePicker = true
            },
            .cancel()
        ])
    }
    
    
    func SubmitAction(){
        
    }
    
    
    
    
}

struct EditProfileScreenView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileScreenView()
    }
}
