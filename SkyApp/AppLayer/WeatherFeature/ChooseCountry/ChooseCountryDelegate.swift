//
//  ChooseCountryDelegate.swift
//  SkyApp
//
//  Created by Guest2 on 12/27/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

protocol ChooseCountryDelegate: AnyObject {
    func didSelectCurrency(country: String?)
}
