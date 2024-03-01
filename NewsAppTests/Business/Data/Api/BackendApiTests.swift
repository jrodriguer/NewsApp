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
        // TODO: Move the creation of the 'Session' to a separate function.
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let sessionManager = Session(configuration: configuration)
        let apiKey = "978764b3fe6b412f8517a7d9c0a1e140"
        let apiEndpoint = URL(string: "https://newsapi.org/v2/top-headlines/?country=us&apiKey=\(apiKey)")!
        let expectedArticles = MockGenerator.articleListApiObject()
        let requestExpectation = expectation(description: "Request should finish")
                
        let mock = Mock(url: apiEndpoint, contentType: .json, statusCode: 200, data: [.get: MockGenerator.mockedData(for: expectedArticles)])
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
