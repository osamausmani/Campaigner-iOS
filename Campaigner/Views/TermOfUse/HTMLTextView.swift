//
//  HTMLTextView.swift
//  Campaigner
//
//  Created by Macbook  on 06/11/2023.
//

import SwiftUI

struct HTMLTextView: UIViewRepresentable {
    @Binding var htmlString:String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if let attributedString = try? NSAttributedString(data: Data(htmlString.utf8), options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            uiView.attributedText = attributedString
        }
    }
}

struct ContentViewT: View {
    @State var tos = "tos data"
    var body: some View {
        HTMLTextView(htmlString: $tos)
    }
}

struct ContentViewT_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewT()
    }
}
