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
    func test_BackendApiTests_article_shouldReturnExpectedArticle() {
        let sessionManager = MockGenerator.createMockSessionManager()
        
        let apiKey = "978764b3fe6b412f8517a7d9c0a1e140"
        let apiEndpoint = URL(string: "https://newsapi.org/v2/top-headlines/?country=us&apiKey=\(apiKey)")!
        
        let expectedArticlesList = MockGenerator.articleListApiObject()
        let requestExpectation = expectation(description: "Request should finish")
                
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
    
    func test_BackendApiTests_character_shouldReturnExpectedCharacter() {
        let sessionManager = MockGenerator.createMockSessionManager()
        
        let apiEndpoint = URL(string: "https://rickandmortyapi.com/api/character")!
        let expectedCharacters = MockGenerator.characterListApiObject()
        let requestExpectation = expectation(description: "Request should finish")
                
        let mock = Mock(url: apiEndpoint, contentType: .json, statusCode: 200, data: [.get: MockGenerator.mockedData(for: expectedCharacters)])
        mock.register()
        
        sessionManager
                .request(apiEndpoint)
                .responseDecodable(of: CharacterListApiObject.self) { (response) in
                    XCTAssertNil(response.error)
                    requestExpectation.fulfill()
                }.resume()

            wait(for: [requestExpectation], timeout: 10.0)
    }
}
