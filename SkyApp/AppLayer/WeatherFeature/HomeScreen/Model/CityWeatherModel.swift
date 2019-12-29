//
//  ForecastModel.swift
//  SkyApp
//
//  Created by Guest2 on 12/27/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

class CityWeatherModel: Equatable {

    
    
    // MARK: - Properties
    var id: Int
    var name: String
    var description: String
    var temp: Double
    
    // MARK: - Methods
    init(id: Int ,name: String, description: String, temp: Double) {
        self.id = id
        self.name = name
        self.description = description
        self.temp = temp
    }
    
    init() {
        // empty object
        self.id = -1
        self.name = ""
        self.description = ""
        self.temp = -1
    }
    
    // MARK: - Methods
    static func == (lhs: CityWeatherModel, rhs: CityWeatherModel) -> Bool {
        if lhs.id == rhs.id {
            return true
        }
        return false
    }
    
}
