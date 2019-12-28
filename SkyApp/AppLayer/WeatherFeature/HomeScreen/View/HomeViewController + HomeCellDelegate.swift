//
//  HomeViewController + HomeCellDelegate.swift
//  SkyApp
//
//  Created by Guest2 on 12/27/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

extension HomeViewController: HomeCellDelegate {
    func removeCity(at indexPath: IndexPath) {
        viewModel.removeCity(id: citiesList[indexPath.row].id, onFinish: { [weak self] cities in
            self?.citiesList = cities
            self?.tableView.reloadData()
        })
    }
}
