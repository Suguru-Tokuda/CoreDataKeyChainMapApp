//
//  LocationManager.swift
//  UsersMap
//
//  Created by Suguru Tokuda on 11/22/23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    @Published var currentLocation: CLLocation?
    @Published var locationAuthorized: Bool = false
    
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()        
        locationManager.delegate = self
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.currentLocation = location
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            locationAuthorized = false
            break
        case .restricted:
            locationAuthorized = false
            break
        case .denied:
            locationAuthorized = false
            break
        case .authorizedAlways:
            locationAuthorized = true
            break
        case .authorizedWhenInUse:
            locationAuthorized = true
            break
        @unknown default:
            break
        }
    }
}
