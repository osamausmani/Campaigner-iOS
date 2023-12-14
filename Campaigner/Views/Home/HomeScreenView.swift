import SwiftUI
import Alamofire

struct HomeScreenView: View {
    
    @State  var value = ""
    @State var pro_Type = -1
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
                    //                    hoverButton(btnText: "Contestiong Election ? ", img: "mail", action: contestElection).padding(30)
                }.frame(width: 400, height: 350)
                
                ScrollView{
                    VStack{
                        
                        HomeMenuButtons(electionID: value )
                            .padding(.bottom,5)
                        
                        ZStack {
                            RoundedRectangleLabelView(text: "halka Pro")
                            
                            HomeProButtons(
                                onReportsTapped: {
                                    
                                },
                                onNotificationTapped: {
                                    
                                },
                                onTeamsTapped: {
                                    
                                }
                            )
                            
                            
                        }
                            
                            Text("Latest News").alignmentGuide(.leading) { _ in 0 }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size:   20)).fontWeight(.bold).foregroundColor(CColors.MainThemeColor).padding(.top,10)
                                .padding(.leading,20)
                        
                            ImageSelectorView(imageUrls: images2, text: label2, action: { index in
                                
                                selectedNewsIndex = index
                                print("SelectedIndex ", selectedNewsIndex)
                                newsDetails()
                            } )
                            .padding(.leading,10)
                        }
                        .background(Image("map_bg")
                            .resizable()).padding(10)
                            .foregroundColor(.black)
                    }
                }.onAppear
                {
                    LoadDashBoard()
                    LoadUserData()
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
            .navigationBarBackButtonHidden(true)
            .onDisappear{
                
                if(presentSideMenu == true)
                {
                    
                    presentSideMenu = false
                }
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
        
        
        func LoadUserData(){
            let parameters: [String:Any] = [
                "plattype": Constants.PLAT_TYPE,
                "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!
            ]
            let ProfileViewModel = ProfileViewModel()
            
            ProfileViewModel.GetProfileBasicInfo(parameters: parameters ) { result in
                switch result {
                case .success(let response):
                    if response.rescode == 1 {
                        let imgURL = response.data![0].user_image ?? nil
                        if imgURL != nil{
                            downloadProfileImage(from: response.data![0].user_image!)
                        }
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        func downloadProfileImage(from urlString: String) {
            guard let url = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data, error == nil {
                    let base64String = data.base64EncodedString()
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(base64String, forKey: Constants.USER_IMAGE_DATA)
                    }
                }
            }.resume()
        }
        
        func decodeBase64ToImage(_ base64String: String) -> UIImage {
            if let data = Data(base64Encoded: base64String),
               let image = UIImage(data: data) {
                return image
            }
            return UIImage()
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
                        Global.electionID = value
                        
                        slider = dashboardDataResponse.data?[0].sliders ?? []
                        news = dashboardDataResponse.data?[0].news ?? []
                        
                        UserDefaults.standard.set(dashboardDataResponse.data?[0].election_id, forKey: Constants.USER_ELECTION_ID)
                        UserDefaults.standard.set(dashboardDataResponse.data?[0].pro_type, forKey: Constants.isProAccount)
                        pro_Type=dashboardDataResponse.data?[0].pro_type ?? 0
                        Global.isProAccount = pro_Type ?? 0
                        if let jsonData = try? JSONEncoder().encode(dashboardDataResponse.data?[0].elections),
                           let jsonString = String(data: jsonData, encoding: .utf8) {
                            UserDefaults.standard.set(jsonString, forKey: Constants.USER_ELECTIONS)
                        } else {
                            print("Error converting array to JSON string")
                        }
                        
                        
                        
                        
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
    
    
    
    
    //struct HomeScreenView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        HomeScreenView(presentSideMenu: .constant(false))
    //            .tag(0)
    //    }
    //}
    

