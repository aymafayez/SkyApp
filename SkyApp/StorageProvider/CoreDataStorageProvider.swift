//
//  CoreDataStorageProvider.swift
//  SkyApp
//
//  Created by Guest2 on 12/28/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStorageProvider: StorageProviderInterface {
    
    // MARK: - Properties
    let context: NSManagedObjectContext
    
    // MARK: - Initializers
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - Methods
    func fetchCitiesCurrentWeather() -> [CityWeatherModel] {
        
        let request: NSFetchRequest<CityCurrentWeatherModelCD> = CityCurrentWeatherModelCD.fetchRequest()
        let listOfCoreDataModels = try! context.fetch(request)
        var citiesList = [CityWeatherModel]()
        for model in listOfCoreDataModels {
            if let name = model.name, let description = model.weatherDescription {
                let city = CityWeatherModel(id: Int(model.id), name: name, description: description, temp: model.temp)
                citiesList.append(city)
            }
        }
        return citiesList
        
    }
    
    func saveCityCurrentWeather(city: CityWeatherModel) {
        
        let cityCurrentWeather = CityCurrentWeatherModelCD(context: context)
        cityCurrentWeather.id = Int64(city.id)
        cityCurrentWeather.name = city.name
        cityCurrentWeather.temp = city.temp
        cityCurrentWeather.weatherDescription = city.description
        try? context.save()
        
    }
    
    func saveCitiesCurrentWeather(cities: [CityWeatherModel]) {
        
        for city in cities {
            let cityCurrentWeather = CityCurrentWeatherModelCD(context: context)
            cityCurrentWeather.id = Int64(city.id)
            cityCurrentWeather.name = city.name
            cityCurrentWeather.temp = city.temp
            cityCurrentWeather.weatherDescription = city.description
            try? context.save()
        }
        
    }
    
    func removeCityAndForecast(city: CityWeatherModel) {
        
        let request: NSFetchRequest<CityCurrentWeatherModelCD> = CityCurrentWeatherModelCD.fetchRequest()
        if let result = try? context.fetch(request) {
            for object in result {
                if city.id == object.id {
                    context.delete(object)
                    try? context.save()
                    break
                }
            }
        }
        
    }
    
    func removeAllCitiesAndForecast() {
        
        let request: NSFetchRequest<CityCurrentWeatherModelCD> = CityCurrentWeatherModelCD.fetchRequest()
        if let result = try? context.fetch(request) {
            for object in result {
                context.delete(object)
                try? context.save()
            }
        }
    
    }
    
    func fetchCityForecast(cityID: Int) -> ForecastModel? {
        return nil
    }
    
    func saveCityForecast(city: ForecastModel) {
        
    }
    
}
