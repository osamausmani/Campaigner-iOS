//
//  Demo.swift
//  Campaigner
//
//  Created by Macbook  on 15/06/2023.
//



import SwiftUI

struct SubscribeScreenView: View {
    var body: some View {
        VStack(spacing: -20){
            HStack(spacing: -15) {
                
                // Box view with rounded corners
                Rectangle()
                    .frame(width: 210, height: 200)
                    .foregroundColor(.clear)
                    .cornerRadius(15)
                    .overlay(
                        Image("box_1")
                            .resizable()
                    )
//                    .overlay(
//                            RoundedRectangle(cornerRadius: 15)
//                                .stroke(Color.gray, lineWidth: 1)
//                        )
                    .overlay(
                        VStack{
                            Text("Basic").fontWeight(.bold)
                            Divider()
                            Text("Member Limit: 20").fontWeight(.light)
                            Spacer()
                            Text("Rs 1,000.00").fontWeight(.bold)
                            Spacer()
                            Button("Subscribe") {
                                
                            }
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 7)
                                            
                            .background(CColors.MainThemeColor)
                                .foregroundColor(.white)
                               
                                
                            Spacer()
                        }
                            .foregroundColor(CColors.MainThemeColor)
                               // .font(.headline)
                                .padding(10)
                        )

                      .cornerRadius(15)
                      .padding(8)
                
                
                Rectangle()
                    .frame(width: 210, height: 200)
                    .foregroundColor(.clear)
                    .cornerRadius(15)
                    .overlay(
                        Image("box_2")
                            .resizable()
                          //  .scaleEffect(x: -1, y: 1)
                           
                    )
//                    .overlay(
//                            RoundedRectangle(cornerRadius: 15)
//                                .stroke(Color.gray, lineWidth: 1)
//                        )
                    .overlay(
                        VStack{
                            Text("Silver").fontWeight(.bold)
                            Divider()
                            Text("Member Limit: 50").fontWeight(.light)
                            Spacer()
                            Text("Rs 5,000.00").fontWeight(.bold)
                            Spacer()
                            Button("Subscribe") {
                                
                            }
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 7)
                                            
                            .background(CColors.MainThemeColor)
                                .foregroundColor(.white)
                               
                                
                            Spacer()
                        }
                            .foregroundColor(CColors.MainThemeColor)
                               // .font(.headline)
                                .padding(10)
                        )
                    
                    .cornerRadius(15)
                    .padding(8)
                
                
            }
            .padding()
            
            HStack(spacing:  -15) {
                // Box view with rounded corners
                Rectangle()
                    .frame(width: 210, height: 200)
                    .foregroundColor(.clear)
                    .cornerRadius(15)
                    .overlay(
                        Image("box_3")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
        
                    )
//                    .overlay(
//                            RoundedRectangle(cornerRadius: 15)
//                                .stroke(Color.gray, lineWidth: 1)
//                        )
                    .overlay(
                        VStack{
                            Text("Gold").fontWeight(.bold)
                            Divider()
                            Text("Member Limit: 100").fontWeight(.light)
                            Spacer()
                            Text("Rs 10,000.00").fontWeight(.bold)
                            Spacer()
                            Button("Subscribe") {
                                
                            }
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 7)
                                            
                            .background(CColors.MainThemeColor)
                                .foregroundColor(.white)
                               
                                
                            Spacer()
                        }
                            .foregroundColor(CColors.MainThemeColor)
                               // .font(.headline)
                                .padding(10)
                        )
                    .cornerRadius(15)
                    .padding(8)
                
                Rectangle()
                    .frame(width: 210, height: 200)
                    .foregroundColor(.clear)
                    .cornerRadius(15)
                    .overlay(
                        Image("box_4")
                            .resizable()
                           // .scaleEffect(x: -1, y: 1)
                           
                    )
//                    .overlay(
//                            RoundedRectangle(cornerRadius: 15)
//                                .stroke(Color.gray, lineWidth: 1)
//                        )
                    .overlay(
                        VStack{
                            Text("Platinum").fontWeight(.bold)
                            Divider()
                            Text("Member Limit: 200").fontWeight(.light)
                            Spacer()
                            Text("Rs 15,000.00").fontWeight(.bold)
                            Spacer()
                            Button("Subscribe") {
                                
                            }
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 7)
                                            
                            .background(CColors.MainThemeColor)
                                .foregroundColor(.white)
                               
                                
                            Spacer()
                        }
                            .foregroundColor(CColors.MainThemeColor)
                               // .font(.headline)
                                .padding(10)
                        )
                
                    .cornerRadius(15)
                    .padding(8)
            }
            .padding()
            
            
            HStack(spacing:  -15) {
                // Box view with rounded corners
                Rectangle()
                    .frame(width: 210, height: 200)
                    .foregroundColor(.clear)
                    .cornerRadius(15)
                    .overlay(
                        Image("box_5")
                            .resizable()
                           // .scaleEffect(x: -1, y: 1)
                            
                    )
//                    .overlay(
//                            RoundedRectangle(cornerRadius: 15)
//                                .stroke(Color.gray, lineWidth: 1)
//                        )
                    .overlay(
                        VStack{
                            Text("Diamond").fontWeight(.bold)
                            Divider()
                            Text("Member Limit: 1000").fontWeight(.light)
                            Spacer()
                            Text("Rs 25,000.00").fontWeight(.bold)
                            Spacer()
                            Button("Subscribe") {
                                
                            }
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 7)
                                            
                            .background(CColors.MainThemeColor)
                                .foregroundColor(.white)
                               
                                
                            Spacer()
                        }
                            .foregroundColor(CColors.MainThemeColor)
                               // .font(.headline)
                                .padding(10)
                        )
                    .cornerRadius(15)
                    .padding(8)
                
                Rectangle()
                    .frame(width: 210, height: 200)
                    .foregroundColor(.clear)
                    .cornerRadius(15)
                    .overlay(
                        Image("box_6")
                            .resizable()
                            
                    )
//                    .overlay(
//                            RoundedRectangle(cornerRadius: 15)
//                                .stroke(Color.gray, lineWidth: 1)
//                        )
                    .overlay(
                        VStack{
                            Text("Elite").fontWeight(.bold)
                            Divider()
                            Text("Member Limit: 5000").fontWeight(.light)
                            Spacer()
                            Text("Rs 100,000.00").fontWeight(.bold)
                            Spacer()
                            Button("Subscribe") {
                                
                            }
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 7)
                                            
                            .background(CColors.MainThemeColor)
                                .foregroundColor(.white)
                               
                                
                            Spacer()
                        }
                            .foregroundColor(CColors.MainThemeColor)
                               // .font(.headline)
                                .padding(10)
                        )
                    .cornerRadius(15)
                    .padding(8)
                    
            }
            .padding()
        }
    }
}

struct SubscribeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SubscribeScreenView()
    }
}
