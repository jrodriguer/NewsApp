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
    
    func testGetArticles() {
        // Mocking Alamofire data requests.
        let configuration = URLSessionConfiguration.af.default
        
        // Register MockingURLProtocol with Alamofire manager.
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let sessionManager = Session(configuration: configuration)
        
        let apiKey = "978764b3fe6b412f8517a7d9c0a1e140"
        let apiEndpoint = URL(string: "https://newsapi.org/v2/top-headlines/?country=us&apiKey=\(apiKey)")!
        
        let articles = """
                {
                    "status": "ok",
                    "totalResults": 33,
                    "articles": [
                        {
                            "source": {
                                "id": "cnn",
                                "name": "CNN"
                            },
                            "author": "By Elise Hammond, Piper Hudspeth Blackburn and Maureen Chowdhury, CNN",
                            "title": "Live updates: Michigan presidential primary election - CNN",
                            "description": "Michigan voters are headed to the polls Tuesday for the state's presidential primaries. Follow here for the latest live news updates, results, analysis and more.",
                            "url": "https://www.cnn.com/politics/live-news/michigan-primary-02-27-24/index.html",
                            "urlToImage": "https://cdn.cnn.com/cnnnext/dam/assets/240226163121-01-early-voting-michigan-021724-super-tease.jpg",
                            "publishedAt": "2024-02-27T18:23:00Z",
                            "content": "President Joe Biden and former President Donald Trump are expected to win handily in their respective contests, but there will be lessons to learn for both. Here's what to watch for in Michigan: [1547 chars]"
                        }
                    ]
                }
        """.data(using: .utf8)!
        
        let expectedArticles = try! JSONDecoder().decode(ArticleListApiObject.self, from: articles)
        let requestExpectation = expectation(description: "Request should finish")
        
        // Registering a Mock.
        let mockedData = try! JSONEncoder().encode(expectedArticles)
        let mock = Mock(url: apiEndpoint, contentType: .json, statusCode: 200, data: [.get: mockedData])
        mock.register()
        
        sessionManager
                .request(apiEndpoint)
                .responseDecodable(of: ArticleListApiObject.self) { (response) in
                    XCTAssertNil(response.error)
//                    XCTAssertEqual(response.value, expectedArticles)
                    requestExpectation.fulfill()
                }.resume()

            wait(for: [requestExpectation], timeout: 10.0)
    }
}
