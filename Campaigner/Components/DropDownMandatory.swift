//
//  DropDownMandatory.swift
//  Campaigner
//
//  Created by Macbook  on 27/11/2023.
//

import SwiftUI

struct DropDownMandatory: View {
    var label: String
    var placeholder: String
    var isMandatory: Bool = true
    
    @State private var isPickerVisible = false
    @State private var selectedOption = ""
    @Binding var selectedObj: DropDownModel
    let menuOptions: [DropDownModel]
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack { // This HStack is for the label and the asterisk
                Text(label)
                    .font(.system(size: 15))
                    .frame(alignment: .leading)
                if isMandatory {
                    Text("*")
                        .foregroundColor(.red)
                }
            }
            
            HStack {
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
                    Text(selectedOption == "" ? placeholder : selectedOption)
                        .font(.system(size: 15))
                        .foregroundColor(selectedOption == "" ? .gray : .black)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.trailing, 10)
                
                Image(systemName: "chevron.down")
                    .padding(.trailing,10)
            }
            .frame(height: 40)
                .padding(.leading, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8) // Creates a rounded rectangle with a corner radius of 8
                        .stroke(Color.black, lineWidth: 1) // Adds a border with black color and 1 point width
                )
                .alignmentGuide(.leading) { _ in 0 }
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.bottom, 6) // Adjust this value to control the space between the label and the dropdown
    }
}


struct DropDownMandatory_Previews: PreviewProvider {
    
    static let sampleDropDownModels = [
        DropDownModel(id: "1", value: "Option 1"),
        DropDownModel(id: "2", value: "Option 2"),
        DropDownModel(id: "3", value: "Option 3")
    ]
    @State static var selectedOption = sampleDropDownModels[0]
    
    static var previews: some View {
        DropDownMandatory(label: "Select Option", placeholder: "Choose...", isMandatory: true, selectedObj: $selectedOption, menuOptions: sampleDropDownModels)
    }
}
