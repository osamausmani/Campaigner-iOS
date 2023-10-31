//
//  ComplaintCommentScreenView.swift
//  Campaigner
//
//  Created by Osama Usmani on 28/10/2023.
//

import Foundation
import SwiftUI

public struct ComplaintCommentScreenView: View {
    
    @State public var commentsArray = [ComplaintCommentDataum]()
    @State public var newComment: String = ""
    @State public var selectedItemID: String?
    @State private var keyboardHeight: CGFloat = 0
    
    public var body: some View {
        
        VStack(alignment: .leading){
            
                        VStack(alignment: .leading){
                            ForEach(0..<commentsArray.count, id: \.self) { index in
                                let comment = commentsArray[index]
            
                                VStack (alignment: .leading){
                                    HStack(alignment: .top, spacing: 5) { // Align content to the top and set spacing
                                        VStack(alignment: .leading, spacing: 5) { // Align content to the left and set spacing
                                            VStack{
                                                HStack{
                                                    HStack{
                                                        Image("default_large_image") // Replace "imageName" with the name of your image asset
                                                            .resizable()
                                                            .frame(width: 24, height: 24 )
                                                            .cornerRadius(12)
                                                            .padding(0)
                                                        Text(comment.user_full_name ?? "")
                                                            .font(.system(size: 16)).bold()
                                                           
                                                    }
                                                    Spacer()
                                                    Text(DateFormatterHelper().formatDateString(comment.sdt ?? "")!) 
                                                        .font(.system(size: 14))
                                                        
                                                }
                                                
                                               
            
                                                Text(comment.comment_text ?? "")
                                                    .font(.system(size: 14))
                                                    .frame(maxWidth: .infinity, alignment: .leading)
            
                                                
                                            }.padding(6)
            
                                        }.background(CColors.TextInputBgColor).cornerRadius(6)
                                    }
            
                                }.padding(6)
                            }.background(.white)
                                .onAppear{
//                                    print("comments", comments)
                                }
                        }.padding(20)
            
            
            Spacer()
            Divider() // Add a divider
            
            HStack{
                TextField("Type message here", text: $newComment)
                    .padding()
                    .cornerRadius(10)
                    .padding()
                
                
                Button(action: {
                    if newComment.count>3{
                        AddComment()
                    }
                }) {
                    Circle()
                        .fill(CColors.MainThemeColor)
                        .frame(width: 35, height: 35) // Adjust the size of the button
                        .overlay(
                            Image(systemName: "message")
                                .font(.system(size: 16)) // Adjust the font size
                                .foregroundColor(.white)
                                .font(.title)
                        )
                }
                
            }.frame(height: 40)
                .background(CColors.TextInputBgColor)
                .cornerRadius(10)
                .padding()
                .onAppear {
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                        if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                            keyboardHeight = keyboardSize.height - 50
                        }
                    }

                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                        keyboardHeight = 0
                    }
                }
                .padding(.bottom, keyboardHeight)
            
            
            
        }.onAppear{
            LoadComments()
        }
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    func formattedRelativeTime(_ date: Date) -> String {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.second, .minute, .hour, .day, .month, .year], from: date, to: now)
        
        if let year = components.year, year > 0 {
            return "\(year)y\(year > 1 ? "" : "") "
        } else if let month = components.month, month > 0 {
            return "\(month)m\(month > 1 ? "" : "") "
        } else if let day = components.day, day > 0 {
            return "\(day)d\(day > 1 ? "" : "") "
        } else if let hour = components.hour, hour > 0 {
            return "\(hour)h\(hour > 1 ? "" : "") "
        } else if let minute = components.minute, minute > 0 {
            return "\(minute)m\(minute > 1 ? "" : "") "
        } else if let second = components.second, second > 0 {
            return "\(second)s\(second > 1 ? "" : "") "
        } else {
            return "just now"
        }
    }
    
    func LoadComments()
    {
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "complaint_id": selectedItemID!
        ]
        let ViewModel = ComplaintsViewModel()
        ViewModel.ListComplaintComments(parameters: parameters ) { result in
            switch result {
            case .success(let response):
                if response.rescode == 1 {
                    commentsArray = response.data!
                }
            case .failure(_):
                print("fail")
            }
        }
    }
    
    func AddComment()
    {
        let parameters: [String:Any] = [
            "plattype": Constants.PLAT_TYPE,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "complaint_id": selectedItemID!,
            "comment_text": newComment
            
        ]
        let NewsViewModel = ComplaintsViewModel()
        NewsViewModel.AddComplaintComment(parameters: parameters ) { result in
            switch result {
            case .success(let response):
                if response.rescode == 1 {
                    newComment = ""
                    LoadComments()
                }
                
            case .failure(_):
                print("fail")
            }
        }
    }
}


