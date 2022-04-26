//
//  ViewModelTestCase.swift
//  iOSTemplateFromScratchTests
//
//  Created by Apple on 26/04/22.
//

import XCTest
@testable import iOSTemplateFromScratch

class ViewModelTestCase: XCTestCase {
    var viewModel: ViewModel!
    fileprivate var itunesService: MockAPIServiceTest!

    override func setUp() {
        super.setUp()
        self.itunesService = MockAPIServiceTest()
        self.viewModel = ViewModel(itunes: itunesService)
    }

    override func tearDown() {
        self.viewModel = nil
        self.itunesService = nil
        super.tearDown()
    }
    
    func test_with_no_service() {
        viewModel.itunesService = nil
        viewModel.callItunesSearchApi(searchText: "test") { result in
            print("No service available")
            XCTAssertFalse(result)
        }
    }
    
    func test_with_itunes_service() {
        viewModel.itunesService = ItunesAPIService()
        let expectations = expectation(description: "test_with_itunes_service")
        viewModel.callItunesSearchApi(searchText: "test") { result in
            print("Fetching data successful...")
            expectations.fulfill()
            XCTAssertTrue(result)
        }
        wait(for: [expectations], timeout: 5.0)
    }
}
