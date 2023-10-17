//
//  ToggleButtonView.swift
//  Campaigner
//
//  Created by Macbook  on 13/06/2023.
//

import SwiftUI

struct ToggleButtonView: View {
    @Binding var isToggled: Bool
    var action: () -> Void
    
    
    var body: some View {
        VStack {
            Toggle(isOn: $isToggled) {
               // Text("Internal")
                if isToggled {
                    Text("External")
                        .font(.headline)
                } else {
                    Text("Internal")
                        .font(.headline)
                }
            }
            .padding()
            
        
        }
    }
}


