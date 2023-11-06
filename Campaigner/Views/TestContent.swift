
import SwiftUI

import SwiftUI

struct CardView2: View {
    var body: some View {
        HStack {
            // Data Column
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Name")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("Pakistan Tehreek-e-Insaf (PTI)")
                        .font(.body)
                }
                
                HStack {
                    Text("From")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("05 July 2023")
                        .font(.body)
                }
                
                HStack {
                    Text("To")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("05 November 2023")
                        .font(.body)
                }
            }
            .padding()
            
            Spacer()
            
            // Action Buttons Column
            VStack(spacing: 4) {
                
                Button(action: {
                }) {
                    HStack {
                        Image(systemName: "pencil")
                            .foregroundColor(.white)
                            .frame(width: 24, height: 24)
                        Spacer()
                        Text("Edit")
                            .foregroundColor(.white).padding(.trailing,8)
                    }
                }.frame(width: 90).background(Color.green)
                    .cornerRadius(8)
                
                Button(action: {
                    // Delete action
                }) {
                    HStack {
                        Image(systemName: "trash")
                            .foregroundColor(.white)
                            .frame(width: 24, height: 24)
                        Spacer()
                        Text("Delete")
                            .foregroundColor(.white).padding(.trailing,8)
                    }
                }.frame(width: 90).background(Color.red)
                    .cornerRadius(8)
            }
        }
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .shadow(radius: 1)
    }
}

struct CardView2_Previews: PreviewProvider {
    static var previews: some View {
        CardView2()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
