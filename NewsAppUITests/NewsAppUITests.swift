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
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func testTabBarComponents() throws {
        let newsButton = app.buttons["NewsButton"]
        let favoritesButton = app.buttons["FavoritesButton"]
        
        XCTAssertTrue(newsButton.exists, "The News button should exist")
        XCTAssertTrue(favoritesButton.exists, "The Favorites button should exist")
        
        newsButton.tap()
        XCTAssertTrue(app.staticTexts["News"].exists, "The News view should be displayed")
        favoritesButton.tap()
        XCTAssertTrue(app.staticTexts["Favorites"].exists, "The Favorites view should be displayed")
    }
    
    func testPlaceFavorite() throws {
        /*
         Step 1 -> Access the list of articles.
         Step 2 -> We tap on "Add favorite" button.
         Step 3 -> Tap the "Add to Favorites" button.
         Step 4 -> Verify that the article is added to the favorites.
         */
        
        // Step 1
        let articleView = app.otherElements["ArticleView"]
        XCTAssertTrue(articleView.waitForExistence(timeout: 10), "The article view should exist")
        
        // Step 2
        let articleCard = app.scrollViews.otherElements.containing(.any, identifier: "ArticleCardView_0").element
        XCTAssertTrue(articleCard.waitForExistence(timeout: 10), "The article card should exist")
        articleCard.tap()
        
        // Step 3
        let addToFavoritesButton = app.buttons["FavoritesButton"]
        XCTAssertTrue(addToFavoritesButton.waitForExistence(timeout: 10), "The 'Add to Favorites' button should exist")
        addToFavoritesButton.tap()
        
        // Step 4
        app.buttons["FavoritesButton"].tap()
        let favoritedArticle = app.scrollViews.otherElements.containing(.any, identifier: "ArticleCardView_0").element
        XCTAssertTrue(favoritedArticle.waitForExistence(timeout: 10), "The article should be in Favorites")
    }
}
