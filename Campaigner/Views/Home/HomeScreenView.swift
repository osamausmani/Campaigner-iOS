import SwiftUI
import Alamofire

struct HomeScreenView: View {
    
    @State  var value = ""
    
    @State private var SurveyScreenView = false
    @State private var isLoading = false
    @State private var isShowingLoader = false
    @State private var contestingScreenView = false
    @State private var presentNotificationMenu = false
    @State private var showReportsView: Bool = false
    @State private var showTeamsView: Bool = false
    @State private var viewNotification: Bool = false
    @State private var newsDetailsScreenView = false
    @State private var showAlert = false
    @State private var showUpgradeAccount=false
    @StateObject private var alertService = AlertService()
    @State private var alertOffset: CGFloat = UIScreen.main.bounds.height

    @Binding var presentSideMenu: Bool
    @State  var selectedNews = [News]()
    
    // @State  var user = Data()
    @State var slider = [Slider]()
    @State var news = [News]()
    @State  var images = [String]()
    
    
    
    @State var images2 = [String]()
    @State var label2 = [String]()
    @State private var selectedNewsIndex: Int = 0
    @State private var isProAccount:Bool=false
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    headerView
                    mainScrollView
                }

                if showAlert {
                    Color.black.opacity(0.3) // optional dimmed background
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                alertOffset = UIScreen.main.bounds.height
                                showAlert = false
                            }
                        }

                    GeometryReader { geometry in
                        CustomAlertView(
                            message: "Kindly Upgrade your halka account",
                            buttonTitle: "UPGRADE",
                            CalcelbuttonAction: {
                                withAnimation {
                                    alertOffset = UIScreen.main.bounds.height
                                }
                                showAlert = false
                               
                            }, UpgradebuttonAction: {
                                showUpgradeAccount = true
                            }
                            
                        )
                        .padding(.bottom)
                        .background(
                            GeometryReader { alertGeometry in
                                Color.clear.onAppear {
                                    alertOffset = geometry.size.height - alertGeometry.size.height
                                }
                            }
                        )
                        .offset(y: alertOffset)
                        .animation(.spring(response: 0.6, dampingFraction: 0.8))
                    }
                }

                NavigationLink(
                    "",
                    destination: Campaigner.UpgradeAccountView().navigationBarHidden(true).onAppear {
                        showAlert = false
                    },
                    isActive: $showUpgradeAccount
                ).hidden()


            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: leadingNavBarItem, trailing: trailingNavBarItem)
            .toolbar { toolbarContent }
        }
        .navigationBarBackButtonHidden(true)
        .onDisappear { if presentSideMenu { presentSideMenu = false } }
        .onAppear { LoadDashBoard() }
    }


    
}

extension HomeScreenView {
    var headerView: some View {
        ZStack {
            Spacer()
            ImageSlider(images: images)
            hoverButton(btnText: "Upgrade to halka Pro ", img: "update_account_side", action: upgradeHalkaPro)
                .padding(30)
        }
        .frame(width: 400, height: 320)
    }

    var mainScrollView: some View {
        ScrollView {
            VStack {
                HomeMenuButtons(electionID: value )
            
                    .padding(2)
                
                proButtonsSection
                
                latestNews
                
                ImageSelectorView(imageUrls: images2, text: label2, action: newsDetailAction)
            }
            .background(Image("map_bg").resizable())
            .padding(10)
            .foregroundColor(.black)
//            .alertOverlay(showAlert: $showAlert, showUpgradeAccount: $showUpgradeAccount)
        }
    }

    var proButtonsSection: some View {
        ZStack {
            RoundedRectangleLabelView(text: "halka Pro")
            HomeProButtons(
                onReportsTapped: { showReportsView = true },
                onNotificationTapped: notificationTapped,
                onTeamsTapped: { showTeamsView = true }
            )
        }
        .padding()
    }
    
    var latestNews: some View {
        Text("Latest News")
            .alignmentGuide(.leading) { _ in 0 }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 20)).fontWeight(.bold)
            .foregroundColor(CColors.MainThemeColor)
            .padding(.top,10)
            .padding(.leading,10)
    }
    
    var leadingNavBarItem: some View {
        Button(action: sideMenuAction) {
            Image(systemName: "line.3.horizontal")
                .tint(CColors.MainThemeColor)
                .font(.system(size: 24))
        }
    }
    
    var trailingNavBarItem: some View {
        Button(action: notification) {
            Image(systemName: "bell")
                .tint(CColors.MainThemeColor)
                .font(.system(size: 20))
        }
    }

    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Image("header_logo")
                .resizable()
                .frame(width: 120, height: 42)
        }
    }

    
    func fullScreenCovers() -> some View {
        self
        .fullScreenCover(isPresented: $contestingScreenView) { ContestingElectionScreenView() }
        .fullScreenCover(isPresented: $presentNotificationMenu) { ShowNotificationView() }
        .fullScreenCover(isPresented: $newsDetailsScreenView) {
            NewsDetailScreenView(news: selectedNews, selectedIndex: $selectedNewsIndex )
        }
    }
    
    // MARK: - Actions

    func sideMenuAction() {
        presentSideMenu = true
    }
    
    func notificationTapped() {
        if isProAccount {
            viewNotification = true
        } else {
            showAlert.toggle()
        }
    }
    
    func newsDetailAction(index: Int) {
        selectedNewsIndex = index
        newsDetailsScreenView = true
    }

    func upgradeAction() {
        showAlert = false
        showUpgradeAccount = true
    }

    func upgradeHalkaPro()
    {
       
        showUpgradeAccount=true
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
    @State static var presentSideMenu: Bool = false

    static var previews: some View {
        HomeScreenView(presentSideMenu: $presentSideMenu)
    }
}

