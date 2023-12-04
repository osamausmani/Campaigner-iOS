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
    var isMandatory = false
    @State private var isPickerVisible = false
    @State private var selectedOption = ""
    @Binding var selectedObj: DropDownModel
    let menuOptions: [DropDownModel]
    
    
    public var body: some View {
        VStack {
            HStack{
                Text(label).alignmentGuide(.leading) { _ in 0 }
                    .font(.system(size: 15)).padding(.trailing, -6)
                isMandatory ? Text("*").foregroundColor(.red) :nil
                Spacer()
            }
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
                    HStack{
                        Text(!selectedObj.value.isEmpty ? selectedObj.value : placeholder ).alignmentGuide(.leading) { _ in 0 }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 15)).foregroundColor( !selectedObj.value.isEmpty ? .black : .gray)
                        Image(systemName: "chevron.down").padding(.trailing,10)

                    }
                    }
            }.frame(height: 40)
                .padding(.leading, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8) // Creates a rounded rectangle with a corner radius of 8
                        .stroke(Color.black, lineWidth: 1) // Adds a border with black color and 1 point width
                )
                .alignmentGuide(.leading) { _ in 0 }
                .frame(maxWidth: .infinity, alignment: .leading)
        }.onAppear{

            selectedOption = selectedObj.value

        }

    }
}
