//
//  HomeMenuButtons.swift
//  Campaigner
//
//  Created by Osama Usmani on 07/05/2023.
//

import SwiftUI

struct HomeMenuButtons: View {
    var symbols = [
        1: ["title": "Complaints", "symbol": "complaints_main"],
        2: ["title": "Surveys", "symbol": "complaints_main"],
        3: ["title": "Election Results", "symbol": "complaints_main"]
    ]
    
    var layout = [
        GridItem(.flexible()),
        GridItem(.flexible()),

        GridItem(.flexible()),

    ]
    
    var body: some View {
                LazyVGrid(columns: layout, spacing: 20) {
                    ForEach(symbols.keys.sorted(), id: \.self) { id in
                        if let symbolData = symbols[id],
                           let title = symbolData["title"],
                           let symbolName = symbolData["symbol"] {
                            VStack {
                                Image(symbolName)
                                    .resizable()
                                    .padding()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(15)
                                Text(title).foregroundColor(.black).fontWeight(.bold)
                            }
                        }
                    }
                
            }
        }
}

struct HomeMenuButtons_Previews: PreviewProvider {
    static var previews: some View {
        HomeMenuButtons()
    }
}
