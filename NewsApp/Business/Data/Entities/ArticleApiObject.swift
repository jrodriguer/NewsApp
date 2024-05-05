//
//  ArticleApiObject.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 8/1/24.
//

import Foundation

fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

struct ArticleListApiObject: Decodable, Encodable, Equatable {
    let status: String
    let totalResults: Int
    let articles: [ArticleApiObject]
}

struct ArticleApiObject {
    let id: UUID
    
    let author: String?
    let title: String
    let description: String?
    
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    let content: String?
    
    let source: Source
    
    private enum CodingKeys: String, CodingKey {
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
        case source
    }
    
    var authorField: String {
        author ?? ""
    }
    
    var descriptionField: String {
        description ?? ""
    }
    
    var captionField: String {
        "\(source.name) ‧ \(relativeDateFormatter.localizedString(for: publishedAt, relativeTo: Date()))"
    }
    
    var articleURL: URL {
        URL(string: url)!
    }
    
    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage)
    }
}

extension ArticleApiObject: Codable { }
extension ArticleApiObject: Equatable { }
extension ArticleApiObject: Identifiable { }

extension ArticleApiObject {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = UUID()
        
        author = try container.decodeIfPresent(String.self, forKey: .author)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        url = try container.decode(String.self, forKey: .url)
        urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage)
        content = try container.decodeIfPresent(String.self, forKey: .content)
        source = try container.decode(Source.self, forKey: .source)
        
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
    }
}

struct Source {
    let name: String
}

extension Source: Codable {}
extension Source: Equatable {}

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
