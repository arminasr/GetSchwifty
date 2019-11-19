//
//  MapView.swift
//  GetSchwifty
//
//  Created by Arminas on 2019-11-19.
//  Copyright © 2019 Arminas. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    //var coordinate: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "🇨🇭 Crans-Montana, Switzerland"
        request.region = view.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            let span = MKCoordinateSpan(latitudeDelta: 2.0,
                                        longitudeDelta: 2.0)
            let region = MKCoordinateRegion(center: response.mapItems[0].placemark.coordinate, span: span)
            view.setRegion(region, animated: true)
        }
    }
}

//struct MapView_Preview: PreviewProvider {
//    static var previews: some View {
//        MapView(coordinate: )
//    }
//}
