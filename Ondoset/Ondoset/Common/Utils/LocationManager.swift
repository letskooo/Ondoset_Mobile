//
//  LocationManager.swift
//  Ondoset
//
//  Created by KoSungmin on 5/10/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus
    
    override init() {
        
        self.authorizationStatus = locationManager.authorizationStatus
        super.init()
        locationManager.delegate = self
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.authorizationStatus = manager.authorizationStatus
    }
}
