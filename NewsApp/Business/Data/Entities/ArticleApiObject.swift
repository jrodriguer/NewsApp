//
//  ArticleApiObject.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 8/1/24.
//

import Foundation
import SwiftUI

struct ArticleListApiObject: Decodable, Encodable, Equatable {
    let status: String
    let totalResults: Int
    let articles: [ArticleApiObject]
}

struct ArticleApiObject: Identifiable, Codable, Equatable {
    let id: AnyHashable
    
    let author: String?
    let title: String
    let description: String?
    let url: URL
    let urlToImage: URL?
    let publishedAt: Date
    let content: String?
    let source: ArticleSource
    
    private enum CodingKeys: String, CodingKey {
        case author, title, description, url, urlToImage, publishedAt, content, source
    }
        
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        author = try container.decodeIfPresent(String.self, forKey: .author)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        url = try container.decode(URL.self, forKey: .url)
        urlToImage = try container.decodeIfPresent(URL.self, forKey: .urlToImage)
        content = try container.decodeIfPresent(String.self, forKey: .content)
        source = try container.decode(ArticleSource.self, forKey: .source)
        
        do {
            publishedAt = try container.decode(Date.self, forKey: .publishedAt)
        } catch {
            let dateString = try container.decode(String.self, forKey: .publishedAt)
            if let date = DateFormatter.iso8601Full.date(from: dateString) {
                publishedAt = date
            } else {
                throw DecodingError.dataCorruptedError(forKey: .publishedAt, in: container, debugDescription: "Date string does not match format expected by formatter.")
            }
        }
        
        self.id = UUID() as AnyHashable
    }
    
    static func == (lhs: ArticleApiObject, rhs: ArticleApiObject) -> Bool {
        return lhs.id == rhs.id
    }
}

struct ArticleSource: Identifiable, Codable {
    let id: String?
    let name: String
}

extension ArticleApiObject {
    static let mockArticle: ArticleApiObject = {
        let mockArticleData = """
            {
                "author": "John Doe",
                "title": "Mock Article",
                "description": "This is a mock article",
                "url": "https://example.com",
                "urlToImage": "https://example.com/image.jpg",
                "publishedAt": "2022-01-01T00:00:00Z",
                "content": "Mock content for preview purposes",
                "source": {
                    "id": "mock_source_id",
                    "name": "Mock Source"
                }
            }
            """.data(using: .utf8)!
        
        do {
            let decoder = JSONDecoder()
            let mockArticle = try decoder.decode(ArticleApiObject.self, from: mockArticleData)
            return mockArticle
        } catch {
            fatalError("Failed to create mock article: \(error)")
        }
    }()
}

extension ArticleListApiObject {
    static let mockArticleList: ArticleListApiObject = {
        let mockList = ArticleListApiObject(status: "ok", totalResults: 1, articles: [ArticleApiObject.mockArticle])
        return mockList
    }()
}
