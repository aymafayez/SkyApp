//
//  DetailsViewController + TableViewProtocols.swift
//  SkyApp
//
//  Created by Guest2 on 12/26/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation
import UIKit

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCellEnum.CellReuseIdentifier.rawValue) as? DetailsTableViewCell
        cell?.dayLabel.text = forecastList[indexPath.row].day
        cell?.tempLabel.text = String(forecastList[indexPath.row].temp)
        return  cell ?? UITableViewCell()
        
    }
    
}
