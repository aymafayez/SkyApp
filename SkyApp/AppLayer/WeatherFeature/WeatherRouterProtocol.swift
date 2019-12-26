//
//  WeatherRouterProtocol.swift
//  SkyApp
//
//  Created by Guest2 on 12/26/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation
import UIKit

protocol WeatherRouterProtocol {
    func start(navigationController: UINavigationController)
    func terminate()
    func next(from viewController: UIViewController)
    func back(from viewController: UIViewController)
}
