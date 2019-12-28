//
//  CurrentWeatherAPI.swift
//  SkyApp
//
//  Created by Guest2 on 12/27/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

class CurrentWeatherAPI: BaseAPI<CurrentWeatherAPIRequestDTO, CurrentWeatherAPIResponseDTO> {
    override var relativeApiPath: String {
        return "/data/2.5/weather?"
    }
}
