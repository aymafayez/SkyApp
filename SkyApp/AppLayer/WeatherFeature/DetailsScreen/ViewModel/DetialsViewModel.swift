//
//  DetialsViewModel.swift
//  SkyApp
//
//  Created by Guest2 on 12/26/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

class DetailsViewModel: BaseViewModel {
    
    // MARK: - Properties
    private var id: Int
    
    // MARK: - Initializers
    init(id: Int) {
        self.id = id
    }
    
    // MARK: - Methods
    func getFiveDaysForecast(onSuccess: @escaping ([ForecastModel]) -> (), onAPIError: @escaping (String) -> (), onConnectionError: @escaping (String) -> ()) {
        let dto = FiveDaysWeatherAPIRequestDTO(id: id)
        let api = FiveDaysForecastAPI(requestDTO: dto, onSuccess: { [weak self] dto in
            var forcastList = [ForecastModel]()
            if let list  = dto?.list {
                for element in list {
                    let date = self?.convert(date: element.dtTxt , from: backEndDateFormat , to: appDateTimeFormat)
                    let forcastElement = ForecastModel(day: date ?? "" , temp: element.main.temp)
                    forcastList.append(forcastElement)
                }
            }
            onSuccess(forcastList)
        }, onAPIError: { error in
            onAPIError(error.localizedDescription)
        }, onConnectionError: { error in
            onConnectionError(error.localizedDescription)
        })
        api.paramEncoder = URLParameterEncoder(destination: .queryString)
        api.execute()
    }
    
    private func convert(date: String, from backEndDateFormat : String, to appDateFormat : String) -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = backEndDateFormat
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = appDateFormat
        
        if let date = dateFormatterGet.date(from: date) {
           return dateFormatterPrint.string(from: date)
        } else {
          return nil
        }
    }
    
}

