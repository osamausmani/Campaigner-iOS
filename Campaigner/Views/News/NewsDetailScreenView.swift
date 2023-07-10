//
//  NewsDetailScreenView.swift
//  Campaigner
//
//  Created by Macbook  on 19/06/2023.
//

import SwiftUI

struct NewsDetailScreenView: View {
    
    @StateObject private var alertService = AlertService()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    @State var news = [News]()
    
    var body: some View
    {
        NavigationView {
            
            VStack {
                
                ScrollView
                {
                    
                    
                    VStack
                    {
                        ImageView(title: news[0].nw_title ?? "", image: news[0].nw_media ?? "", profileName: news[0].nw_added_By?.user_name ?? "", profileImage: news[0].nw_added_By?.user_image ?? "", date: news[0].nw_sdt ?? "" , details: news[0].nw_desc ?? "")
                        
                    }
                    
                    
                }
              .navigationBarTitleDisplayMode(.inline)
                                
                                .navigationBarItems(leading: Button(action: {
                                    print("im pressed")
                                    //   presentSideMenu = true
                                    self.presentationMode.wrappedValue.dismiss()
                                    
                                }) {
                                    Image(systemName: "chevron.left").tint(CColors.MainThemeColor).font(.system(size: 18))
                                    Text("Back").tint(CColors.MainThemeColor).font(.system(size: 18))
                                }, trailing: Button(action: {
                                    print("im pressed")
                                    //  notification()
                                   
                                }) {
                                   // Image(systemName: "bell").tint(CColors.MainThemeColor).font(.system(size: 20))
                                })
                                .toolbar {
                                    ToolbarItem(placement: .principal) {
                                        //                        Image("header_logo") // Add your image here
                                        //                            .resizable()
                                        //                            .frame(width: 120, height: 42)
                                        
                                        Text("Details")
                                            .fontWeight(.semibold)
                                            .tint(CColors.MainThemeColor).font(.system(size: 20))
                                        
                                        
                                    }
                                }
                            }
        }
    }
}

struct NewsDetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetailScreenView(news: [])
    }
}
