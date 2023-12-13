//
//  AddLocationView.swift
//  Campaigner
//
//  Created by Macbook  on 10/11/2023.
//

import SwiftUI
import MapKit

struct AddLocationView: View {
    @State private var isPresented = true
    @State public var mapLat = 33.6844
    @State public var mapLng = 73.0479
    
    
    @State public var btnState = 0
    @State private var places: [Place] = []
    @State private var searchText = ""
    
    @StateObject private var sharedLocationData: SharedLocationData
    @State private var inputLatitude: String = ""
    @State private var inputLongitude: String = ""
    @State private var inputLocationName: String = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    init(sharedLocationData: SharedLocationData) {
        _sharedLocationData = StateObject(wrappedValue: sharedLocationData)
    }

    
    var body: some View {
        
        ZStack {
            GoogleMapView(latitude: $mapLat, longitude: $mapLng)
                .ignoresSafeArea(edges: .all)
            
            
            VStack(spacing: 0) {
                CustomNavBarBack(title: "Add Location")
                
                VStack {
                    SearchBarView(searchText: $searchText)
                        .padding(.bottom, 10)
                    
                        .padding()
                    if places.count > 0 {
                        List(places, id: \.placeId) { place in
                            VStack(alignment: .leading) {
                                Text(place.name ?? "Address Not Fetched").onTapGesture {
                                    btnState = 1
                                    places.removeAll()
                                    mapLat = (place.geometry?.location?.lat)!
                                    mapLng = (place.geometry?.location?.lng)!
                                    inputLatitude = String(mapLat)
                                    inputLongitude = String(mapLng)
                                    inputLocationName = place.name ?? "Address Not Fetched"
                                }
                            }
                        }.frame(height: CGFloat(60 * places.count) + 40)
                        
                    }
                    MainButton(action: {
                        if btnState == 0 {
                            fetchPlaces()
                        }
                        else{
                            submitAction()
                        }
                    }, label: btnState == 0 ? "Search" : "Submit")
                    .padding([.leading, .trailing], 10)
                    .padding(.bottom, 10)
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                )
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationBarHidden(true)
            
        }
        .onChange(of: searchText) { newValue in
            
            btnState = 0
            places.removeAll()
            
            
        }
        
        .navigationBarHidden(true)
    }
    
    
    
    func fetchPlaces() {
        guard let apiKey = "AIzaSyBzMk8HnrF5suLuEZec3bdeOyMQZ6cSeEc".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let encodedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(encodedSearchText)&key=\(apiKey)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                
                let jsonString = String(data: data, encoding: .utf8)
                print("Raw JSON Response:")
                print(jsonString ?? "Failed to convert data to string")
                
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(PlacesResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.places = result.results
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }
        
        task.resume()
    }
    
    func submitAction(){
        sharedLocationData.latitude = inputLatitude
        sharedLocationData.longitude = inputLongitude
        sharedLocationData.locationName = inputLocationName
        presentationMode.wrappedValue.dismiss()
    }
    
}





//struct AddLocationView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddLocationView()
//    }
//}

struct Place: Decodable {
    var placeId: String?
    var formatted_address: String?
    var business_status: String?
    var name:String?
    var geometry: GeometryPlace?
    
    
}

struct GeometryPlace:Decodable{
    var location:Location?
}

struct Location:Decodable {
    var lat: Double?
    var lng:Double?
}

struct PlacesResponse: Decodable {
    let results: [Place]
    
}

