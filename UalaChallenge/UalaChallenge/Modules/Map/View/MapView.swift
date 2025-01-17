//
//  MapView.swift
//  UalaChallenge
//
//  Created by Fede Flores on 16/01/2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    private enum Constants {
        static let markerImage = "mappin"
    }
    
    @State private var isPortrait = UIDevice.current.orientation.isPortrait

    var viewModel: MapViewModel
    
    var body: some View {
        ZStack {
            if isPortrait {
                mapView
            } else {
                HStack {
                    HomeModuleBuilder.build()
                        .frame(maxWidth: .infinity)
                    mapView
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .onRotate { deviceOrientation in
            isPortrait = deviceOrientation.isPortrait
        }
    }
    
    private var mapView: some View {
        Map(initialPosition: MapCameraPosition.region(viewModel.region))  {
            Marker(coordinate: viewModel.region.center) {
                Label(viewModel.city, systemImage: Constants.markerImage)
            }
        }
    }
}

#Preview {
    let region: MKCoordinateRegion = {
        let mapCoordinate = CLLocationCoordinate2D(latitude: -41.29364175403352, longitude: 174.77867212458094)
        let mapZoomLevel = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 0.001)
        let mapRegion = MKCoordinateRegion(center: mapCoordinate, span: mapZoomLevel)
        return mapRegion
    }()
    MapView(viewModel: MapViewModel(city: "Testing pin", region: region))
}
