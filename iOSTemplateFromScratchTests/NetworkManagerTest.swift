//
//  NetworkManagerTest.swift
//  iOSTemplateFromScratchTests
//
//  Created by Apple on 22/04/22.
//

import XCTest
@testable import iOSTemplateFromScratch

class NetworkManagerTest: XCTestCase {

    func test_valid_itunes_request_API_call_returns_success() {
        let endpoint = ItunesEndpoint(searchText: "us")
        let expectations = expectation(description: "valid_request_API_call_returns_success")
        NetworkManager.callAPI(endpoint: endpoint) { result in
            switch result {
                case .success(let response):
                    XCTAssertNotNil(response)
                case .failure(let error):
                    XCTAssertNil(error)
            }
            expectations.fulfill()
        }
        wait(for: [expectations], timeout: 5)
    }
    
    func test_invalid_itunes_request_API_call_returns_failure(){
        let endpoint = ItunesEndpoint(searchText: "fail", testFailure: true)
        let expectations = expectation(description: "invalid_request_API_call_returns_failure")
        NetworkManager.callAPI(endpoint: endpoint) { result in
            switch result {
                case .failure(let error):
                    XCTAssertNotNil(error)
                case .success(let response):
                    XCTAssertNil(response)
            }
            expectations.fulfill()
        }
        wait(for: [expectations], timeout: 5.0)
    }
}
