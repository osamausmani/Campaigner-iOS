//
//  HomeProButtons.swift
//  Campaigner
//
//  Created by Macbook  on 17/10/2023.
//
import SwiftUI

struct HomeProButtons: View {
    var onReportsTapped: () -> Void
    var onNotificationTapped: () -> Void
    var onTeamsTapped: () -> Void

    var symbols = [
        1: ["title": "Reports", "symbol": "reporting"],
        2: ["title": "Notification", "symbol": "notifications_mainpro"],
        3: ["title": "Teams", "symbol": "teams"]
    ]
    
    var layout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: layout, spacing: 20) {
            ForEach(symbols.keys.sorted(), id: \.self) { id in
                if let symbolData = symbols[id],
                   let title = symbolData["title"] as? String,
                   let symbolName = symbolData["symbol"] as? String {
                    
                    Button(action: {
                        switch title {
                        case "Reports": onReportsTapped()
                        case "Notification": onNotificationTapped()
                        case "Teams": onTeamsTapped()
                        default: break
                        }
                    }) {
                        VStack {
                            Image(symbolName)
                                .resizable()
                                .padding()
                                .frame(width: 90, height: 90)
                                .cornerRadius(15)
                            Text(title)
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .padding(-15)
                        }
                    }
                }
            }
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
