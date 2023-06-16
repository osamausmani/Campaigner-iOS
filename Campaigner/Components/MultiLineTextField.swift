//
//  MultiLineTextField.swift
//  Campaigner
//
//  Created by Macbook  on 12/06/2023.
//

import SwiftUI

public struct MultiLineTextField: View {
    
    @State  var text: String = ""
    var title : String
    
   
    

    
    
    public var body: some View {
        VStack {
            
            Text(title).alignmentGuide(.leading) { _ in 0 }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 15))
               // .foregroundColor(.gray)

            
            TextEditor(text: $text)
                           .frame(height: 150)
                           .padding(.leading, 10)
                           .border(Color.black)
                           .alignmentGuide(.leading) { _ in 0 }
                           .frame(maxWidth: .infinity, alignment: .leading)
            
            
        }
        .frame(maxWidth: .infinity,
                maxHeight: .infinity,
               alignment: .top)
        
    }
}

struct MultiLineTextField_Previews: PreviewProvider {
    static var previews: some View {
        MultiLineTextField( title: "Description")
    }
}
