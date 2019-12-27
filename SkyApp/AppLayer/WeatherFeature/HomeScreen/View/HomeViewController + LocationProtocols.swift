//
//  HomeViewController + LocationProtocols.swift
//  SkyApp
//
//  Created by Guest2 on 12/27/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation
import CoreLocation

extension HomeViewController:  CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // do stuff
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {
            return
        }
        lat = locValue.latitude
        lon = locValue.longitude
        getWeatherList()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        lat = nil
        lon = nil
        locationManager?.stopUpdatingLocation()
        getWeatherList()
    }
}
