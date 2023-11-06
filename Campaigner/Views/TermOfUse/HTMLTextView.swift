//
//  HTMLTextView.swift
//  Campaigner
//
//  Created by Macbook  on 06/11/2023.
//

import SwiftUI

struct HTMLTextView: UIViewRepresentable {
    @Binding var htmlString: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if let data = htmlString.data(using: .utf8) {
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html
            ]

            if let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
                let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)

                // Set default font for unstyled text
                let systemFont = UIFont.systemFont(ofSize: 17)
                mutableAttributedString.addAttribute(.font, value: systemFont, range: NSRange(location: 0, length: mutableAttributedString.length))

//                // Find and apply bold font for all occurrences of <b> tag
//                let pattern = "<strong>"
//                var searchRange = NSRange(location: 0, length: mutableAttributedString.length)
//
//                while searchRange.location != NSNotFound {
//                    searchRange = (htmlString as NSString).range(of: pattern, options: [], range: searchRange)
//                    if searchRange.location != NSNotFound {
//                        mutableAttributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: searchRange)
//                        searchRange = NSRange(location: searchRange.location + searchRange.length, length: mutableAttributedString.length - (searchRange.location + searchRange.length))
//                    }
//                }

                uiView.attributedText = mutableAttributedString
            }
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
