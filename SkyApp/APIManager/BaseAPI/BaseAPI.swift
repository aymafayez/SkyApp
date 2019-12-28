//
//  BaseAPI.swift
//  SkyApp
//
//  Created by Guest2 on 12/27/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

public class BaseAPI<RequestModel: Encodable, ResponseModel: Decodable>: BaseAPIProtocol {
    
    // MARK: - Properties
    var requestDTO: RequestModel?
    var onSuccess: ((ResponseModel?) -> Void)?
    var onAPIError: ((Error) -> Void)?
    var onConnectionError: ((Error) -> Void)?
    var requestExecuterCreator: RequestExecuterCreator
    var httpMethod: HTTPMethod { return .get }
    var relativeApiPath: String { return "" }
    var paramEncoder: ParameterEncoder?
    var session: URLSession { return URLSession.shared }
    var httpHeaderFields: [String: String]?
    
    // MARK: - Initializers
    public init (requestDTO: RequestModel?, onSuccess: ((ResponseModel?) -> Void)?, onAPIError: ((Error) -> Void)?, onConnectionError: ((Error) -> Void)?, requestExecuterCreator: RequestExecuterCreator = RequestExecuterCreatorFactory()) {
        self.requestDTO = requestDTO
        self.onSuccess = onSuccess
        self.onAPIError = onAPIError
        self.onConnectionError = onConnectionError
        self.requestExecuterCreator = requestExecuterCreator
        BaseAPI.configuration = APIManagerConfiguration(serverUrl: URL(string:"http://api.openweathermap.org")!, appID: "ccbb5682a26a265ee23eeb6026cb61af")
    }
    
    // MARK: - Methods
    
    public func execute() {
        let apiURL = self.createAPIURL()
        let body = self.createAPIParameters()
        do {
            var newBody = body
            newBody["APPID"] = BaseAPI.configuration.appID
            let requestExecuter = try self.requestExecuterCreator.create(session: self.session, apiURL: apiURL, requestConfig: self.createRequestConfig(), parameters: newBody, paramEncoder: self.paramEncoder, onComplete: { [weak self](data, response) in
                let decoder = JSONDecoder()
                switch response.statusCode {
                case 200..<300:
                    guard let responseData = data else {
                        return
                    }
                    do {
                        let dto = try decoder.decode(ResponseModel.self, from: responseData)
                        self?.processResponse(response: dto)
                    } catch {
                        self?.onAPIError?(APIError.decodingError)
                    }
                case 500:
                    self?.handleAPIError(error: APIError.interalServerError)
                    
                default:
                    break
                }
                }, onFailure: { (error) in
                    self.handleConnectionError(error:error)
            })
            requestExecuter.execute()
        } catch {
            onAPIError?(APIError.encodingError)
        }
    }
    
    func processResponse(response: ResponseModel?) {
        if let successClosure = self.onSuccess {
            DispatchQueue.main.async {
                successClosure(response)
            }
        }
    }
    
    final func handleAPIError(error: Error) {
        if let errorClosure = self.onAPIError {
            DispatchQueue.main.async {
                errorClosure(error)
            }
        }
    }
    
    func handleConnectionError(error: Error) {
        if let errorClosure = self.onConnectionError {
            DispatchQueue.main.async {
                errorClosure(error)
            }
        }
    }
    
    final func createAPIURL() -> URL {
        return URL(string: self.relativeApiPath, relativeTo: BaseAPI.configuration.serverUrl)!
    }
    
    private final func createAPIParameters() -> [String: Any] {
        let body = requestDTO.dictionary ?? [String: Any]()
        return body
    }
    
    private final func createRequestConfig() -> RequestConfig {
        return RequestConfig(httpMethod: self.httpMethod, allHTTPHeaderFields: self.httpHeaderFields)
    }
    
}

public extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any]
    }
}

