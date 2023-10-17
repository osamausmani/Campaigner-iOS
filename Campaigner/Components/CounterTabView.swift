//
//  CounterTabView.swift
//  Campaigner
//
//  Created by Macbook  on 04/06/2023.
//

import SwiftUI




struct CounterTabView: View {
    var heading : String!
    var body: some View {
        
        
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.white)
                .frame(height: 40)
                .background(Color.clear)
                
            
            
            
            Text(heading)
                .foregroundColor(Color.black)
                .font(.headline)
        }.edgesIgnoringSafeArea(.all)
        
        
    }
    
}

struct CounterTabView_Previews: PreviewProvider {
    static var previews: some View {
        CounterTabView()
    }
}
