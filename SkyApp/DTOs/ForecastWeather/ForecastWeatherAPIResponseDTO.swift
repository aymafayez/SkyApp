//
//  FiveDaysForecastAPIResponseDTO.swift
//  SkyApp
//
//  Created by Guest2 on 12/27/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

import Foundation

// MARK: - FiveDaysWeatherAPIResponseDTO
struct ForecastWeatherAPIResponseDTO: Codable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let timezone, sunrise, sunset: Int
}


// MARK: - List
struct List: Codable {
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let sys: Sys
    let dtTxt: String
    let snow, rain: Rain?
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, sys
        case dtTxt = "dt_txt"
        case snow, rain
    }
}



// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the3H: Double
    
    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}



enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}


enum Icon: String, Codable {
    case the01N = "01n"
    case the04D = "04d"
    case the04N = "04n"
    case the10N = "10n"
    case the13D = "13d"
    case the13N = "13n"
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case snow = "Snow"
}

enum Description: String, Codable {
    case clearSky = "clear sky"
    case lightRain = "light rain"
    case lightSnow = "light snow"
    case overcastClouds = "overcast clouds"
}





