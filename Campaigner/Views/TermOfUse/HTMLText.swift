////
////  HTMLText.swift
////  Campaigner
////
////  Created by Macbook  on 06/11/2023.
////
//
//import SwiftUI
//import UIKit
//
//struct HTMLTextView: UIViewRepresentable {
//    let htmlString:String
////    let htmlString = "<h1>Welcome to SwiftUI</h1><p>This is an example of <strong>HTML-formatted</strong> text in SwiftUI. This is an example of <strong>HTML-formatted</strong> text in SwiftUI.  This is an example of <strong>HTML-formatted</strong> text in SwiftUI. </p>"
//
//    func makeUIView(context: Context) -> UITextView {
//        let textView = UITextView()
//        textView.isEditable = false
//        return textView
//    }
//
//    func updateUIView(_ uiView: UITextView, context: Context) {
//        if let attributedString = try? NSAttributedString(data: Data(htmlString.utf8), options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
//            uiView.attributedText = attributedString
//        }
//    }
//}
//
////struct ContentViewT: View {
////    var body: some View {
////        HTMLTextView(htmlString: "abc")
////    }
////}
////
////struct ContentViewT_Previews: PreviewProvider {
////    static var previews: some View {
////        ContentViewT()
////    }
////}
