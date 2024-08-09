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
        continueAfterFailure = false
        app = XCUIApplication()
//        app.launchArguments.append("-ui-test")
//        app.launchEnvironment["-ui-test-apiURL"] = "https://newsapi.org/v2"
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func testTabBarComponents() throws {
        let snapshot = try app.snapshot()
        let newsButton = app.buttons["NewsButton"]
        let favoritesButton = app.buttons["FavoritesButton"]
        
        XCTAssertTrue(newsButton.exists, "The News button should exist")
        XCTAssertTrue(favoritesButton.exists, "The Favorites button should exist")
        
        newsButton.tap()
        XCTAssertTrue(app.staticTexts["News"].exists, "The News view should be displayed")
        favoritesButton.tap()
        XCTAssertTrue(app.staticTexts["Favorites"].exists, "The Favorites view should be displayed")
    }
    
//    func testPlaceFavorite() throws {
//        /*
//         Step 1 -> Access the list of articles.
//         Step 2 -> We tap on "Add favorite" button.
//         Step 3 -> Tap the "Add to Favorites" button.
//         Step 4 -> Verify that the article is added to the favorites.
//         */
//        
//        // Step 1
//        let articleView = app.otherElements["ArticleView"]
//        print(app.debugDescription)
//        XCTAssertTrue(articleView.waitForExistence(timeout: 10), "The article view should be exist")
//
//        // Step 2
//        let articleCard = app.scrollViews.otherElements["ArticleCardView_0"]
//        XCTAssertTrue(articleCard.waitForExistence(timeout: 10), "The card article should be exist")
//        articleCard.tap()
//        
//        // Step 3
//        let addToFavoritesButton = app.buttons["FavoritesButton"]
//        XCTAssertTrue(addToFavoritesButton.waitForExistence(timeout: 10), "The button 'Add to Favorites' should be exist")
//        addToFavoritesButton.tap()
//        
//        // Step 4
//        app.buttons["FavoritesButton"].tap()
//        let favoritedArticle = app.scrollViews.otherElements["ArticleCardView_0"]
//        XCTAssertTrue(favoritedArticle.waitForExistence(timeout: 10), "The article should be into Favorites")
//    }
}
