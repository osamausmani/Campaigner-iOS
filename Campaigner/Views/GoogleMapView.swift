//
//  GoogleMapView.swift
//  Campaigner
//
//  Created by Osama Usmani on 28/10/2023.
//

import SwiftUI
import GoogleMaps

struct GoogleMapView: UIViewRepresentable {
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)

        // Create a marker and set its position
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Complaint"
        marker.map = mapView // Add marker to the map view

        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        // Update the view if needed
    }
}
