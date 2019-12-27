//
//  URLSessionRequestExecuter.swift
//  SkyApp
//
//  Created by Guest2 on 12/27/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

public class URLSessionRequestExecuter: URLRequestExecuter {
    
    public var url: URL
    public var requestConfig: RequestConfig
    public var onComplete: onComplete
    public var onFailure: onFailure
    public var parameterEncoder: ParameterEncoder?
    public var parameters: Parameters?
    public var queryItems: [String:String]?
    public var request: URLRequest!
    public var session: URLSession!
    
    public required init(session:URLSession,url:URL, requestConfig: RequestConfig, parameters:Parameters?, parameterEncoder:ParameterEncoder?, onComplete: @escaping onComplete, onFailure: @escaping onFailure) throws {
        self.session = session
        self.url = url
        self.requestConfig = requestConfig
        self.parameters = parameters
        self.parameterEncoder = parameterEncoder
        self.onComplete = onComplete
        self.onFailure = onFailure
        do {
            self.request = try buildRequest(url: url, requestConfig: requestConfig, parameters: parameters)
        } catch(let error){
            throw error
        }
        
    }
    
    
    public func execute() {
        let task = session.dataTask(with: request) { (data, response, error) in
            // NOTE: If there is an error, then the request didn't complete successfully
            // otherwise there must be data and response objects
            if let error = error as? URLError {
                self.onFailure(error)
            } else {
                self.onComplete(data, response as! HTTPURLResponse)
            }
        }
        task.resume()
    }
    
    func buildRequest(url:URL,requestConfig: RequestConfig, parameters: Parameters?) throws -> URLRequest{
        var request  = URLRequest(url: url)
        request.timeoutInterval = 10
        request.httpMethod =  requestConfig.httpMethod.rawValue
        request.allHTTPHeaderFields = requestConfig.allHTTPHeaderFields
        do {
            try encodeParameters(urlRequest: &request, with: parameters)
        } catch(let error){
            throw error
        }
        return request
    }
    
    func buildRequest(url:URL,requestConfig: RequestConfig, parameters: Data)  -> URLRequest{
        var request  = URLRequest(url: url)
        request.timeoutInterval = 10
        request.httpMethod =  requestConfig.httpMethod.rawValue
        request.allHTTPHeaderFields = requestConfig.allHTTPHeaderFields
        request.httpBody = parameters
        if request.value(forHTTPHeaderField: "Content-Type") == nil {
            request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
    
    
    func encodeParameters(urlRequest: inout URLRequest, with parameters: Parameters?) throws {
        if let _parameters = parameters {
            do {
                try parameterEncoder?.encode(urlRequest: &urlRequest, with: _parameters)
            } catch(let error){
                throw error
            }
        }
    }
}

public typealias Parameters = [String:Any]


