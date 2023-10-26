//
//  labelMandatory.swift
//  Campaigner
//
//  Created by Macbook  on 23/10/2023.
//

import SwiftUI

struct labelMandatory: View {
    var label: String
    var body: some View {
        HStack{
            Text(label)
                .font(.system(size: 15))
                
            Text("*").foregroundColor(Color.red)
        }.padding(.leading,20)
    }
}

struct labelMandatory_Previews: PreviewProvider {
    static var previews: some View {
        labelMandatory(label: "abc")
    }
}
