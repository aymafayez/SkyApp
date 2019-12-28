//
//  URLParameterEncoder.swift
//  SkyApp
//
//  Created by Guest2 on 12/27/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

public class URLParameterEncoder: ParameterEncoder {
    
    public enum Destination {
        case queryString, httpBody
    }
    
    var destination: Destination = .queryString
    
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        if var urlCompnents = URLComponents(url: url, resolvingAgainstBaseURL: true), !parameters.isEmpty {
            
            urlCompnents.queryItems = [URLQueryItem]()
            
            switch self.destination {
            case .httpBody:
                var postString = ""
                var i = 0
                for (key, value) in parameters {
                    let queryItem = "\(key)=\(value)"
                    postString.append(queryItem)
                    i += 1
                    if (i < parameters.count) {
                        postString.append("&")
                    }
                }
                let postData = NSMutableData(data: postString.data(using: .utf8)!)
                urlRequest.httpBody = postData as Data
            case .queryString:
                for (key,value) in parameters {
                    let queryItem = URLQueryItem(name: key, value: "\(value)")
                    urlCompnents.queryItems?.append(queryItem)
                }
                urlRequest.url = urlCompnents.url
            }
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
    
    public init() {}
    
    public init(destination: Destination ) {
        self.destination = destination
    }
}

