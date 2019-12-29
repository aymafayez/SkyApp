//
//  URLSessionRequestExecuterTests.swift
//  SkyAppTests
//
//  Created by Guest2 on 12/29/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import XCTest
@testable import SkyApp

class URLSessionRequestExecuterTests: XCTestCase {
    var subject: URLSessionRequestExecuter!
    let url = URL(string:"https://reqres.in/api/users?page=2")
    var config = RequestConfig(httpMethod: .get, allHTTPHeaderFields: nil)
    var paramEncoder = JSONParameterEncoder()
    let session = mockURLSession()
    var actualData: Data?
    var actualResponse: URLResponse?
    var actualError: Error?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // Do any additional setup after loading the view, typically from a nib.
        subject = try! URLSessionRequestExecuter(session: session, url: url!, requestConfig: config, parameters: nil, parameterEncoder: paramEncoder, onComplete: { [weak self]data, response in
            self?.actualData = data
            self?.actualResponse = response
        }) { [weak self]error  in
            self?.actualError = error
        }
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // The init with parameters: Parameters?
    func test_init() {
        XCTAssertEqual(subject.session, session)
        XCTAssertEqual(subject.url, url)
        XCTAssertEqual(subject.requestConfig, config)
        XCTAssertNil(subject.parameters)
    }
    // The init with parameters: Data
    
    func test_execute_requestsTheURL() {
        session.nextResponse = HTTPURLResponse(url: url!, statusCode: 300,
                                               httpVersion: nil, headerFields: nil)
        subject.execute()
        XCTAssert(session.lastURL == url)
    }
    
    func test_execute_startsTheRequest() {
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        session.nextResponse = HTTPURLResponse(url: url!, statusCode: 300,
                                               httpVersion: nil, headerFields: nil)
        subject.execute()
        XCTAssertTrue(dataTask.resumeIsCalled)
    }
    
    func test_execute_withResponseData_returnsTheData() {
        let expectedData = "{}".data(using: .utf8)
        session.nextData = expectedData
        session.nextResponse = HTTPURLResponse(url: url!, statusCode: 300,
                                               httpVersion: nil, headerFields: nil)
        subject.execute()
        XCTAssertEqual(actualData, expectedData)
    }
    
    func test_execute_withResponse_returnsTheResponse() {
        let expectedResponse = HTTPURLResponse(url: url!, statusCode: 300,
                                               httpVersion: nil, headerFields: nil)
        session.nextResponse = expectedResponse
        subject.execute()
        XCTAssertEqual(actualResponse, expectedResponse)
    }
    
    
    func test_encodeParameters_JSONEncoding(){
        let parameters: Parameters = [
            "foo": [1,2,3],
            "bar": [
                "baz": "qux"
            ]
        ]
        let url = URL(string:"https://reqres.in/api/users?page=2")
        let config = RequestConfig(httpMethod: .post, allHTTPHeaderFields: nil)
        let paramEncoder = JSONParameterEncoder()
        let session = mockURLSession()
        subject = try! URLSessionRequestExecuter(session: session, url: url!, requestConfig: config, parameters: parameters, parameterEncoder: paramEncoder, onComplete: { _, _ in
            
        }) { _  in
            XCTFail()
        }
        
        XCTAssertEqual(subject.request.httpBody, try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted))
    }
    
    func test_encodeParameters_URLEncoding(){
        let parameters: Parameters = [
            "foo": "foo"
        ]
        let url = URL(string:"https://reqres.in/api")
        let config = RequestConfig(httpMethod: .get, allHTTPHeaderFields: nil)
        let paramEncoder = URLParameterEncoder()
        let session = mockURLSession()
        subject = try! URLSessionRequestExecuter(session: session, url: url!, requestConfig: config, parameters: parameters, parameterEncoder: paramEncoder ,onComplete: { _, _ in
            
        }) { _  in
            XCTFail()
        }
        let desiredURL = URL(string:"https://reqres.in/api?foo=foo")
        XCTAssertEqual(subject.request.url, desiredURL)
    }
    
    
    
    
}

