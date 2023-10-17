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
    
    @State private var showFullText = false
    let maxWords = 200 // Set your desired maximum length
    
    
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
            HStack{
                Spacer()
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
                Spacer()
                
            }
            Text(title).font(.system(size: 20)).padding(.leading)
            
            
            HStack(){
                HStack{
                    AsyncImage(url: URL(string: profileImage)) { image in
                        image
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                    } placeholder: {
                        Image("default_large_image") // Replace "imageName" with the name of your image asset
                            .resizable()
                            .frame(width: 20, height: 20).cornerRadius(10).padding(0)
                        
                    }
                    
                    Text("By " + profileName)
                        .font(.subheadline).padding(0)
                    
                    Spacer()
                }
                
                Spacer()
                
                Text(formattedDate)
                    .font(.subheadline)
                
                
            }.padding()
            
//            Text(details)
//                .font(.subheadline)
//                .padding()
            
            VStack {
                

                if showFullText {
                    Text(details)
                } else {
                    VStack{
                        Text(getTruncatedText())
                        Button(action: {
                            showFullText.toggle()
                        }) {
                            Text("See More")
                                .foregroundColor(CColors.MainThemeColor)
                                .font(.footnote)
                        }
                    }
                }
            }.padding().onAppear{
                if (details.count > maxWords){
                    showFullText = false
                }
                else{
                    showFullText = true
                }
            }
            
            
            
        }
    }
    
    private func getTruncatedText() -> String {
        let words = details.split(separator: " ")
        if words.count > maxWords {
            return words.prefix(maxWords).joined(separator: " ") + "..."
        } else {
            return details
        }
    }
    
    
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(title: "Title", image: "1", profileName: "By name", profileImage: "", date: "date", details: "Details")
    }
}
