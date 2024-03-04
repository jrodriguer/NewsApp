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
    static func articleListApiObject() -> ArticleListApiObject {
        do {
            if let path = Bundle.main.path(forResource: "get_articles", ofType: "json") {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let jsonData = try JSONDecoder().decode(ArticleListApiObject.self, from: data)
                return jsonData
            } else {
                // FIXME: If not found file.
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
                
                let jsonData = try JSONDecoder().decode(ArticleListApiObject.self, from: articles)
                return jsonData
            }
        } catch {
            fatalError("Failed to load 'get_articles' JSON file for testing.")
        }
    }
    
    static func characterListApiObject() -> CharacterListApiObject {
        guard let path = Bundle.main.path(forResource: "get_characters", ofType: "json"),
              let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError("Failed to load 'get_characters' JSON file for testing.")
        }
        return try! JSONDecoder().decode(CharacterListApiObject.self, from: jsonData)
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
