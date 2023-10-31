//
//  SearchableDropDown.swift
//  Campaigner
//
//  Created by Osama Usmani on 29/10/2023.
//

import Foundation
import SwiftUI

struct SearchBarForDropDown: View {
    @Binding var text: String
    @State private var isEditing = false
    @Binding var isPickerVisible: Bool

    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        if isEditing {
                            Button(action: {
                                text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    isEditing = true
                }
            if isEditing {
                Button(action: {
                    isEditing = false
                    text = ""
                    isPickerVisible = false

                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }.padding(.top,8)
            .onAppear{
                text = ""
            }

    }
}


public struct SearchableDropDown: View {
    var label: String
    var placeholder: String
    @Binding var selectedObj: DropDownModel
    let menuOptions: [DropDownModel]
    @State private var isPickerVisible = false
    @State private var selectedOption = ""
    @State private var searchText = ""
    
    public var body: some View {
        VStack {
            Text(label).alignmentGuide(.leading) { _ in 0 }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 15))
            HStack {
                Button(action: { isPickerVisible.toggle() }) {
                    HStack {
                        Text(selectedOption.isEmpty ? placeholder : selectedOption)
                            .foregroundColor(selectedOption.isEmpty ? .gray : .black)
                        Spacer()
                        Image(systemName: "chevron.down").padding(.trailing,10).foregroundColor(.black)
                    } .frame(height: 40)
                        .padding(.leading, 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8) // Creates a rounded rectangle with a corner radius of 8
                                .stroke(Color.black, lineWidth: 1) // Adds a border with black color and 1 point width
                        )
                        .alignmentGuide(.leading) { _ in 0 }
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
               
            }
            .sheet(isPresented: $isPickerVisible) {
                VStack {
                    SearchBarForDropDown(text: $searchText, isPickerVisible: $isPickerVisible)
                    List {
                        ForEach(menuOptions.filter { searchText.isEmpty ? true : $0.value.contains(searchText) }) { option in
                            Button(action: {
                                selectedOption = option.value
                                selectedObj = option
                                searchText = ""
                                isPickerVisible = false
                            }) {
                                Text(option.value).foregroundColor(.black)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            searchText = ""
            selectedOption = selectedObj.value
        }
    }
}
