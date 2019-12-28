//
//  FiveDaysForecastAPIRequestDTO.swift
//  SkyApp
//
//  Created by Guest2 on 12/27/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

struct  FiveDaysWeatherAPIRequestDTO: Codable {
    let id: Int?
    let lat: Double?
    let lon: Double?
    
    
    public init (id: Int) {
        self.id = id
        self.lat = nil
        self.lon = nil
    }
    
    public init (lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
        self.id = nil
    }
    
}

