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
    
    var cities = [CityWeatherModel]()
    override init() {
      
    }
    
   
    func getCitiesList(lat: Double?, lon: Double?, onSuccess: @escaping ([CityWeatherModel]) -> (), onAPIError: @escaping (String) -> (), onConnectionError: @escaping (String) -> ()) {
        getFirstElementOfForecastList(lat: lat, lon: lon, onSuccess: { [weak self] city in
            guard let strongSelf = self else { return }
            self?.cities.append(city)
            onSuccess(strongSelf.cities)
        }, onAPIError: onAPIError, onConnectionError:onConnectionError)
    }
    
    func addCity(id: Int, onSuccess: @escaping ([CityWeatherModel]) -> (), onAPIError: @escaping (String) -> (), onConnectionError: @escaping (String) -> ()) {
        getCityWeatherElement(id: id, onSuccess: { [weak self] city in
            guard let strongSelf = self else { return }
            self?.cities.append(city)
            onSuccess(strongSelf.cities)
        }, onAPIError: onAPIError, onConnectionError: onConnectionError)
    }
    
    func removeCity(id: Int, onFinish: @escaping ([CityWeatherModel]) -> ()) {
        cities = cities.filter { city -> Bool in
            if city.id == id {
                return false
            }
            return true
        }
        onFinish(cities)
    }
    
    private func getRestOfCities(onSuccess: @escaping ([CityWeatherModel]) -> (), onError: @escaping (String) -> ()) {
        if Network.reachability.isReachableViaWiFi || Network.reachability.isReachableOnWWAN {
            
        }
        else {
            
        }
    }
    
    private func getFirstElementOfForecastList(lat: Double?, lon: Double?, onSuccess: @escaping (CityWeatherModel) -> (), onAPIError: @escaping (String) -> (), onConnectionError: @escaping (String) -> ()) {
        
            if let _lat = lat, let _lon = lon {
                getFirstElement(lat: _lat, lon: _lon, onSuccess: onSuccess, onAPIError: onAPIError, onConnectionError: onConnectionError)
            }
            else {
                getCityWeatherElement(id: 2643743, onSuccess: onSuccess, onAPIError: onAPIError, onConnectionError: onConnectionError)
            }

    }
    
    // Call this function if user allows location access
    private func getFirstElement(lat: Double, lon: Double, onSuccess: @escaping (CityWeatherModel) -> (), onAPIError: @escaping (String) -> (), onConnectionError: @escaping (String) -> ()) {
        
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
    
    // call this function if user don't allow location access
    // it is recommended from the api doucemention to use country id
     private func getCityWeatherElement(id: Int, onSuccess: @escaping (CityWeatherModel) -> (), onAPIError: @escaping (String) -> (), onConnectionError: @escaping (String) -> () ) {
        
        let dto = CurrentWeatherAPIRequestDTO(id: id)
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
    
    private func getTheRestOfForcastList() {
        
    }
    
}
