//
//  ChooseCountryViewController + SearchBarProtocols.swift
//  SkyApp
//
//  Created by Guest2 on 12/27/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation
import UIKit

extension SelectCityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        citiesList = viewModel.searchForCities(searchString: searchText)
        tableView.reloadData()
    }
}
