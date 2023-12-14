//
//  CustomDropDown.swift
//  Campaigner
//
//  Created by Macbook  on 07/06/2023.
//

import SwiftUI

public struct CustomDropDown: View {
    
    var label: String
    var placeholder: String
    
    @State private var isPickerVisible = false
    @State private var selectedOption = ""
    
    @Binding var selectedObj: DropDownModel
    
    let menuOptions: [DropDownModel]
    let onChange: (DropDownModel) -> Void // Add the onChange closure
    
    public var body: some View {
        VStack {
            Text(label)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 15))
            
            HStack {
                Menu {
                    ForEach(menuOptions) { option in
                        Button(action: {
                            selectedOption = option.value
                            selectedObj = option
                            onChange(option) // Call the onChange closure with the selected option
                            isPickerVisible = false
                        }) {
                            Text(option.value)
                        }
                    }
                } label: {
                    Text(selectedOption == "" ? placeholder : selectedOption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 15))
                        .foregroundColor(selectedOption == "" ? .gray : .black)
                }
                
                Image(systemName: "chevron.down")
                    .padding(.trailing, 10)
                
            }
            .frame(height: 40)
            .padding(.leading, 10)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke( Color.black , lineWidth: 1)
//

            )
            .alignmentGuide(.leading) { _ in 0 }
            .frame(maxWidth: .infinity, alignment: .leading)
    
        }
    }
}
