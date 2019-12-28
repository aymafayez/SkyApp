//
//  RequestConfig.swift
//  SkyApp
//
//  Created by Guest2 on 12/27/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

public struct RequestConfig: Equatable{
    public var httpMethod: HTTPMethod
    public var allHTTPHeaderFields: [String : String]?
    public init (httpMethod: HTTPMethod, allHTTPHeaderFields:[String : String]?) {
        self.httpMethod = httpMethod
        self.allHTTPHeaderFields = allHTTPHeaderFields
    }
    public static func == (lhs: RequestConfig, rhs: RequestConfig) -> Bool {
        if lhs.httpMethod == rhs.httpMethod && lhs.allHTTPHeaderFields == rhs.allHTTPHeaderFields {
            return true
        }
        return false
    }
    
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
