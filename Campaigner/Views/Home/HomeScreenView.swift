//
//  HomeScreenView.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/05/2023.
//


import SwiftUI

struct HomeScreenView: View {
    
    
    @State private var isShowingLoader = false
    @StateObject private var alertService = AlertService()

    @Binding var presentSideMenu: Bool

    var body: some View {
        NavigationView {
            
            VStack{
                GeometryReader { geometry in
                    
                    VStack(spacing: 0) {
                        
                        ImageSlider()

                            VStack{
                                Spacer()
                                HStack{
                                    HomeMenuButtons()
                                }
                                Spacer()

                                Text("Latest News").alignmentGuide(.leading) { _ in 0 }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.system(size: 20)).fontWeight(.bold).foregroundColor(CColors.MainThemeColor)
                                
                                
                                Spacer()
                                Spacer()
                                Spacer()

                                
                            }.background(Image("map_bg")
                                .resizable()).padding(20)
                            .foregroundColor(.black)

                            .frame(width: geometry.size.width, height: geometry.size.height * 0.6).background()
                        
                        
                    }
                    
                }
                .ignoresSafeArea(edges: .bottom)
                .navigationBarTitleDisplayMode(.inline)
            }
            .navigationBarItems(leading: Button(action: {
                print("im pressed")
                presentSideMenu.toggle()

            }) {
                Image(systemName: "line.3.horizontal").tint(CColors.MainThemeColor).font(.system(size: 24))
            }, trailing: Button(action: {
            }) {
                Image(systemName: "bell").tint(CColors.MainThemeColor).font(.system(size: 20))
            })
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("header_logo") // Add your image here
                        .resizable()
                        .frame(width: 120, height: 42)
                        .padding()
                }
            }
        }.navigationBarHidden(true)
        
    }
}

