//
//  MyMapView.swift
//  TrackThatFlight
//
//  Created by Kapil Shanbhag on 18/02/24.
//

import Foundation
import SwiftUI
import MapKit


struct MyMapView: UIViewRepresentable {
    @Binding var location: CLLocationCoordinate2D

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MyMapView

        init(_ parent: MyMapView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .blue
            renderer.lineWidth = 4
            return renderer
        }
        
        func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
            print("REgion changed")
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
//        var coordinates = self.directions.map({(location: CLLocation!) -> CLLocationCoordinate2D in return location.coordinate})
//        let polyline = MKPolyline(coordinates: &coordinates, count: self.directions.count)
        let span = MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.delegate = context.coordinator
        mapView.setRegion(region, animated: true)
        
//        mapView.addOverlay(polyline)
    }
}
