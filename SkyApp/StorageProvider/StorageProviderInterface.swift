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
    func fetchCityForecast(cityID: Int) -> ForecastModel?
    func saveCityCurrentWeather(city: CityWeatherModel)
    func saveCityForecast(city: ForecastModel)
    func removeCityAndForecast(cityID: Int)
    func removeAllCitiesAndForecast()
}
