//
//  ChooseCountryViewModel.swift
//  SkyApp
//
//  Created by Guest2 on 12/27/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

class ChooseCountryViewModel: BaseViewModel {
    
    // MARK: - Properties
    var citiesList: [CityElement]
    private let fileName: String
    private let fileType: String
    
    // MARK: - Initializers
    init(fileName: String, fileType: String) {
       self.fileName = fileName
       self.fileType = fileType
       self.citiesList = [CityElement]()
    }
    
    // MARK: - Methods
    func getListOfCities(onSuccess: @escaping ([CityElement]) -> (), onError: @escaping (String) -> ()) {
        
        if let path = Bundle.main.path(forResource: fileName, ofType: fileType) {
            
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let dto = try JSONDecoder().decode([CityElement].self, from: data)
                    self?.citiesList = dto
                    DispatchQueue.main.async {
                     onSuccess(self?.citiesList ?? [CityElement]())
                    }
                }
                catch {
                    onError("Error")
                }
            }
            
        }
        
    }
    
    func searchForCities(searchString: String) -> [CityElement] {
        
            let  filteredList = searchString.isEmpty ? citiesList : citiesList.filter { (item: CityElement) -> Bool in
                return item.name.range(of: searchString, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
            return filteredList
        
        }
    
    }
    

