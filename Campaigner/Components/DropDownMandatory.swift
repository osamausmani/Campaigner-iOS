//
//  DropDownMandatory.swift
//  Campaigner
//
//  Created by Macbook  on 19/10/2023.
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
            VStack {
                HStack { // This HStack is for the label and the asterisk
                    Text(label)
                        .font(.system(size: 15))
                    if isMandatory {
                        Text("*")
                            .foregroundColor(.red)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
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
                        Text( selectedOption == "" ? placeholder : selectedOption )
                            .font(.system(size: 15))
                            .foregroundColor( selectedOption == "" ? .gray : .black)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "chevron.down").padding(.trailing,10)
                }
                .frame(height: 50)
                .padding(.leading,10)
                .border(Color.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
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
