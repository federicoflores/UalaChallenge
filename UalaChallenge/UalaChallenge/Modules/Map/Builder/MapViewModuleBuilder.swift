//
//  MapViewBuilder.swift
//  UalaChallenge
//
//  Created by Fede Flores on 16/01/2025.
//

import SwiftUI
import MapKit

class MapViewModuleBuilder {
    static func build(place: UalaPlace) -> UIViewController {
        let mapViewModel = MapViewModel(
            city: place.name,
            region: MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: place.coordinate.latitude,
                longitude: place.coordinate.longitude) ,
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)))
        let mapView: MapView = MapView(viewModel: mapViewModel)
        let hosting = UIHostingController(rootView: mapView)
        hosting.title = "Map view"
        return hosting
    }
}

