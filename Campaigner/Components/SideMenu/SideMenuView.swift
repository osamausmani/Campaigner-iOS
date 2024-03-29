//
//  SideMenuView.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/05/2023.
//

import SwiftUI
import Alamofire
import SwiftAlertView
import AlertToast

struct SideMenuView: View {
    
    //@State private var contestingScreenView = false
    @StateObject var alertService = AlertService()
    
    @State private var inviteMemebersScreenView = false
    
    @State private var paymentsScreenView = false
    
    @State private var termsOfUseScreenView = false
    @State private var isLoading = false
    @State private var contactUsScreenView = false
    @State private var profileMainScreenView = false
    @State private var manageConstituency = false
    @State private var ChangePasswordScreenView = false
    @State private var TermOfUseScreenView = false
    @State private var contactUsView = false
    @State private var isUpgradeView = false
    @State private var isDowngradeView = false
    @State private var showLogoutConfirmation = false
    @State private var alertOffset: CGFloat = UIScreen.main.bounds.height
    @State private var showToast = false
    @State var fin = [ContestingElection]()
    @State var alertMsg = "Alert"
    
    @State private var showSimpleAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let isProAccount = UserDefaults.standard.integer(forKey: Constants.isProAccount)

    @Binding var selectedSideMenuTab: Int
    @Binding var presentSideMenu: Bool
    @StateObject var userData: UserData = UserData()
    @State var constituencyOptions = [DropDownModel(id: "0", value: "Pro Account")]
    @State var selectedOption=DropDownModel()
    @State var selectedImage: UIImage?
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                ProfileImageView()
                    .padding(.bottom, 30).background(CColors.MainThemeColor)
                ForEach(SideMenuRowType.allCases, id: \.self){ row in
                    if Global.isProAccount == 1 && row.rawValue == 4 {
                        
                    }
                    else if Global.isProAccount == 0 && row.rawValue == 6 {
                        
                    }
                    else if Global.isProAccount == 0 && row.rawValue == 5{
                        
                    }
                    else {
                        RowView(isSelected: selectedSideMenuTab == row.rawValue, imageName: row.iconName, title: row.title) {
                            selectedSideMenuTab = row.rawValue
                            presentSideMenu = true
                            SideMenuBtnTapped(selectedSideMenuTab)
                        }
                    }
                  
                }
                Spacer()
                    .background(
                        Color.white
                    )
            }
            .frame(maxWidth: 270, maxHeight: .infinity, alignment: .leading)
            .onAppear(){
                listElection()
            }
            Spacer()
        }.toast(isPresenting: $showToast){
            AlertToast(displayMode: .banner(.slide), type: .regular, title: alertMsg)
        }
        .onAppear{
            print("Account Status = \(isProAccount)")
        }
        .alert(isPresented: $showSimpleAlert) {
            Alert(
                title: Text("Alert"),
                message: Text(alertMsg),
                dismissButton: .default(Text("Ok")) {
                    // Optional completion block
                    showToast.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            )
        }
        .background(.white).alignmentGuide(.leading) { _ in 0 }
        .frame(maxWidth: .infinity, alignment: .leading)
        
        
        
        NavigationLink(destination: AnyView(PaymentsScreenView()), isActive: $paymentsScreenView)
        {
        }
        
        NavigationLink(destination: InviteMemberScreenView(), isActive: $inviteMemebersScreenView) {
        }
        
        NavigationLink(destination: ProfileMainScreenView(), isActive: $profileMainScreenView) {
        }
        NavigationLink(destination: changePasswordView(), isActive: $ChangePasswordScreenView) {
        }
        NavigationLink(destination: TermOfUseView(), isActive: $TermOfUseScreenView) {
        }
        
        NavigationLink(destination: ContactUsView(), isActive: $contactUsView) {
        }
        NavigationLink(destination: ContestingElectionScreenView(), isActive: $manageConstituency) {
        }
        NavigationLink(destination: UpgradeAccountView(), isActive: $isUpgradeView) {
        }
        NavigationLink(destination: DowngradeAccountView(), isActive: $isDowngradeView) {
        }
        
    }
    
    
    func ProfileImageView() -> some View{
        VStack(alignment: .center){
            HStack{
                Spacer()
                if selectedImage == nil {
                    Image("default_large_image")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .cornerRadius(40)
                }
                else{
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .frame(width: 80, height: 80)
                        .cornerRadius(40)
                }
                Spacer()
                VStack{
                    Text(UserDefaults.standard.string(forKey: Constants.USER_NAME) ?? "UserName")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white).alignmentGuide(.leading) { _ in 0 }
                        .frame(maxWidth: .infinity, alignment: .leading).padding(.bottom,0.5)
                    
                    Text(UserDefaults.standard.string(forKey: Constants.USER_PHONE) ?? "Mobile Number" )
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white.opacity(1)).alignmentGuide(.leading) { _ in 0 }
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                
            }.padding(10).frame(height: 100).padding(.top,50)
            
            DropDown(label: "Select Constituency", placeholder: "Select Constituency", selectedObj: $selectedOption, menuOptions: constituencyOptions,isFromMenu:true)
                .padding([.leading,.trailing],10)
            
        }.background(CColors.MainThemeColor).onAppear{
            if let base64String = UserDefaults.standard.string(forKey: Constants.USER_IMAGE_DATA),
               let imageData = Data(base64Encoded: base64String),
               let image = UIImage(data: imageData) {
                // Use the 'image' as needed, for example, set it to a UIImageView
                selectedImage = image
            }
        }
    }
    
    func RowView(isSelected: Bool, imageName: String, title: String, hideDivider: Bool = false, action: @escaping (()->())) -> some View{
        Button{
            action()
            
        } label: {
            VStack(alignment: .leading){
                HStack(spacing: 20){
                    //                    Rectangle()
                    //                        .fill(isSelected ? .purple : .white)
                    //                        .frame(width: 5)
                    //
                    ZStack{
                        Image(imageName)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(CColors.MainThemeColor)
                            .frame(width: 26, height: 26)
                            .padding(.leading, 16) // Adjust the amount of padding as needed
                        
                    }
                    .frame(width: 30, height: 30)
                    Text(title)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(CColors.MainThemeColor)
                    
                    Spacer()
                }
                Divider()
                    .background(CColors.MainThemeColor) // Set the divider's color
                    .frame(height: 1)
            }
        }
        .frame(height: 50)
        .background(
            //            LinearGradient(colors: [isSelected ? .purple.opacity(0.5) : .white, .white], startPoint: .leading, endPoint: .trailing)
        )
        
    }
    
    func SideMenuBtnTapped(_ number: Int) {
        print("Button tapped: \(number)")
        // Perform any other actions you need here
        //    self.presentationMode.wrappedValue.dismiss()
        //  presentSideMenu = false
        
        if number == 0
        {
            profileMainScreenView = true
        } else if number == 1
        {
       //wallet
        }
        else if number == 2  {
            inviteMemebersScreenView = true
        }
        else if number == 3  {
            paymentsScreenView = true
            
        }
        else if number == 4
        {
            isUpgradeView = true
            
        }
        else if number == 5
        {
            manageConstituency = true
            
        }
        else if number == 6
        {
          isDowngradeView = true
            
        }
        else if number == 7
        {
            ChangePasswordScreenView = true
        }
        else if number == 8{
            TermOfUseScreenView = true
        }
        else if number == 9
        {
            contactUsView=true
            
        }
        
        else if number == 10
        {
            
            SwiftAlertView.show(title: "Logout Confirmation", message: "Are you sure you want to logout?", buttonTitles: ["Cancel", "Logout"])
                .onButtonClicked { _, buttonIndex in
                    if buttonIndex == 1 {
                        
                        LoginOutAction()
                    }
                    showLogoutConfirmation = false
                }
            
        }
        
        
    }
    
    
    func LoginOutAction() {
        
        var userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        
        let headers:HTTPHeaders = [
            "x-access-token": UserDefaults.standard.object(forKey: Constants.USER_SESSION_TOKEN) as! String
        ]
        
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id" : userID ?? ""
        ]
        
        let logOutViewModel = LogoutViewModel()
        
        logOutViewModel.loginoutRequest(parameters: parameters ,headers: headers ) { result in
            // isShowingLoader.toggle()
            
            switch result {
                
            case .success(let loginoutResponse):
                if loginoutResponse.rescode == 1 {


                    UserDefaults.standard.set(false, forKey: Constants.IS_USER_LOGIN)
                    UserDefaults.standard.removeObject(forKey:Constants.USER_ID )
                    userData.username = ""
                    userData.password = ""
                    
                    // Clear all data in UserDefaults
                    if let bundleIdentifier = Bundle.main.bundleIdentifier {
                        UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    
                    SwiftAlertView.show(title: "Alert", message: loginoutResponse.message!, buttonTitles: "OK")

                    
                }
                else if loginoutResponse.rescode == 2 {

                    UserDefaults.standard.set(false, forKey: Constants.IS_USER_LOGIN)
                    UserDefaults.standard.removeObject(forKey:Constants.USER_ID )
                    userData.username = ""
                    userData.password = ""
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    
                    SwiftAlertView.show(title: "Alert", message: loginoutResponse.message!, buttonTitles: "OK")
                    
                }
                else{
                    
                    
                    SwiftAlertView.show(title: "Alert", message: loginoutResponse.message!, buttonTitles: "OK")

                }
                
            case .failure(let error):
                alertMsg = error.localizedDescription
                
                showSimpleAlert = true
                
            }
            
        }
        
        
        
        
    }
    func listElection(){
        // isShowingLoader.toggle()
        isLoading = true
        
        let token = UserDefaults.standard.string(forKey: Constants.USER_SESSION_TOKEN)
        let headers:HTTPHeaders = [
            // "Content-Type":"application/x-www-form-urlencoded",
            "x-access-token": token!
        ]
        
        let userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
        
        
        
        print(token!)
        
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": userID!
            
        ]
        
        //let registerViewModel = RegisterViewModel()
        
        
        let contestentViewModel = ContestentViewModel()
        
        contestentViewModel.listElections(parameters: parameters,headers: headers ) { result in
            // isShowingLoader.toggle()
            isLoading = false
            print(result)
            switch result {
                
            case .success(let loginResponse):
                
                if loginResponse.rescode == 1 {
                    fin = loginResponse.data!
                    for i in fin {
                        
                        let dropDownModel = DropDownModel(id: i.constituency_id ?? "", value: i.constituency!)
                        constituencyOptions.append(dropDownModel)
                      
                    }
                 
                    
                    //  self.presentationMode.wrappedValue.dismiss()
                    
                    
                }else{
                    alertService.show(title: "Alert", message: loginResponse.message!)
                }
                
            case .failure(let error):
                alertService.show(title: "Alert", message: error.localizedDescription)
            }
        }
    }
    
    
}


//struct SideMenuView_Previews: PreviewProvider {
//    @State static var selectedSideMenuTab = 0
//    @State static var presentSideMenu = true
//
//    static var previews: some View {
//        SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu )
//    }
//}
