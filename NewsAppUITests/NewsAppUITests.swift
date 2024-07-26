//
//  NewsAppUITests.swift
//  NewsAppUITests
//
//  Created by Julio Rodriguez on 7/1/24.
//

import XCTest

final class NewsAppUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testTabBarComponents() {
        let newsButton = app.buttons["NewsButton"]
        let favoritesButton = app.buttons["FavoritesButton"]
        
        XCTAssertTrue(newsButton.exists, "The News button should exist")
        XCTAssertTrue(favoritesButton.exists, "The Favorites button should exist")
        
        newsButton.tap()
        XCTAssertTrue(app.staticTexts["News"].exists, "The News view should be displayed")
        favoritesButton.tap()
        XCTAssertTrue(app.staticTexts["Favorites"].exists, "The Favorites view should be displayed")
    }
}
