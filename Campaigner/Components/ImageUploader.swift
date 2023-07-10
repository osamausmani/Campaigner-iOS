//
//  ImageUploader.swift
//  Campaigner
//
//  Created by Macbook  on 22/06/2023.
//

import SwiftUI

struct ImageUploader: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    @State  var sourceTypeNo: Int?
    
    @Environment(\.presentationMode) var presentationMode

   // var sourceType: UIImagePickerController.SourceType = .photoLibrary
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        if(sourceTypeNo == 0)
        {
            imagePicker.sourceType = .photoLibrary
        }else
        {
            imagePicker.sourceType = .camera
        }
                
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImageUploader

        init(_ parent: ImageUploader) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}



    
    
    
  

