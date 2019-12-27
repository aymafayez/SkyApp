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
    
   
    func getForecastList(lat: Double?, lon: Double?, onSuccess: @escaping ([CurrentWeatherModel]) -> (), onAPIError: @escaping (String) -> (), onConnectionError: @escaping (String) -> ()) {
        var firstElement = CurrentWeatherModel(cityName: "", description: "", temp: 0)
        getFirstElementOfForecastList(lat: lat, lon: lon, onSuccess: {  element in
            firstElement = element
        }, onAPIError: onAPIError, onConnectionError:onConnectionError)
      
    }
    
    private func getFirstElementOfForecastList(lat: Double?, lon: Double?, onSuccess: @escaping (CurrentWeatherModel) -> (), onAPIError: @escaping (String) -> (), onConnectionError: @escaping (String) -> ()) {
        
            if let _lat = lat, let _lon = lon {
                getFirstElement(lat: _lat, lon: _lon, onSuccess: onSuccess, onAPIError: onAPIError, onConnectionError: onConnectionError)
            }
            else {
                getFirstElement(id: 2643743, onSuccess: onSuccess, onAPIError: onAPIError, onConnectionError: onConnectionError)
            }

    }
    
    // Call this function if user allows location access
    private func getFirstElement(lat: Double, lon: Double, onSuccess: @escaping (CurrentWeatherModel) -> (), onAPIError: @escaping (String) -> (), onConnectionError: @escaping (String) -> ()) {
        
        let dto = CurrentWeatherAPIRequestDTO(lat: lat, lon: lon)
        let api = CurrentWeatherAPI(requestDTO: dto, onSuccess: { dto in
            if let _dto = dto {
                let model = CurrentWeatherModel(cityName: _dto.name , description: _dto.weather[0].main, temp: _dto.main.temp )
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
    private func getFirstElement(id: Int, onSuccess: @escaping (CurrentWeatherModel) -> (), onAPIError: @escaping (String) -> (), onConnectionError: @escaping (String) -> () ) {
        
        let dto = CurrentWeatherAPIRequestDTO(id: id)
        let api = CurrentWeatherAPI(requestDTO: dto, onSuccess: { dto in
            if let _dto = dto {
                let model = CurrentWeatherModel(cityName: _dto.name , description: _dto.weather[0].main, temp: _dto.main.temp )
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
    
    private func getCurrentLocation() -> (lat: Double?, lon: Double?) {
        return (lat: -0.13 , lon: 51.51)
    }
    
    
    
}
