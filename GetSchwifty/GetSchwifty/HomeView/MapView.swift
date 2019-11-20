//
//  MapView.swift
//  GetSchwifty
//
//  Created by Arminas on 2019-11-19.
//  Copyright © 2019 Arminas. All rights reserved.
//

import SwiftUI
import MapKit
import Combine

struct MapView: UIViewRepresentable {
    
    var coordinate: CLLocationCoordinate2D?
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 2.0,
                                    longitudeDelta: 2.0)
        guard let coordinate = coordinate else {
            return
        }
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        view.addAnnotation(annotation)
    }
}

//struct MapView_Preview: PreviewProvider {
//    static var previews: some View {
//        MapView(coordinate: )
//    }
//}
