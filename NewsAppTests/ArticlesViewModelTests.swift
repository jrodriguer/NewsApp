//
//  ArticlesViewModelTests.swift
//  NewsAppTests
//
//  Created by Julio Rodriguez on 2/3/24.
//

import Foundation
import XCTest
import Mocker

@testable import NewsApp
class ArticlesViewModel_Tests: XCTestCase {
    var setup = MockDependencies()
    var vm = ArticlesViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vm = ArticlesViewModel()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testIsLoading_ShouldBeTrue() {
        XCTAssertTrue(vm.isLoading)
    }
    
    func testLoadArticles_SuccessfulResponse_ShouldUpdateArticles() {
        let apiKey = "978764b3fe6b412f8517a7d9c0a1e140"
        let apiEndpoint = URL(string: "https://newsapi.org/v2/top-headlines/?country=us&apiKey=\(apiKey)")!
        let expectedArticlesList = MockGenerator.articleListApiObject()
        let mock = Mock(url: apiEndpoint, contentType: .json, statusCode: 200, data: [.get: MockGenerator.mockedData(for: expectedArticlesList)])
        mock.register()
        
        vm.loadArticles()
        
        XCTAssertTrue(vm.isLoading)
        
        let requestExpectation = XCTestExpectation(description: "Loading articles")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Check that the isLoading property has been reset to false after the simulated loading time
            XCTAssertFalse(self.vm.isLoading)
                        
            // Meets the expectation.
            requestExpectation.fulfill()
        }
        wait(for: [requestExpectation], timeout: 2.0)
        
        XCTAssertNotNil(self.vm.articles)
    }
    
    func testLoadArticles_FailureResponse_ShouldNotUpdateArticles() {
        let apiKey = "apikey"
        let apiEndpoint = URL(string: "https://newsapi.org/v2/top-headlines/?country=us&apiKey=\(apiKey)")!
        let mock = Mock(url: apiEndpoint, contentType: .json, statusCode: 500, data: [.get: Data()])
        mock.register()

        vm.loadArticles()
        
        XCTAssertTrue(vm.isLoading)
        
        let requestExpectation = expectation(description: "Loading articles")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Check that the isLoading property has been reset to false after the simulated loading time
            XCTAssertFalse(self.vm.isLoading)
            
            // Check that the properties of items has not been updated correctly.
            XCTAssertTrue(self.vm.articles.isEmpty)
            
            // Meets the expectation.
            requestExpectation.fulfill()
        }
        wait(for: [requestExpectation], timeout: 2.0)
    }
}
