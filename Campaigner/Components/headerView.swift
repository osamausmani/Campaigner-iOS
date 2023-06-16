//
//  headerView.swift
//  Campaigner
//
//  Created by Macbook  on 14/06/2023.
//

import SwiftUI

struct headerView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var heading : String
    var action: () -> Void
    var body: some View {
        HStack {
            
            
            Text(heading)
                .font(.headline)
                .padding(.horizontal, 5)
                .padding(.vertical, 5)
            //
            
                .fontWeight(.bold)
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .leading)
            // Spacer().frame(height: 0)
            
            
            Button(action: {
                // Perform cancel action
                // self.presentationMode.wrappedValue.dismiss()
               action()
            }) {
                Image(systemName: "xmark")
                    .font(.title)
            }
        }
        .padding(.horizontal)
        .foregroundColor(.white)
        .background(CColors.MainThemeColor)
        //.cornerRadius(10)
        .frame(height: 40) // Increase the height to 200 points
    }
}

//struct headerView_Previews: PreviewProvider {
//    static var previews: some View {
//        headerView( heading: "Heading", action: <#() -> Void#>)
//    }
//}
