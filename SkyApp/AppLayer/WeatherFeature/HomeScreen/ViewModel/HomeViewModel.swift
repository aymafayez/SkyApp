//
//  HomeViewModel.swift
//  SkyApp
//
//  Created by Guest2 on 12/26/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation
import CoreLocation

class HomeViewModel: BaseViewModel {
    
    // MARK: - Properties
    var cities = [CityWeatherModel]()

   // MARK: - Methods
    // user can optionaly send his lat and lon to get his city's current weather as an element of the returned list
    func getCitiesList(currentlat: Double?, currentLon: Double?, onSuccess: @escaping ([CityWeatherModel]) -> (), onAPIError: @escaping (String) -> (), onConnectionError: @escaping (String) -> ()) {
        
        getFirsCity(lat: currentlat, lon: currentLon, onSuccess: { [weak self] city in
            guard let strongSelf = self else { return }
            self?.cities.append(city)
            onSuccess(strongSelf.cities)
        }, onAPIError: onAPIError, onConnectionError:onConnectionError)
        
    }
    
    // add a city to cities list and return the list
    func addCity(id: Int, onSuccess: @escaping ([CityWeatherModel]) -> (), onAPIError: @escaping (String) -> (), onConnectionError: @escaping (String) -> ()) {
        
        getCityWeather(cityID: id, onSuccess: { [weak self] city in
            guard let strongSelf = self else { return }
            self?.cities.append(city)
            onSuccess(strongSelf.cities)
        }, onAPIError: onAPIError, onConnectionError: onConnectionError)
        
    }
    
    // remmove a city from cities list and return the list
    func removeCity(id: Int, onFinish: @escaping ([CityWeatherModel]) -> ()) {
        
        cities = cities.filter { city -> Bool in
            if city.id == id {
                return false
            }
            return true
        }
        onFinish(cities)
        
    }
    
    /* return the user's city current weather if the user allow access to his location
       return London UK current weather if the user doesn't allow access to his location*/
    private func getFirsCity(lat: Double?, lon: Double?, onSuccess: @escaping (CityWeatherModel) -> (), onAPIError: @escaping (String) -> (), onConnectionError: @escaping (String) -> ()) {
        
            if let _lat = lat, let _lon = lon {
                getCityWeather(lat: _lat, lon: _lon, onSuccess: onSuccess, onAPIError: onAPIError, onConnectionError: onConnectionError)
            }
            else {
                getCityWeather(cityID: LondonUKID, onSuccess: onSuccess, onAPIError: onAPIError, onConnectionError: onConnectionError)
            }

    }
    
    private func getRestOfCities(onSuccess: @escaping ([CityWeatherModel]) -> (), onError: @escaping (String) -> ()) {
        if Network.reachability.isReachableViaWiFi || Network.reachability.isReachableOnWWAN {
            
        }
        else {
            
        }
    }
    
    // get city's current weather by city's location
    // Call this function if user allows location access
    private func getCityWeather(lat: Double, lon: Double, onSuccess: @escaping (CityWeatherModel) -> (), onAPIError: @escaping (String) -> (), onConnectionError: @escaping (String) -> ()) {
        
        let dto = CurrentWeatherAPIRequestDTO(lat: lat, lon: lon)
        let api = CurrentWeatherAPI(requestDTO: dto, onSuccess: { dto in
            if let _dto = dto {
                let model = CityWeatherModel(id: _dto.id, name: _dto.name , description: _dto.weather[0].main, temp: _dto.main.temp )
                onSuccess(model)
            }

        }, onAPIError: { error in
            onAPIError(error.localizedDescription)
        }, onConnectionError: { error in
            onConnectionError(error.localizedDescription)
        })
        api.paramEncoder = URLParameterEncoder(destination: .queryString)
        api.execute()
    }
    
    // get city's current weather by city's ID
    // call this function if user doesn't allow location access
    // it is recommended from the api doucemention to use city id
     private func getCityWeather(cityID: Int, onSuccess: @escaping (CityWeatherModel) -> (), onAPIError: @escaping (String) -> (), onConnectionError: @escaping (String) -> () ) {
        
        let dto = CurrentWeatherAPIRequestDTO(id: cityID)
        let api = CurrentWeatherAPI(requestDTO: dto, onSuccess: { dto in
            if let _dto = dto {
                let model = CityWeatherModel(id: _dto.id, name: _dto.name , description: _dto.weather[0].main, temp: _dto.main.temp )
                onSuccess(model)
            }
            
        }, onAPIError: { error in
            onAPIError(error.localizedDescription)
        }, onConnectionError: { error in
            onConnectionError(error.localizedDescription)
        })
        api.paramEncoder = URLParameterEncoder(destination: .queryString)
        api.execute()
        
    }
        
}
