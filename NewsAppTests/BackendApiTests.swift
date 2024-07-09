//
//  BackendApiTests.swift
//  NewsAppTests
//
//  Created by Julio Rodriguez on 28/2/24.
//

import Foundation
import Mocker
import Alamofire
import XCTest

@testable import NewsApp
class BackendApiTests: XCTestCase {
    
    var setup: MockDependencies!
    var vm: ArticlesViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        setup = MockDependencies()
        vm = ArticlesViewModel()
    }
    
    override func tearDownWithError() throws {
        setup = nil
        vm = nil
        try super.tearDownWithError()
    }
    
    func testArticlesViewModel_service_shouldBeInjectedAndNotBeNil() {
        XCTAssertNotNil(vm.backendApi)
    }
    
    func testArticleListApiObject_ShouldReturnExpectedArticlesList() {
        let sessionManager = MockGenerator.createMockSessionManager()
        let apiKey = "978764b3fe6b412f8517a7d9c0a1e140"
        let apiEndpoint = URL(string: "https://newsapi.org/v2/top-headlines/?country=us&apiKey=\(apiKey)")!
        let expectedArticlesList = MockGenerator.articleListApiObject()
        let requestExpectation = self.expectation(description: "Request should finish")
        let mock = Mock(url: apiEndpoint, contentType: .json, statusCode: 200, data: [.get: MockGenerator.mockedData(for: expectedArticlesList)])
        mock.register()
        
        sessionManager
                .request(apiEndpoint)
                .responseDecodable(of: ArticleListApiObject.self) { (response) in
                    XCTAssertNil(response.error)
                    requestExpectation.fulfill()
                }.resume()

        wait(for: [requestExpectation], timeout: 10.0)
    }
}
