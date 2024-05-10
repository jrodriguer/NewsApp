//
//  ArticleApiObject.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 8/1/24.
//

import Foundation

fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

struct ArticleListApiObject {
    let status: String
    let totalResults: Int
    let articles: [ArticleApiObject]
}

extension ArticleListApiObject: Decodable { }
extension ArticleListApiObject: Encodable { }
extension ArticleListApiObject: Equatable { }

struct ArticleApiObject {
    let id: UUID
    
    let author: String?
    let title: String
    let description: String?
    
    let url: URL
    let urlToImage: URL?
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = UUID()
        
        author = try container.decodeIfPresent(String.self, forKey: .author)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        url = try container.decode(URL.self, forKey: .url)
        urlToImage = try container.decodeIfPresent(URL.self, forKey: .urlToImage)
        content = try container.decodeIfPresent(String.self, forKey: .content)
        source = try container.decode(Source.self, forKey: .source)
        
        do {
            publishedAt = try container.decode(Date.self, forKey: .publishedAt)
        } catch {
            let dateString = try container.decode(String.self, forKey: .publishedAt)
            let dateFormatter = ISO8601DateFormatter()
            if let date = dateFormatter.date(from: dateString) {
                publishedAt = date
            } else {
                throw DecodingError.dataCorruptedError(forKey: .publishedAt, in: container, debugDescription: "Date string does not match format expected by formatter.")
            }
        }
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
        url
    }
    
    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return urlToImage
    }
}

extension ArticleApiObject: Codable { }
extension ArticleApiObject: Equatable { }
extension ArticleApiObject: Identifiable { }

extension ArticleApiObject {
    static var previewData: [ArticleApiObject] {
        let previewDataURL = Bundle.main.url(forResource: "news", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataURL)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        let apiResponse = try! jsonDecoder.decode(ArticleListApiObject.self, from: data)
        return apiResponse.articles
    }
    
    static var previewCategoryArticles: [CategoryArticles] {
        let articles = previewData
        return Category.allCases.map {
            .init(category: $0, articles: articles.shuffled())
        }
    }
}

struct Source {
    let name: String
}

extension Source: Codable {}
extension Source: Equatable {}
