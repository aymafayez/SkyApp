//
//  HomeViewController + ChooseCityProtocol.swift
//  SkyApp
//
//  Created by Guest2 on 12/27/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

extension HomeViewController: ChooseCityDelegate {
    
    func didSelectCity(city: CityElement) {
        showLoadingView()
        viewModel.addCity(id: city.id, onSuccess: { [weak self] cities in
            self?.citiesList = cities
            self?.tableView.reloadData()
            self?.hideLoadingView()
        }, onAPIError: { [weak self] error in
            self?.hideLoadingView()
            self?.showErrorView(title: "error", description: error)
        }) { [weak self] error in
            self?.hideLoadingView()
            self?.showErrorView(title: "error", description: error)
        }
    }
    
}
