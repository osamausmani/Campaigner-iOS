//
//  GoogleMapView.swift
//  Campaigner
//
//  Created by Osama Usmani on 28/10/2023.
//

import SwiftUI
import GoogleMaps

struct GoogleMapView: UIViewRepresentable {
    @Binding public var latitude: Double
    @Binding public var longitude: Double

    @State private var mapMarker: GMSMarker? // Store a reference to the marker

    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 16.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)

        // Create a marker and set its position
        var marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = "Complaint"
        marker.map = mapView // Add marker to the map view

        // Store the reference to the marker
        mapMarker = marker

        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        // Update the view if needed
        let newCamera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 16.0)
        uiView.animate(to: newCamera)

        // Update the marker position
        if let marker = mapMarker {
            marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            marker.map = uiView
        } else {
            // If the marker is nil, create a new one and add it to the map
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            marker.title = "Complaint"
            marker.map = uiView
            mapMarker = marker
        }
    }
}



class SharedLocationData: ObservableObject {

    
    @Published var latitude: String = ""
    @Published var longitude: String = ""
    @Published var locationName: String = ""
}
