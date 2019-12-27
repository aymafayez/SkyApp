//
//  HomeViewController + TableViewProtocols.swift
//  SkyApp
//
//  Created by Guest2 on 12/26/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation
import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCellEnum.CellReuseIdentifier.rawValue) as? HomeTableViewCell
        cell?.citiyNameLabel.text = citiesList[indexPath.row].name
        cell?.weatherDecriptionLabel.text = citiesList[indexPath.row].description
        cell?.weatherDegreeLabel.text = String(citiesList[indexPath.row].temp)
        cell?.selectionStyle = .none
        cell?.delegate = self
        return  cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.next(navigationController: self.navigationController!, id: citiesList[indexPath.row].id)
    }
    
}
