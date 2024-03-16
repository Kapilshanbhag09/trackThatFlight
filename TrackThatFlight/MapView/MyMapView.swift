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
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let annotationView = MKAnnotationView()
            annotationView.annotation = annotation
            
            let colorsConfig = UIImage.SymbolConfiguration(paletteColors: [.orange, .orange])
            let sizeConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
            
            
            let airplaneImage = UIImage(systemName: "airplane", withConfiguration: colorsConfig.applying(sizeConfig))
            
            annotationView.image = airplaneImage
            
            //Rotate the view
            let angle = 100.0
            let radians = angle / 180.0 * CGFloat.pi
            let rotation = CGAffineTransformRotate(annotationView.transform, radians);
            annotationView.transform = rotation
            
            
            return annotationView
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
        mapView.isRotateEnabled = false
        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
//        var coordinates = self.directions.map({(location: CLLocation!) -> CLLocationCoordinate2D in return location.coordinate})
//        let polyline = MKPolyline(coordinates: &coordinates, count: self.directions.count)
        let span = MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.delegate = context.coordinator
        mapView.setRegion(region, animated: true)
        
        let london = MKPointAnnotation()
        london.title = "London"
        london.coordinate = location
        
        mapView.addAnnotation(london)
    }
}
