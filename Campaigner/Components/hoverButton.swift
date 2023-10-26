//
//  hoverButton.swift
//  Campaigner
//
//  Created by Macbook  on 05/06/2023.
//

import SwiftUI

struct hoverButton: View {
    var btnText : String
    var img : String
    var action: () -> Void
    var body: some View {
        GeometryReader{ p in
            ZStack(alignment: .top){
                Button(action: action) {
                    
                    Image(systemName: img).tint(CColors.MainThemeColor).font(.system(size: 18))
                    
                    Text(btnText)
                    
                    //.cornerRadius(10)
                }.foregroundColor(.white)
                    .font(.subheadline)
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(10)
                    .frame(height: 40)
                  //  .padding()
                    
                
            }.frame(width: p.size.width, height: p.size.height, alignment: .top)
            
        
              
        }
    }
    
  
}


struct hoverButton_Previews: PreviewProvider
{
    static var previews: some View
    {
        hoverButton(btnText: "Contesting Election ?", img: "mail", action: dummyAction)
    }
}

func dummyAction()
{
    print("Dummy")
}
