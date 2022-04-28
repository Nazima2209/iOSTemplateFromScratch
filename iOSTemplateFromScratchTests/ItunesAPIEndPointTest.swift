//
//  ItunesAPIEndpointTest.swift
//  iOSTemplateFromScratchTests
//
//  Created by Apple on 22/04/22.
//

import XCTest
@testable import iOSTemplateFromScratch

class ItunesAPIEndpointTest: XCTestCase {
    
    func test_itunes_correct_endpoint_returns_success() {
        let endpoint = ItunesEndpoint(searchText: "wood")
        XCTAssertEqual(endpoint.scheme, "https")
        XCTAssertEqual(endpoint.method, "get")
        XCTAssertEqual(endpoint.params, [URLQueryItem(name: "term", value: "wood"), URLQueryItem(name: "media", value: "music")])
        XCTAssertEqual(endpoint.baseUrl, "itunes.apple.com")
        XCTAssertEqual(endpoint.path, "/search")
    }
    
    func test_itunes_incorrect_endpoint_returns_failure() {
        let failureEndpoint = ItunesEndpoint(searchText: "wood", testFailure: true)
        let correctEndpoint = ItunesEndpoint(searchText: "wood")
        XCTAssertNotEqual(failureEndpoint, correctEndpoint)
        
    }
}
