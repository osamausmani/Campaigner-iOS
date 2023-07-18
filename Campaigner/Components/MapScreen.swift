//
//  MapScreen.swift
//  Campaigner
//
//  Created by Macbook  on 13/07/2023.
//
import SwiftUI
import MapKit

struct IdentifiableAnnotation: Identifiable {
    let id = UUID()
    let annotation: MKPointAnnotation
}

struct MapScreen: View {
    @Binding var region: MKCoordinateRegion
    @Binding var annotations: [IdentifiableAnnotation]
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: annotations) { annotation in
            MapMarker(coordinate: annotation.annotation.coordinate)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 31.5204, longitude: 74.3587), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @State private var annotations: [IdentifiableAnnotation] = []
    
    var body: some View {
        VStack {
            Text("Location")
                .font(.headline)
                .padding()
            
            MapScreen(region: $region, annotations: $annotations)
                .frame(height: 500)
                .cornerRadius(10)
                .padding()
            
            Button("Add Marker") {
                let newAnnotation = MKPointAnnotation()
                newAnnotation.coordinate = CLLocationCoordinate2D(latitude:  31.5204, longitude: 74.3587)
                let identifiableAnnotation = IdentifiableAnnotation(annotation: newAnnotation)
                annotations.append(identifiableAnnotation)
            }
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



