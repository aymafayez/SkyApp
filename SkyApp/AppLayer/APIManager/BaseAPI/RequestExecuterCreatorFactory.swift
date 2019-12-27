//
//  RequestExecuterCreatorFactory.swift
//  SkyApp
//
//  Created by Guest2 on 12/27/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

public class RequestExecuterCreatorFactory: RequestExecuterCreator {
    public init() {}
    public func create(session: URLSession, apiURL: URL, requestConfig: RequestConfig, parameters: [String: Any]?, paramEncoder: ParameterEncoder?,  onComplete: @escaping onComplete, onFailure: @escaping onFailure) throws -> URLRequestExecuter {
        let requestExecuter = try URLSessionRequestExecuter(session: session, url: apiURL, requestConfig: requestConfig, parameters: parameters, parameterEncoder: paramEncoder, onComplete: onComplete, onFailure: onFailure)
        return requestExecuter
    }
}
