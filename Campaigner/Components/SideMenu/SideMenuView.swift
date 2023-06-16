//
//  SideMenuView.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/05/2023.
//

import SwiftUI

struct SideMenuView: View {
    
  //  @State private var contestingScreenView = false
    
    @State private var inviteMemebersScreenView = false
    
    @State private var paymentsScreenView = false
    
    @State private var chnagePasswordScreenView = false
    
    @State private var termsOfUseScreenView = false
    
    @State private var contactUsScreenView = false
    
    //@State private var presentSideMenu = false
    
    @StateObject var alertService = AlertService()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var selectedSideMenuTab: Int
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                ProfileImageView()
                    .padding(.bottom, 30).background(CColors.MainThemeColor)
                
                ForEach(SideMenuRowType.allCases, id: \.self){ row in
                    RowView(isSelected: selectedSideMenuTab == row.rawValue, imageName: row.iconName, title: row.title) {
                        selectedSideMenuTab = row.rawValue
                        print(selectedSideMenuTab)
                        presentSideMenu = true
                        SideMenuBtnTapped(selectedSideMenuTab)
                    }
                }
                Spacer()
                
                    .background(
                        Color.white
                    )
            }
            .frame(maxWidth: 270, maxHeight: .infinity, alignment: .leading)
            
            
            
            Spacer()
        }
        .background(.white).alignmentGuide(.leading) { _ in 0 }
        .frame(maxWidth: .infinity, alignment: .leading)
        
       

//        NavigationLink(destination: AnyView(InviteMemberScreenView()), isActive: $inviteMemebersScreenView) {
//
//        }
        
        
        NavigationLink(destination: AnyView(PaymentsScreenView()), isActive: $paymentsScreenView) {
          
        }
        
        NavigationLink(destination: InviteMemberScreenView(), isActive: $inviteMemebersScreenView) {
           // InviteMemberScreenView()
        }
        
    }
    
    func ProfileImageView() -> some View{
        VStack(alignment: .center){
            HStack{
                Spacer()
                
                Image("default_large_image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                //                    .overlay(
                //                        RoundedRectangle(cornerRadius: 50)
                //                            .stroke(.purple.opacity(0.5), lineWidth: 10)
                //                    )
                    .cornerRadius(40)
                Spacer()
                VStack{
                    Text(UserDefaults.standard.string(forKey: Constants.USER_NAME) ?? "UserName")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white).alignmentGuide(.leading) { _ in 0 }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(UserDefaults.standard.string(forKey: Constants.USER_PHONE) ?? "Mobile Number" )
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white.opacity(1)).alignmentGuide(.leading) { _ in 0 }
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
            }.padding(10).frame(height: 150).padding(.top,50)
            
            
        }.background(CColors.MainThemeColor)
    }
    
    func RowView(isSelected: Bool, imageName: String, title: String, hideDivider: Bool = false, action: @escaping (()->())) -> some View{
        Button{
            action()
         
        } label: {
            VStack(alignment: .leading){
                HStack(spacing: 20){
                    Rectangle()
                        .fill(isSelected ? .purple : .white)
                        .frame(width: 5)
                    
                    ZStack{
                        Image(imageName)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(isSelected ? .black : .gray)
                            .frame(width: 26, height: 26)
                    }
                    .frame(width: 30, height: 30)
                    Text(title)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(isSelected ? .black : .gray)
                    Spacer()
                }
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
           
            print("Button tapped:0")
           // contestingScreenView = true
        } else if number == 1
        {
            
                inviteMemebersScreenView = true
            
           // teamsScreenView = true
            
            print("Button tapped:1")
        }
        else if number == 2  {
        
            
            print("Button tapped:2")
            paymentsScreenView = true
            
           
        }
        else if number == 3  {
            
           // teamsScreenView = true
            print("Button tapped:3")
           
        }
        else if number == 4
        {
            print("Button tapped:4")
        }
        else if number == 5
        {
            print("Button tapped:5")
        }
        else if number == 6
        {
            print("Button tapped:6")
            LoginOutAction()
        }
   
        
     }
    
    func LoginOutAction() {
        
        var userID = UserDefaults.standard.string(forKey: Constants.USER_ID)

        print(userID!)
            
            let parameters: [String:Any] = [
                "plattype": Global.PlatType,
                "user_id" : userID!
            ]
            
            let logOutViewModel = LogoutViewModel()
            
        logOutViewModel.loginoutRequest(parameters: parameters ) { result in
               // isShowingLoader.toggle()
                
                switch result {
                    
                case .success(let loginoutResponse):
                    
                    if loginoutResponse.rescode == 2 {
                       // showToast.toggle()
                        
                     

                       
                        UserDefaults.standard.set(false, forKey: Constants.IS_USER_LOGIN)
                        UserDefaults.standard.removeObject(forKey:Constants.USER_ID )
                        self.presentationMode.wrappedValue.dismiss()
                        
                        
                        
                        
                        
                    }else{
                        alertService.show(title: "Alert", message: loginoutResponse.message!)
                    }
                    
                case .failure(let error):
                    alertService.show(title: "Alert", message: error.localizedDescription)
                }
            
        }
        
        
        
        
    }

}

struct SideMenuView_Previews: PreviewProvider {
    @State static var selectedSideMenuTab = 0
    @State static var presentSideMenu = true
    
    static var previews: some View {
        SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu )
    }
}
