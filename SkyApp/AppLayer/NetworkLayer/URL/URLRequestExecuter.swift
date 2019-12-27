//
//  URLRequestExecuter.swift
//  SkyApp
//
//  Created by Guest2 on 12/27/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

public protocol URLRequestExecuter {
    var url: URL { get set }
    var requestConfig: RequestConfig { get set }
    var onComplete: onComplete { get set }
    var onFailure: onFailure { get set }
    func execute()
}

public typealias onComplete = (Data?, HTTPURLResponse) -> Void
public typealias onFailure = (URLError) -> Void
