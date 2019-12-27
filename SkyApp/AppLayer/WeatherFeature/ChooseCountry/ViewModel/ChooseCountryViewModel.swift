//
//  ChooseCountryViewModel.swift
//  SkyApp
//
//  Created by Guest2 on 12/27/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

class ChooseCountryViewModel: BaseViewModel {
    
    let fileName: String
    let fileType: String
    
    init(fileName: String, fileType: String) {
       self.fileName = fileName
       self.fileType = fileType
    }
    
    
    
    // MARK: - Methods
    func getListOfCities(onSuccess: @escaping ([CityElement]) -> (), onError: @escaping (String) -> ()) {
        
        if let path = Bundle.main.path(forResource: fileName, ofType: fileType) {
            DispatchQueue.global(qos: .userInteractive).async {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let dto = try JSONDecoder().decode([CityElement].self, from: data)
                    DispatchQueue.main.async {
                     onSuccess(dto)
                    }
                }
                catch {
                    // handle error
                }
            }

        }
    }
    
    func getListOfCities(searchString: String, citiesList: [CityElement]) -> [CityElement] {
            let  filteredList = searchString.isEmpty ? citiesList : citiesList.filter { (item: CityElement) -> Bool in
                return item.name.range(of: searchString, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
            return filteredList
        }
    }
    

