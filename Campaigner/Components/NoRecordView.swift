//
//  NoRecordView.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/10/2023.
//

import SwiftUI

struct NoRecordView: View {
    @State var recordMsg:String
    var body: some View {
        VStack() {
            Image("no_record")
                .resizable()
                .frame(width: 150, height: 150) // Adjust the size as needed
                .aspectRatio(contentMode: .fit)
            
            Text(recordMsg)
                .font(.system(size: 16)).foregroundColor(.gray).frame(maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all) // Ignore safe area to fill the entire screen
                .multilineTextAlignment(.center) // Center-align
                .padding(20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Expand VStack to fill parent
        .edgesIgnoringSafeArea(.all) // Ignore safe area to fill the entire screen
    }
}

struct NoRecordViewView_Previews: PreviewProvider {
    static var previews: some View {
        NoRecordView(recordMsg:"If you are facing any issues in your area, we encourage you to file a complaint with the relevent authority.")
    }
}
