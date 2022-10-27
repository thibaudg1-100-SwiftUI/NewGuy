//
//  LocationFetcher.swift
//  NewGuy
//
//  Created by RqwerKnot on 29/03/2022.
//

import Foundation
import CoreLocation

// To use that, start by adding a new key to Info.plist called “Privacy - Location When In Use Usage Description”, then give it some sort of value explaining to the user why you need their location.

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
