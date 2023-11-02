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
    @State var newsID = ""
    @Binding var selectedIndex:Int

    @State var likeCount = 0
    @State var commentsCount = 0
    @State var isLiked = 0
    @State public var commentsArray = [CommentsDatum]()
    @State private var isCommentSheetPresented = false
    
    
    
    var body: some View
    {
        NavigationView {
            
            VStack {
                
                ScrollView
                {
                    
                    
                    VStack
                    {
                        ImageView(title: news[selectedIndex].nw_title ?? "", image: news[selectedIndex].nw_media ?? "", profileName: news[selectedIndex].nw_added_by?.user_full_name ?? "", profileImage: news[selectedIndex].nw_added_by?.user_image ?? "", date: news[selectedIndex].nw_sdt ?? "" , details: news[selectedIndex].nw_desc ?? "")
                        
                    }
                    
                    VStack{
                        Divider()
                        HStack{
                            HStack{
                                Image("like_blue").frame(width: 20, height: 20).scaledToFit()
                                Text(String(likeCount ?? 0))
                            }
                            Spacer()
                            HStack{
                                Text(String(commentsCount ?? 0) + " Comments")
                            }.onTapGesture {
                                isCommentSheetPresented.toggle()
                            }
                        }
                        Divider()
                        
                        HStack{
                            
                            HStack{
                                Image((isLiked != 0) ? "liked_fliled_blue" : "like_grey" ).frame(width: 20, height: 20).scaledToFit()
                                Text("Like")
                            }.onTapGesture {
                                ToogleLike()
                            }
                            
                            Spacer()
                            
                            HStack{
                                Image("comment").frame(width: 20, height: 20).scaledToFit()
                                Text("Comment")
                            }.onTapGesture {
                                isCommentSheetPresented.toggle()
                            }
                            
                        }
                        
                        
                    }.padding()
                }
                .sheet(isPresented: $isCommentSheetPresented) {
                    
                    CommentView(isPresented: $isCommentSheetPresented, comments: $commentsArray, newsID: news[selectedIndex].news_id!, callback: LoadDetails)
                }
                .navigationBarTitleDisplayMode(.inline)
                
                .navigationBarItems(leading: Button(action: {
                    print("im pressed")
                    self.presentationMode.wrappedValue.dismiss()
                    
                }) {
                    Image(systemName: "chevron.left").tint(CColors.MainThemeColor).font(.system(size: 18))
                    Text("Back").tint(CColors.MainThemeColor).font(.system(size: 18))
                }, trailing: Button(action: {
                    print("im pressed")
                    
                }) {
                })
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Full article")
                            .fontWeight(.semibold)
                            .tint(CColors.MainThemeColor).font(.system(size: 20))
                        
                    }
                }
            }.onAppear
            {
                print("XXX", selectedIndex)
                LoadDetails()
            }
            
        }
        
        
        
        
    }
    
    func LoadDetails()
    {
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "news_id": news[selectedIndex].news_id!
            
        ]
        
        let NewsViewModel = NewsViewModel()
        NewsViewModel.GetNewsDetails(parameters: parameters ) { result in
            switch result {
            case .success(let response):
                
                if response.rescode == 1 {
                    likeCount = response.data[0].like_count!
                    commentsCount = response.data[0].nw_comments_count!
                    isLiked = response.data[0].is_liked!
                    commentsArray = response.data[0].nw_comments ?? []
                    
                }else{
                    alertService.show(title: "Alert", message: response.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    
    func ToogleLike()
    {
        
        let parameters: [String:Any] = [
            "plattype": Constants.PLAT_TYPE,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "news_id": news[selectedIndex].news_id!
        ]
        
        if isLiked == 0 {
            let NewsViewModel = NewsViewModel()
            NewsViewModel.NewsLike(parameters: parameters ) { result in
                switch result {
                case .success(let response):
                    if response.rescode == 1 {
                        LoadDetails()
                    }
                case .failure(let error):
                    alertService.show(title: "Alert", message: error.localizedDescription)
                }
            }
        }
        else{
            let NewsViewModel = NewsViewModel()
            NewsViewModel.NewsDislike(parameters: parameters ) { result in
                switch result {
                case .success(let response):
                    if response.rescode == 1 {
                        LoadDetails()
                    }
                case .failure(let error):
                    alertService.show(title: "Alert", message: error.localizedDescription)
                }
            }
        }
        
        
        
        
        
        
        
    }
    
    
}



public struct CommentView: View {
    @Binding var isPresented: Bool
    @Binding public var comments: [CommentsDatum]
    @State public var newComment: String = ""
    @State public var newsID: String = ""
    let callback: () -> Void
    
    @State private var keyboardHeight: CGFloat = 0
    
    //    // Change the access level to public
    //    public init(isPresented: Binding<Bool>, comments: Binding<[CommentsDatum]>, newsID: State<String>,) {
    //        self._isPresented = isPresented
    //        self._comments = comments
    //        self._newsID = newsID
    //
    //    }
    
    
    public var body: some View {
        
        VStack(alignment: .leading){
            
            VStack(alignment: .leading){
                ForEach(0..<comments.count, id: \.self) { index in
                    let comment = comments[index]
                    
                    VStack (alignment: .leading){
                        HStack(alignment: .top, spacing: 5) { // Align content to the top and set spacing
                            
                            Image("default_large_image") // Replace "imageName" with the name of your image asset
                                .resizable()
                                .frame(width: 30, height: 30 )
                                .cornerRadius(15)
                                .padding(0)
                            
                            
                            VStack(alignment: .leading, spacing: 5) { // Align content to the left and set spacing
                                VStack{
                                    Text(comment.user_full_name ?? "")
                                        .font(.system(size: 16)).bold()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text(comment.comment_text ?? "")
                                        .font(.system(size: 14))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    HStack{
                                        Text(formattedRelativeTime(dateFormatter.date(from: "2023-10-06 18:21:16")!))
                                            .font(.system(size: 14))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        //                                    Text(comment.user_full_name ?? "")
                                        //                                        .font(.system(size: 16)).bold()
                                        //                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        //                                    Text("Reply")
                                        //                                        .font(.system(size: 16)).bold()
                                        //                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }.padding(6)
                                
                            }.frame(maxWidth:.infinity).background(CColors.TextInputBgColor).cornerRadius(6)
                        }
                        
                    }.padding(6)
                    
                    
                }.background(.white)
                    .onAppear{
                        print("comments", comments)
                    }
            }.padding(20)
            
            
            Spacer()
            Divider() // Add a divider
            
            HStack{
                TextField("Add a comment...", text: $newComment)
                    .padding()
                    .cornerRadius(10)
                    .padding()
                
                
                Button(action: {
                    // Add your action here
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
    
    
    func AddComment()
    {
        
        let parameters: [String:Any] = [
            "plattype": Constants.PLAT_TYPE,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "news_id": newsID,
            "comment_text": newComment
            
        ]
        
        
        let NewsViewModel = NewsViewModel()
        NewsViewModel.NewsAddComment(parameters: parameters ) { result in
            switch result {
            case .success(let response):
                if response.rescode == 1 {
                    newComment = ""
                    
                    callback()
                }
                
            case .failure(_):
                print("fail")
            }
            
            
            
            
            
            
            
            
        }
        
        
    }
    
    
}
