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
       
    }
    
    func next(from viewController: UIViewController) {
       
    }
    
    func back(from viewController: UIViewController) {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func terminate() {
        
    }
    
}
