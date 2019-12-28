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
    private var citiesList = [CityWeatherModel]()
    private var storageProvider: StorageProviderInterface
    private var savedCitiesBarierQueue: DispatchQueue
    
    
    // MARK: - Initializers
    init(storageProvider: StorageProviderInterface) {
        self.storageProvider = storageProvider
        savedCitiesBarierQueue = DispatchQueue(
            label: "",
            attributes: .concurrent)
        super.init()
    }

   // MARK: - Methods
    // user can optionaly send his lat and lon to get his city's current weather as an element of the returned list
    func getCitiesList(currentlat: Double?, currentLon: Double?, onSuccess: @escaping ([CityWeatherModel]) -> (), onAPIError: @escaping (String) -> (), onConnectionError: @escaping (String) -> ()) {
        
        if isInternetConnected {
            var firstCity: CityWeatherModel = CityWeatherModel() // empty object
            var savedCities = [CityWeatherModel]()
            // dispatch group used to make sure that success closure will be called after the first element and the database elements are fetched
            // Note: get first city and get the database cities are called at the same time because they are independant and that is a trick that saves time.
            let allCitiesDispatchGroup = DispatchGroup()
            
            // Get first element of the list
            allCitiesDispatchGroup.enter()
            getFirsCity(lat: currentlat, lon: currentLon, onSuccess: { city in
                    firstCity = city
                    allCitiesDispatchGroup.leave()
                }, onAPIError: onAPIError, onConnectionError:onConnectionError)
            
            
            
            // Get database elements and update it
            allCitiesDispatchGroup.enter()
            getSavedCitiesAndUpdateIt(onSuccess: { cities in
                    savedCities.append(contentsOf: cities)
                    allCitiesDispatchGroup.leave()
            }, onAPIError: onAPIError, onConnectionError: onConnectionError)
            
            
            // notifiy main thread that cities' list is ready
            allCitiesDispatchGroup.notify(queue: .main) { [weak self] in
                self?.updateCitiesList(firstCity: firstCity, savedCities: savedCities, onFinish: onSuccess)
            }
        }
        else {
            citiesList = storageProvider.fetchCitiesCurrentWeather()
            onSuccess(citiesList)
        }

    }
    
    // add a city to cities list and return the all list
    func addCity(id: Int, onSuccess: @escaping ([CityWeatherModel]) -> (), onAPIError: @escaping (String) -> (), onConnectionError: @escaping (String) -> ()) {
        
        if citiesList.count == 5 {
            onAPIError("Can't add more than five cities")
        }
        else if isCityIdExist(id: id, citiesList: citiesList) {
            onAPIError("City is already exist")
        }
        else {
            getCityWeather(cityID: id, onSuccess: { [weak self] city in
                guard let strongSelf = self else { return }
                self?.storageProvider.saveCityCurrentWeather(city: city)
                self?.citiesList.append(city)
                onSuccess(strongSelf.citiesList)
                }, onAPIError: onAPIError, onConnectionError: onConnectionError)
        }
    }
    
    // remmove a city from cities list and return the list
    func removeCity(id: Int, onFinish: @escaping ([CityWeatherModel]) -> ()) {
        
        citiesList = citiesList.filter { [weak self] city -> Bool in
            if city.id == id {
                self?.storageProvider.removeCityAndForecast(city: city)
                return false
            }
            return true
        }
        onFinish(citiesList)
        
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
    
    // get stored cities and update it with the live data
    private func getSavedCitiesAndUpdateIt(onSuccess: @escaping ([CityWeatherModel]) -> (), onAPIError: @escaping (String) -> (), onConnectionError: @escaping (String) -> ()) {
        
        let storedCities = storageProvider.fetchCitiesCurrentWeather()
        var updatedCities = [CityWeatherModel]()
        let dispatchGroup = DispatchGroup()  // to wait until all cities are updated
        for city in storedCities {
            dispatchGroup.enter()
            getCityWeather(cityID: city.id , onSuccess: { [weak self] dto in
                
                // this is a critical section which needs the barrier to make sure that only one thread append at the updatedCities list
                self?.savedCitiesBarierQueue.async(flags: .barrier) {
                    updatedCities.append(dto)
                    dispatchGroup.leave()
                }
                
            }, onAPIError: onAPIError, onConnectionError: onConnectionError)
        }
        
        // notify the main thread that rest of cities' list are ready
        dispatchGroup.notify(queue: .main) {
            onSuccess(updatedCities)
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
    
    // remove old data from Ram and Database
    // add new data to Ram and Database
    private func updateCitiesList( firstCity: CityWeatherModel , savedCities: [CityWeatherModel],  onFinish: @escaping ([CityWeatherModel]) -> ()) {
        
        var _savedCities = savedCities
        //check if the first city exist at database to remove it and add the updated one
        if let index = _savedCities.firstIndex(of: firstCity) {
            _savedCities.remove(at: index)
        }
        self.citiesList.removeAll()
        self.storageProvider.removeAllCitiesAndForecast()
        self.citiesList.append(firstCity)
        self.citiesList.append(contentsOf: _savedCities)
        self.storageProvider.saveCitiesCurrentWeather(cities: self.citiesList)
        onFinish(citiesList)
        
    }
    
    private func isCityIdExist(id: Int, citiesList: [CityWeatherModel]) -> Bool {
        for city in citiesList {
            if id == city.id {
                return true
            }
        }
        return false
    }
        
}
