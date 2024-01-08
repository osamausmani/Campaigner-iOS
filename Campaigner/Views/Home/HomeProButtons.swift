//
//  HomeProButtons.swift
//  Campaigner
//
//  Created by Macbook  on 16/11/2023.
//

import SwiftUI
import SwiftAlertView


struct HomeProButtons: View {
    var onReportsTapped: () -> Void
    var onNotificationTapped: () -> Void
    var onTeamsTapped: () -> Void
    @State private var reportsScreenView = false
    @State private var promotionsScreenView = false
    @State private var teamsScreenView = false
    @State private var isUpgradeAppear = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var symbols = [
        1: ["title": "Reports", "symbol": "reporting"],
        2: ["title": "Promotions", "symbol": "promotion_main"],
        3: ["title": "Teams", "symbol": "teams"]
    ]
    
    var layout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: layout, spacing: 0) {
            ForEach(symbols.keys.sorted(), id: \.self) { id in
                if let symbolData = symbols[id],
                   let title = symbolData["title"],
                   let symbolName = symbolData["symbol"] {
                    VStack {
                        Image(symbolName)
                            .resizable()
                            .padding()
                            .frame(width: 90, height: 90)
                        
                        Text(title).foregroundColor(.black).fontWeight(.bold).padding(-15)
                        
                        Spacer()
                        
                    }.onTapGesture {
                        if Global.isProAccount == 0{
                            SwiftAlertView.show(title: "Alert",
                                                message: "Kindly Upgrade your halka account.",
                                                buttonTitles:  "CANCEL", "UPGRADE")
                            .onButtonClicked { _, buttonIndex in
                                if buttonIndex == 1
                                {
                                    isUpgradeAppear = true
                                }
                                else{
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                                
                            }
                            
                            
                        }
                        else{
                            buttonTapped(id)
                        }
                    }
                }
            }
            
            
            
            
        }
        NavigationLink(destination: ReportingScreenView(), isActive: $reportsScreenView) {}
        NavigationLink(destination: NotificationScreenView(), isActive: $promotionsScreenView) {}
        NavigationLink(destination: TeamsScreenView(), isActive: $teamsScreenView) {}
        NavigationLink(destination: UpgradeAccountView(), isActive: $isUpgradeAppear) {}
    }
    
    func buttonTapped(_ number: Int) {
        print("Button tapped: \(number)")
        // Perform any other actions you need here
        
        if number == 1
        {
            reportsScreenView = true
            
        }
        else if number == 2  {
            
            promotionsScreenView = true
            
        }
        else if number == 3  {
            
            teamsScreenView = true
        }
        
        
        
    }
}
struct HomeProButtons_Previews: PreviewProvider {
    static var previews: some View {
        HomeProButtons(onReportsTapped: {
            
        }, onNotificationTapped: {
            
        }, onTeamsTapped: {
            
        })
    }
}


struct RoundedRectangleLabelView: View {
    var text: String
    let height = UIScreen.main.bounds.height
    let width = UIScreen.main.bounds.width
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 1)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.clear))
                .frame(width:width*0.9,  height: height*0.14)
            
            
            
            Text(text)
                .foregroundColor(.black)
                .font(.title3)
                .bold()
                .padding(.horizontal, 10)
                .background(Color.white) // to cover the rectangle's border under the text
                .padding(.horizontal, 25) // to extend the background a bit more horizontally
                .offset(x: -2, y: -12) // shifting the label to inset into the rectangle
        }
        
        
    }
}
struct RoundedRectangleLabelView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectangleLabelView(text: "Halka Pro")
    }
}
