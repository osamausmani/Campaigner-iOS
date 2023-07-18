//
//  MapScreen.swift
//  Campaigner
//
//  Created by Macbook  on 13/07/2023.
//

import SwiftUI
import MapKit

struct MapScreen: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3352, longitude: -122.0096), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    var body: some View {
        Map(coordinateRegion: $region)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Map Screen")
                .font(.largeTitle)
                .padding()
            
            MapScreen()
                .frame(height: 300)
                .cornerRadius(10)
                .padding()
            
            // Other content in your view
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
