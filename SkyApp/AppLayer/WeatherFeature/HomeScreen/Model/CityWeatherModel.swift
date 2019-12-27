//
//  ForecastModel.swift
//  SkyApp
//
//  Created by Guest2 on 12/27/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

class CityWeatherModel {
    var name: String
    var description: String
    var temp: Double
    
    init(name: String, description: String, temp: Double) {
        self.name = name
        self.description = description
        self.temp = temp
    }
}
