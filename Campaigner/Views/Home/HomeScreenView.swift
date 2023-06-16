//
//  HomeScreenView.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/05/2023.
//


import SwiftUI

struct HomeScreenView: View {
    
    
    @State private var isShowingLoader = false
    @State private var contestingScreenView = false
    @State private var presentNotificationMenu = false
    @StateObject private var alertService = AlertService()

    @Binding var presentSideMenu: Bool
    let images = ["reporting", "complaints", "reporting","complaints"]
   
    var body: some View {
        NavigationView {
            
            VStack{
                //   GeometryReader { geometry in
                
                VStack {
                    ZStack
                    {
                        ImageSlider()
                        hoverButton(btnText: "Contestiong Election ? ", img: "mail", action: contestElection)
                    }
         
                    
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
                        
                        
                        // Image Selector with Labels and Horizontal Scroll Bar
                               ScrollView(.horizontal, showsIndicators: true) {
                                   HStack {
                                       ForEach(0..<images.count) { index in
                                           VStack {
                                               Button(action: {
                                                                      // Action when image is clicked
                                               }){
                                                   VStack{
                                                       Image(images[index])
                                                           .resizable()
                                                           .scaledToFit()
                                                       //  frame(width: 50, height: 50)
                                                       // .padding()
                                                       Text("Image \(index + 1)")
                                                           .font(.caption)
                                                           .foregroundColor(.gray)
                                                   }
                                               }
                                           }
                                       }.frame(width: 100, height: 100)
                                   }
                               }
                             //  .padding(.horizontal)
                           
                        
                        
                    }.background(Image("map_bg")
                        .resizable()).padding(20)
                        .foregroundColor(.black)
                    
                    //  .frame(width: geometry.size.width, height: geometry.size.height * 0.6).background()
                    
                    
                }
                
                // }
                .ignoresSafeArea(edges: .bottom)
                .navigationBarTitleDisplayMode(.inline)
            }
            .navigationBarItems(leading: Button(action: {
                print("im pressed")
               // presentSideMenu.toggle()
                presentSideMenu = true
                    
                
            }) {
                Image(systemName: "line.3.horizontal").tint(CColors.MainThemeColor).font(.system(size: 24))
            }, trailing: Button(action: {
                print("im pressed")
                notification()
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
        }.onDisappear{
            
            if(presentSideMenu == true)
            {
                
                  presentSideMenu = false
            }
        }
        //.navigationBarTitle("New Title", displayMode: .inline)
        .navigationBarHidden(true)
            .fullScreenCover(isPresented: $contestingScreenView) {
                ContestingElectionScreenView()
                
            }
            .fullScreenCover(isPresented: $presentNotificationMenu) {
                NotificationScreenView()
                
            }
        
        
        
    }
    
    func contestElection()
    {
        print("contextElectionprinted")
        contestingScreenView = true
    }
    
    func notification()
    {
        print("notificationbuttonpress")
        presentNotificationMenu = true
    }
    
    
}


struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(presentSideMenu: .constant(false))
            .tag(0)
    }
}
