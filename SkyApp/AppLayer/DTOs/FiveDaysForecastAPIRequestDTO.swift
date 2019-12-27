//
//  FiveDaysForecastAPIRequestDTO.swift
//  SkyApp
//
//  Created by Guest2 on 12/27/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

struct  FiveDaysWeatherAPIRequestDTO: Codable {
    let q: String?
    let mode: String?
    let lat :String?
    let lon: String?
    
    
    public init (q: String, mode: String) {
        self.q = q
        self.mode = mode
        self.lat = nil
        self.lon = nil
    }
    
    public init (lat: String, lng: String) {
        self.lat = lat
        self.lon = lng
        self.q = nil
        self.mode = nil
    }
    
}

