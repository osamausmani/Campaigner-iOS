//
//  ImageView.swift
//  Campaigner
//
//  Created by Macbook  on 19/06/2023.
//

import SwiftUI

struct ImageView: View {
    
    var title : String
    var image : String
    var profileName: String
    var profileImage : String
    var date : String
    var details: String
    
    
    var formattedDate: String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
           
           if let date = dateFormatter.date(from: date) {
               dateFormatter.dateFormat = "dd MMMM yyyy"
               return "On " + (dateFormatter.string(from: date))
           } else {
               return ""
           }
       }
   
    var body: some View {
        VStack(alignment: .leading) {
            if let url = URL(string: image) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(systemName: "1")
                    .resizable()
                    .scaledToFit()
            }
               
               Text(title)
                   .font(.title)
                   .padding(.leading)

            
            HStack(spacing: 10){
                Image(profileImage) // Replace "imageName" with the name of your image asset
                    .resizable()
                   // .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
               
                Text(profileName)
                    .font(.subheadline)
                
                Spacer(minLength: 5)
                
                Text(formattedDate)
                    .font(.subheadline)
                
                    
            }.padding(40)
            Text(details)
                .font(.subheadline)
                .padding()
            
           }
       }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(title: "Title", image: "1", profileName: "By name", profileImage: "", date: "date", details: "Details")
    }
}
