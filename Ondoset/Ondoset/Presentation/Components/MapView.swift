//
//  MapView.swift
//  Ondoset
//
//  Created by KoSungmin on 5/10/24.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = text
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            
            guard let coordinate = response?.mapItems.first?.placemark.coordinate else { return }
            
            print("위도: \(coordinate.latitude), 경도: \(coordinate.longitude)")
            
        }
    }
}

#Preview {
    MapView(text: .constant("가천대"))
}
