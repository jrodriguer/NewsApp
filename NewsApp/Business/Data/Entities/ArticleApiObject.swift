//
//  ArticleApiObject.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 8/1/24.
//

import Foundation
import SwiftUI

struct ArticleListApiObject<T: Codable>: Codable {
    var status: String
    var totalResults: Int
    var articles: [T]
}

struct ArticleApiObject: Codable, Identifiable {
    var id = UUID()
    
    var author: String?
    var title: String
    var description: String?
    var url: URL
    var urlToImage: URL?
    var publishedAt: Date
    var content: String?
    
    var source: ArticleSource
    
    struct ArticleSource: Codable {
        var id: String?
        var name: String
    }
    
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
        
        let dateString = try container.decode(String.self, forKey: .publishedAt)
        if let date = DateFormatter.iso8601Full.date(from: dateString) {
            publishedAt = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .publishedAt, in: container, debugDescription: "Date string does not match format expected by formatter.")
        }
    }
}
