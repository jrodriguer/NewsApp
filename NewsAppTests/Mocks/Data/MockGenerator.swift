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
    static func articleListApiObject() -> ArticleListApiObject? {
        if let url = Bundle.main.url(forResource: "get_articles", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ArticleListApiObject.self, from: data)
                return jsonData
            } catch {
                fatalError("Failed to load 'get_articles' JSON file for testing.")
            }
        }
        return nil
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
