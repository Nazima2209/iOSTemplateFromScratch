//
//  iOSTemplateFromScratchUITests.swift
//  iOSTemplateFromScratchUITests
//
//  Created by Apple on 19/04/22.
//

import XCTest

class iOSTemplateFromScratchUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testIfCorrectResultForSearch() {
        let app = XCUIApplication()
        app.launch()
        let resultsTable = app.tables.firstMatch
        resultsTable.swipeDown()
        let searchField = app.searchFields.firstMatch
        searchField.tap()
        searchField.typeText("wood")
        print(resultsTable.cells.count)
        XCTAssert(resultsTable.cells.count > 3)
    }
    
    func testForIfSearchResultEmpty() {
        let app = XCUIApplication()
        app.launch()
        let resultsTable = app.tables.firstMatch
        resultsTable.swipeDown()
        let searchField = app.searchFields.firstMatch
        searchField.tap()
        searchField.typeText("xiohfcfcgg")
        XCTAssertEqual(resultsTable.cells.count, 1)
        XCTAssert(app.staticTexts["You haven't searched anything yet"].exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
