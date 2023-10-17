//
//  DropDown.swift
//  Campaigner
//
//  Created by Osama Usmani on 23/05/2023.
//

import SwiftUI

public struct DropDown: View {
    
    var label: String
    var placeholder: String
    
    
    @State private var isPickerVisible = false
    @State private var selectedOption = ""
    
    @Binding var selectedObj: DropDownModel
    
    let menuOptions: [DropDownModel]
    
    
    public var body: some View {
        VStack {
            
            Text(label).alignmentGuide(.leading) { _ in 0 }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 15))
            
            HStack{
                Menu {
                    ForEach(menuOptions) { option in
                        Button(action: {
                            selectedOption = option.value
                            selectedObj = option
                            isPickerVisible = false
                        }, label: {
                            Text(option.value)
                        })
                    }
                } label: {
                    Text( selectedOption == "" ? placeholder : selectedOption ).alignmentGuide(.leading) { _ in 0 }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 15)).foregroundColor( selectedOption == "" ? .gray : .black)
                }
                
                
                Image(systemName: "chevron.down").padding(.trailing,10)
                  
                
            }.frame(height: 40)
                .padding(.leading,10)
            
                .border(Color.black).alignmentGuide(.leading) { _ in 0 }
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            
            
            
        }
        //        .padding(.horizontal, 16)
        //        .padding(.vertical, 12)
        //        .cornerRadius(8)
    }
}
