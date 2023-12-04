//
//  CriteriaTableView.swift
//  Campaigner
//
//  Created by Macbook  on 28/11/2023.
//

import SwiftUI


struct CriteriaTableView: View {
let heading: String
let data: [[String]]
let cancelAction: () -> Void

init(heading: String, data: [[String]], cancelAction: @escaping () -> Void) {
self.heading = heading
self.data = data
self.cancelAction = cancelAction
}

var body: some View {
VStack(spacing: 0) {
HStack {
Spacer()
Text(heading)
.fontWeight(.bold)
.padding()
.frame(maxWidth: .infinity, alignment: .leading)

Button(action: {
// Close button action
cancelAction()
}) {
Image(systemName: "xmark.circle.fill")
.font(.title)
.padding()
}
.foregroundColor(.green)
}
dividerline()

HStack {
Text("Title")
.bold()
.padding()
.frame(maxWidth: .infinity, alignment: .leading)

Text("Detail")
.bold()
.padding()
.frame(maxWidth: .infinity, alignment: .leading)
}
.border(Color.gray.opacity(0.2), width: 1)

ForEach(0..<data.count, id: \.self) { rowIndex in
HStack {
Text(data[rowIndex][0])
.bold()
.padding()
.frame(maxWidth: .infinity, alignment: .leading)

Text(data[rowIndex][1])
.padding()
.frame(maxWidth: .infinity, alignment: .leading)
}
.border(Color.gray.opacity(0.2), width: 1)
}
}
.background(Color.white)
.cornerRadius(15)
.padding(.horizontal)
.frame(width: .infinity, height: .infinity, alignment: .top)
.shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
}
}

#Preview {
CriteriaTableView(heading: "Dynamic Heading", data: [["Row 1, Col 1", "Row 1, Col 2"], ["Row 2, Col 1", "Row 2, Col 2"]]) {
// Handle cancel action
print("Cancel button tapped")
}
}
