//
//  APIError.swift
//  SkyApp
//
//  Created by Guest2 on 12/27/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

enum APIError: String, Error {
    case interalServerError = "Internal Server Error "
    case decodingError = "The data couldn’t be read because it isn’t in the correct format."
    case encodingError = "Failed to encode"
}
