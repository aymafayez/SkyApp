//
//  ForecastModel.swift
//  SkyApp
//
//  Created by Guest2 on 12/27/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

class CurrentWeatherModel {
    var cityName: String
    var description: String
    var temp: Double
    
    init(cityName: String, description: String, temp: Double) {
        self.cityName = cityName
        self.description = description
        self.temp = temp
    }
}
