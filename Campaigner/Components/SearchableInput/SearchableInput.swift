import SwiftUI

struct SearchableInput: View {
    @Binding var isPresented: Bool
    let dataArray: [String]
    var label: String
    var onItemSelected: ((String) -> Void)?

    @State private var searchText = ""
    @State private var selectedItem: String? // Use an optional to keep track of the selected item

    var body: some View {
        VStack {
            Text(label)
                .font(.headline)
                .padding(.top)

            TextField("Search", text: $searchText)
                .padding(.horizontal).padding(10).background(Color.gray.opacity(0.2)).cornerRadius(10) // Set the background color here

            List(dataArray.filter {
                searchText.isEmpty ? true : $0.localizedCaseInsensitiveContains(searchText)
            }, id: \.self) { item in
                Button(action: {
                    selectedItem = item
                    onItemSelected?(item)

                    isPresented = false
                }) {
                    Text(item)
                }
                .foregroundColor(selectedItem == item ? .blue : .black) // Highlight the selected item
            }
            

            Button("Close") {
                isPresented = false // Close the sheet when an item is selected
            }
            .padding(10).background(.gray).foregroundColor(.white).cornerRadius(8)
        }
        .padding()
    }
}
