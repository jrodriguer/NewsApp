//
//  Article.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 8/1/24.
//

import Foundation
import SwiftUI

struct Article: Codable {
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
        case source, author, title, description, url, urlToImage, publishedAt, content
    }
    
    init(from decoder: Decoder) throws {
        var container = try decoder.container(keyedBy: CodingKeys.self)
        
        source = try container.decode(ArticleSource.self, forKey: .source)
        author = try container.decodeIfPresent(String.self, forKey: .author)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        url = try container.decode(URL.self, forKey: .url)
        urlToImage = try container.decodeIfPresent(URL.self, forKey: .urlToImage)
        content = try container.decodeIfPresent(String.self, forKey: .content)
        
        // Decode publishedAt using custom strategy (String to Date)
        var dateString = try container.decode(String.self, forKey: .publishedAt)
        if var date = DateFormatter.iso8601Full.date(from: dateString) {
            publishedAt = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .publishedAt, in: container, debugDescription: "Date string does not match format expected by formatter.")
        }
    }
}

extension DateFormatter {
    static var iso8601Full: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

struct TopHeadlines: Codable {
    var articles: [Article]
}
