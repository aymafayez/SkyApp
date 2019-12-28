//
//  CoreDataStorageProvider.swift
//  SkyApp
//
//  Created by Guest2 on 12/28/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

class CoreDataStorageProvider: StorageProviderInterface {
    
    func fetchCitiesCurrentWeather() -> [CityWeatherModel] {
        let city1 = CityWeatherModel(id: 707860, name: "", description: "", temp: 0.5)
        let city2 = CityWeatherModel(id: 519188, name: "", description: "", temp: 0.5)
        let city3 = CityWeatherModel(id: 1283378, name: "", description: "", temp: 0.5)
        let list: [CityWeatherModel] = [city1, city2, city3]
        return list
    }
    
    func fetchCityForecast(cityID: Int) -> ForecastModel? {
        return nil
    }
    
    func saveCityCurrentWeather(city: CityWeatherModel) {
        
    }
    
    func saveCityForecast(city: ForecastModel) {
        
    }
    
    func removeCityAndForecast(cityID: Int) {
        
    }
    
    func removeAllCitiesAndForecast() {
        
    }
    
}
