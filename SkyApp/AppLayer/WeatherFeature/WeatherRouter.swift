//
//  WeatherRouter.swift
//  SkyApp
//
//  Created by Guest2 on 12/26/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation
import UIKit

class WeatherRouter: WeatherRouterProtocol {
    
    func start(navigationController: UINavigationController) {
        let storageProvider = CoreDataStorageProvider()
        let vm = HomeViewModel(storageProvider: storageProvider)
        let vc = HomeViewController(viewModel: vm, router: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func next(navigationController: UINavigationController, id: Int) {
        let vm = DetailsViewModel(id: id)
        let vc = DetailsViewController(viewModel: vm, router: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func back(from viewController: UIViewController) {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func terminate() {
        
    }
    
}
