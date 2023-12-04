//
//  CheckboxFieldView.swift
//  Campaigner
//
//  Created by Macbook  on 12/06/2023.
//
import SwiftUI
//
//struct CheckboxFieldView: View {
//    @State private var isChecked = false
//
//    var label : String
//    var body: some View {
//        Button(action: {
//            isChecked.toggle()
//        }) {
//            HStack(spacing: 10) {
//                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 24, height: 24)
//                    .foregroundColor(isChecked ? .green : .primary)
//
//                Text(label)
//            }
//        }
//        .foregroundColor(.primary)
//       // .padding()
//
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckboxFieldView(label: "This is a testing")
//    }
//}


struct CheckboxFieldView: View {
    @Binding var isChecked: Bool
    var label: String
    
    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            HStack(spacing: 10) {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(isChecked ? .green : .primary)
                
                Text(label)
                .font(.system(size: 14))            }
        }
        .foregroundColor(.primary)
    }
}
