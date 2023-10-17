//
//  AddNewComplaintView.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/10/2023.
//

import Foundation
import SwiftUI

struct AddNewComplaintView: View {
    @StateObject private var alertService = AlertService()
    
    @State private var category = DropDownModel()
    @State private var description = ""
    
    
    
    @State private var showActionSheet = false
    @State private var sourceType = 0
    @State private var showImagePicker = false
    @State var selectedImage: UIImage?
    
    
    
    private let networkOptions: [DropDownModel] = [
        DropDownModel(id: "1", value: "Ufone"),
        DropDownModel(id: "2", value: "Telenor"),
        DropDownModel(id: "3", value: "Jazz"),
        DropDownModel(id: "4", value: "Zong"),
        DropDownModel(id: "5", value: "Scom"),
    ]
    
    
    var body: some View {
        NavigationView {
            
            ZStack {
                
                BaseView(alertService: alertService)
                
                
                VStack{
                    HStack{
                        
                        VStack {
                            DropDown(label: "Category", placeholder: "Select Category", selectedObj:  $category, menuOptions: networkOptions )
                            
                            MultilineFormInput(label: "Description", placeholder: "Enter Description", text: $description)
                            
                            HStack(){
                                Spacer()
                                HStack{
                                    Text("File Upload: ")
                                    MainButton(action: {
                                        //
                                        showActionSheet = true
                                        // promptForImageSelection()
                                        
                                    },  label: "Attachment").frame(maxWidth: 180,maxHeight: 50,alignment: .topTrailing).actionSheet(isPresented: $showActionSheet) {
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
                                }
                            }
                            
                            
                            
                            DropDown(label: "District", placeholder: "Select District", selectedObj:  $category, menuOptions: networkOptions )
                            
                            
                            
                            MainButton(action: SubmitAction, label: "Submit").padding(.top,20)
                            
                            
                        }.frame(width: .infinity, height: .infinity).padding(10)
                        
                    }.background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    )
                Spacer()
                }
            }.padding(10)
                .sheet(isPresented: $showImagePicker)
            {
                ImageUploader(selectedImage: $selectedImage, sourceTypeNo: sourceType)
            }

        }.navigationBarHidden(false)
            .navigationTitle("Complaint")
    }
    
    
    func SubmitAction(){
        
    }
    
    
}

struct AddNewComplaintView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewComplaintView()
    }
}
