
import SwiftUI

struct TestContent: View {
    @State private var searchText = ""
    @State private var places: [Place] = []
    
    var body: some View {
        VStack {
            TextField("Enter location", text: $searchText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Search") {
//                fetchPlaces()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            List(places, id: \.placeId) { place in
                VStack(alignment: .leading) {
                    Text(place.name ?? "Address Not Fetched")
                    Text(String(place.geometry?.location?.lat ?? 0.0) ?? "Address Not Fetched")

                 
                }
            }
        }
        .padding()
    }
    
   
}

struct TestContent_Previews: PreviewProvider {
    static var previews: some View {
        TestContent()
    }
}


