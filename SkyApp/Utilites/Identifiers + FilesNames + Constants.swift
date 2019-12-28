//
//  Identifiers + FilesNames.swift
//  SkyApp
//
//  Created by Guest2 on 12/26/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

enum HomeTableViewCellEnum: String {
    case nibName = "HomeTableViewCell"
    case CellReuseIdentifier = "HomeTableViewCellID"
}

enum DetailsTableViewCellEnum: String {
    case nibName = "DetailsTableViewCell"
    case CellReuseIdentifier = "DetailsTableViewCellID"
}

enum SearchCountryTableViewCellEnum: String {
    case nibName = "CountryTableViewCell"
    case CellReuseIdentifier = "CountryTableViewCellID"
}

enum ImagesEnum: String {
    case HomeBackGroundImage = "HomeBackGround"
    case DetailsBarImage = "DetialsBarImage"
}

enum CitiesListFileEnum: String {
    case name = "cityList"
    case type = "json"
}

var LondonUKID = 2643743

var backEndDateFormat = "yyyy-MM-dd HH:mm:ss"
var appDateTimeFormat = "dd-MM-yyyy HH:mm"
var appDayformat = "EEEE"
