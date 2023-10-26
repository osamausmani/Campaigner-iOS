//
//  CustomCell.swift
//  Campaigner
//
//  Created by Macbook  on 25/10/2023.
//

import SwiftUI

struct CustomCell: View {
    var Assembly: String
    var DistrictName: String
    var ConstituencyName: String
    var ReferralsCount: String
    var ProvinceName: String
    
    var delete: () -> Void
    var update: () -> Void
    var action: () -> Void
    
    
    
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(spacing: 5) {
                Text(Assembly)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .background(CColors.MainThemeColor)
                    .cornerRadius(5)
                // Referrals and its icon
                Spacer()
                HStack {
                    Text("Referrals:")
                        .font(.footnote)
                    VStack {
                        Text("\(ReferralsCount)")
                            .font(.footnote)
                        Rectangle()
                            .frame(width: 30, height: 1)
                            .foregroundColor(CColors.MainThemeColor)
                    }
                }
                Image("questionMark")
            }
            .imageScale(.medium)
            
            
            HStack {
                // District, Constituency, and Province
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text("District:")
                            .font(.footnote)
                            .fontWeight(.bold)
                        Text(DistrictName)
                            .font(.footnote)
                    }
                    
                    HStack {
                        Text("Constituency:")
                            .font(.footnote)
                            .fontWeight(.bold)
                        Text(ConstituencyName)
                            .font(.footnote)
                    }
                    
                    HStack {
                        Text("Province:")
                            .font(.footnote)
                            .fontWeight(.bold)
                        Text(ProvinceName)
                            .font(.footnote)
                    }
                }
                .foregroundColor(.black)
                .padding(.leading)
                
                Spacer()
                
                
                // Action and Delete icons
                HStack(spacing: 10) {
                    Image("members-green")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .imageScale(.medium)
                        .onTapGesture {
                            action()
                        }
                    
                    Image(systemName: "trash")
                        .imageScale(.medium)
                        .onTapGesture {
                            delete()
                        }
                }.padding(.top,30)
            }
        }
        .padding() // Add padding inside the cell
        .background(Color("BackgroundColorTheme"))
        .border(Color.black, width: 1) // Black border around cell
        .listRowInsets(EdgeInsets()) // Remove additional padding
    }
}

struct CustomCell_Previews: PreviewProvider {
    static var previews: some View {
        CustomCell(Assembly: "National Assembly", DistrictName: "Skardu", ConstituencyName: "GBA-10 Skardu-IV(GB)", ReferralsCount: "1673", ProvinceName: "Gilgit Baltistan", delete: {}, update: {}, action: {})
    }
}
