//
//  ArticleApiObject.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 8/1/24.
//

import Foundation
import SwiftUI

struct ArticleApiObject: Codable, Equatable, Identifiable {
    let id: UUID
    
    let source: Source
    let title: String
    let url: String
    let publishedAt: Date
    
    let author: String?
    let description: String?
    let urlToImage: String?
    let content: String?
    
    private enum CodingKeys: String, CodingKey {
        case source,
             title,
             url,
             publishedAt,
             author,
             description,
             urlToImage,
             content
    }
        
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = UUID()
        
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
    
    var authorText: String {
        "‧ \(author ?? "Not author")"
    }
    
    var descriptionText: String {
        description ?? ""
    }

    var link: URL {
        URL(string: url)!
    }
    
    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage)
    }
}

extension ArticleApiObject {
    static var previewData: [ArticleApiObject] {
        let previewDataURL = Bundle.main.url(forResource: "news", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataURL)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        let apiResponse = try! jsonDecoder.decode(ArticleListApiObject.self, from: data)
        return apiResponse.articles
    }
}

struct Source: Codable, Equatable {
    let name: String
}
