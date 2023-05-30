//
//  SideMenuView.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/05/2023.
//

import SwiftUI

struct SideMenuView: View {
    
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
                        presentSideMenu.toggle()
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
}

struct SideMenuView_Previews: PreviewProvider {
    @State static var selectedSideMenuTab = 10
    @State static var presentSideMenu = false
    
    static var previews: some View {
        SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)
    }
}
