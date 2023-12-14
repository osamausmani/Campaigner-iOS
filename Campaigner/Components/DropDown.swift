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
    var isFromMenu : Bool?
    
    
    public var body: some View {
        VStack {
            HStack{
                Text(label).alignmentGuide(.leading) { _ in 0 }
                    .font(.system(size: 15)).padding(.trailing, -6)
                    .foregroundColor(isFromMenu == true ? .white : .black)
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
                            .foregroundColor(.black)

                    }
                    }
            }.frame(height: 40)
                .padding(.leading, 10)
                .background(isFromMenu == true ? Color.white : nil)
                .cornerRadius(isFromMenu == true ? 8 : 0)

        

                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isFromMenu == true ? Color.white : .black, lineWidth: 1)

                )
//
                .alignmentGuide(.leading) { _ in 0 }
                .frame(maxWidth: .infinity, alignment: .leading)
        }.onAppear{

            selectedOption = selectedObj.value

        }

    }
}
