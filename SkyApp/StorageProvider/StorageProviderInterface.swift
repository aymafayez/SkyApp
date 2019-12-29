//
//  StorageProviderInterface.swift
//  SkyApp
//
//  Created by Guest2 on 12/28/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

protocol StorageProviderInterface {
    func fetchCitiesCurrentWeather() -> [CityWeatherModel]
    func saveCityCurrentWeather(city: CityWeatherModel)
    func saveCitiesCurrentWeather(cities: [CityWeatherModel])
    func removeCityCurrentWeather(city: CityWeatherModel)
    func removeAllCitiesCurrentWeather()
}
