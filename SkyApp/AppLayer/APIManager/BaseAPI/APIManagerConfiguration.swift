//
//  APIManagerConfiguration.swift
//  SkyApp
//
//  Created by Guest2 on 12/27/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

public struct APIManagerConfiguration {
    
    public var serverUrl: URL
    public var appID: String
    
    public init(serverUrl: URL, appID: String) {
        self.serverUrl = serverUrl
        self.appID = appID
    }
}
