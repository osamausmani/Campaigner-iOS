//
//  GoogleMapView.swift
//  Campaigner
//
//  Created by Osama Usmani on 28/10/2023.
//

import SwiftUI
import GoogleMaps

struct GoogleMapView: UIViewRepresentable {
    var latitude:String
    var longitude :String
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: Double(latitude) ?? 0.0, longitude: Double(longitude) ?? 0.0, zoom: 16.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        print(latitude)
        print(longitude)

        // Create a marker and set its position
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: Double(latitude) ?? 0.0, longitude: Double(longitude) ?? 0.0)
        marker.title = "Complaint"
        marker.map = mapView // Add marker to the map view

        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        // Update the view if needed
    }
}
