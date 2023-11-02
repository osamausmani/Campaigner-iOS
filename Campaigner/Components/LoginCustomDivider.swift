//
//  LoginCustomDivider.swift
//  Campaigner
//
//  Created by Macbook  on 31/10/2023.
//

import SwiftUI

struct LoginCustomDivider: View {
    var labelText: String

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 10) {
                self.line(width: (geometry.size.width - self.textWidth(for: labelText, using: geometry)) / 2)
                Text(labelText)
        
                self.line(width: (geometry.size.width - self.textWidth(for: labelText, using: geometry)) / 2)
            }
        }
        .frame(height: 20)
    }
    
    func textWidth(for text: String, using geometry: GeometryProxy) -> CGFloat {
        let uiFont = UIFont.systemFont(ofSize: 17)  // This should match your Text font size
        let string = NSString(string: text)
        return string.size(withAttributes: [.font: uiFont]).width + 20  // 20 accounts for the padding you added
    }
    
    func line(width: CGFloat) -> some View {
        Color.black
            .frame(width: width, height: 1)
    }
}

struct LoginCustomDivider_Previews: PreviewProvider {
    static var previews: some View {
        LoginCustomDivider(labelText:"or connect using")
            .padding()
    }
}
