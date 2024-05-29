//
//  MockGenerator.swift
//  NewsAppTests
//
//  Created by Julio Rodriguez on 1/3/24.
//

import Foundation
import Alamofire
import Mocker

@testable import NewsApp

struct MockGenerator {
    static func loadJsonFile(name: String, type: String) -> Data? {
        guard let filePath: String = Bundle.main.path(forResource: name, ofType: type) else {
            return nil
        }
        return try? Data(contentsOf: URL(fileURLWithPath: filePath))
    }
    
    static func articleListApiObject() -> ArticleListApiObject {
        if let data = loadJsonFile(name: "news", type: "json") {
            return decodeJson(data: data)
        } else {
            let news = """
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
            return decodeJson(data: news)
        }
    }
    
    static func decodeJson(data: Data) -> ArticleListApiObject {
        do {
            return try JSONDecoder().decode(ArticleListApiObject.self, from: data)
        } catch {
            fatalError("Failed to decode JSON data: \(error.localizedDescription)")
        }
    }
    
    static func createMockSessionManager() -> Session {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        return Session(configuration: configuration)
    }
    
    static func mockedData<T: Encodable>(for object: T) -> Data {
        return try! JSONEncoder().encode(object)
    }
}
