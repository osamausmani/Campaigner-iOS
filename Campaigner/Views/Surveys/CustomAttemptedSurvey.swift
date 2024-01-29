//
//  CustomAttemptedSurvey.swift
//  Campaigner
//
//  Created by Macbook  on 20/12/2023.
//

import SwiftUI

struct CustomAttemptedSurvey: View {
    var question: String?
    var answer: String?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Q:")
                        .font(.system(size: 12))
                        .bold()
                        .padding(.leading, 10)
                    Spacer()
                    Text(question ?? "")
                        .font(.system(size: 16))
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 5)
                
                HStack(alignment: .top) {
                    Text("A:")
                        .font(.system(size: 12))
                        .bold()
                    Text(answer ?? "")
                        .font(.system(size: 12))
                }
                .padding(.leading, 10)
                dividerline()
                    .padding(.top,20)
            }
            .background(.white)
          
            Spacer()
        }
    }
}

// Preview
struct CustomAttemptedSurvey_Previews: PreviewProvider {
    static var previews: some View {
        CustomAttemptedSurvey()
    }
}
