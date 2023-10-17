import SwiftUI
import Alamofire

struct HomeScreenView: View {
    
    @State  var value = ""
    
    
    @State private var isLoading = false
    @State private var isShowingLoader = false
    @State private var contestingScreenView = false
    @State private var presentNotificationMenu = false
    
    @State private var newsDetailsScreenView = false
    @StateObject private var alertService = AlertService()
    
    @Binding var presentSideMenu: Bool
    @State  var selectedNews = [News]()
    
    // @State  var user = Data()
    @State var slider = [Slider]()
    @State var news = [News]()
    @State  var images = [String]()
    
    
    
    @State var images2 = [String]()
    @State var label2 = [String]()
    @State private var selectedNewsIndex: Int = 0

    var body: some View {
        NavigationView {
//            BaseView(alertService: alertService)
            VStack {
                ZStack
                {
                    ImageSlider(images: images)
                    hoverButton(btnText: "Contestiong Election ? ", img: "mail", action: contestElection).padding(30)
                }.frame(width: 400, height: 320)
                
                ScrollView{
                    VStack{
                        
                        HomeMenuButtons(electionID: value )
                        
                        Spacer()
                        
                        Text("Latest News").alignmentGuide(.leading) { _ in 0 }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 20)).fontWeight(.bold).foregroundColor(CColors.MainThemeColor).padding(.top,10)
                        
                        // Image Selector with Labels and Horizontal Scroll Bar
                        //                        ScrollView(.horizontal, showsIndicators: true) {
                        //                            HStack {
                        //                                ForEach(0..<images2.count) { index in
                        //                                    VStack {
                        //                                        Button(action: {
                        //                                            // Action when image is clicked
                        //                                        }){
                        //                                            VStack{
                        //                                                Image(images2[index] as! String)
                        //                                                    .resizable()
                        //                                                    .scaledToFit()
                        //                                                //  frame(width: 50, height: 50)
                        //                                                // .padding()
                        //                                                Text("Image \(index + 1)")
                        //                                                    .font(.caption)
                        //                                                    .foregroundColor(.gray)
                        //                                            }
                        //                                        }
                        //                                    }
                        //                                }.frame(width: 120, height: 100)
                        //                            }
                        //                        }
                        
                        ImageSelectorView(imageUrls: images2, text: label2, action: { index in
                            
                            selectedNewsIndex = index
                            print("SelectedIndex ", selectedNewsIndex)
                            newsDetails()
                        } )
                    }
                    .background(Image("map_bg")
                        .resizable()).padding(10)
                        .foregroundColor(.black)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            
            .navigationBarItems(leading: Button(action: {
                print("im pressed")
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
                    //   .padding()
                }
            }
            
        }
        .onDisappear{
            
            if(presentSideMenu == true)
            {
                
                presentSideMenu = false
            }
        }
        .onAppear
        {
            LoadDashBoard()
        }
        
        
        .fullScreenCover(isPresented: $contestingScreenView) {
            ContestingElectionScreenView()
            
        }
        .fullScreenCover(isPresented: $presentNotificationMenu) {
            NotificationScreenView()
            
        }
        
        .fullScreenCover(isPresented: $newsDetailsScreenView)
        {
            NewsDetailScreenView(news: selectedNews, selectedIndex: $selectedNewsIndex )
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
    
    
    func newsDetails()
    {
        print("pressed Details")
        newsDetailsScreenView = true
    }
    
    
    func LoadDashBoard()
    {
        
        isLoading = true
        let headers:HTTPHeaders = [
            "Content-Type":"application/x-www-form-urlencoded",
            "x-access-token": UserDefaults.standard.object(forKey: Constants.USER_SESSION_TOKEN) as! String
        ]
        let userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        let token = UserDefaults.standard.string(forKey: Constants.USER_SESSION_TOKEN)
        
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID ?? "",
            
        ]
        
        
        
        let homeViewModel = HomeViewModel()
        
        
        
        homeViewModel.DashboardData(parameters: parameters ,headers: headers ) { result in
            // isShowingLoader.toggle()
            isLoading = false
            print(result)
            switch result {
                
            case .success(let dashboardDataResponse):
                
                if dashboardDataResponse.rescode == 1 {
                    
                    
                    value = dashboardDataResponse.data?[0].election_id ?? "7"
                    slider = dashboardDataResponse.data?[0].sliders ?? []
                    news = dashboardDataResponse.data?[0].news ?? []
                    
                    
                    if (!slider.isEmpty){
                        images = []
                        
                    }
                    
                    if (!news.isEmpty)
                    {
                        images2 = []
                        label2 = []
                    }
                    
                    for i in slider{
                        images.append(i.image_path ?? "")
                    }
                    
                    for i in news{
                        print("newsX", i)
                        images2.append(i.nw_media!)
                        label2.append(i.nw_title ?? "")
                        
                        
                        selectedNews.append(i)
                        
                        // selectedNews[0].nw_media =
                    }
                    
                    //  self.presentationMode.wrappedValue.dismiss()
                    
                }else{
                    alertService.show(title: "Alert", message: dashboardDataResponse.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
        
        
    }
    
    
}




struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(presentSideMenu: .constant(false))
            .tag(0)
    }
}
