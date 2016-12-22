//
//  LocationManager.swift
//  SelfiePhoto
//
//  Created by Lin David, US-205 on 11/13/16.
//  Copyright © 2016 Lin David. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject {
    let manager = CLLocationManager()
    let geocoder = CLGeocoder()
    var onLocationFix: ((CLPlacemark?, NSError?) -> Void)?
    
    override init() {
        super.init()
        manager.delegate = self
        getPermission()
    }

    private func getPermission() {
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            manager.requestWhenInUseAuthorization()
        }
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Unresolved error \(error), \(error.userInfo)")
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let onLocationFix = self.onLocationFix {
                onLocationFix(placemarks?.first, error)
            }
        }
    }
}