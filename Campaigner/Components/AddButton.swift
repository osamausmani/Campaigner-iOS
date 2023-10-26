//
//  AddButton.swift
//  Campaigner
//
//  Created by Macbook  on 05/06/2023.
//

import SwiftUI

struct AddButton: View {
    var action: () -> Void
    var label: String
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(CColors.MainThemeColor)
        }
    }
}
