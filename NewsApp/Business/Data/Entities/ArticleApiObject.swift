//
//  ArticleApiObject.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 8/1/24.
//

import Foundation
import SwiftUI

struct ArticleApiObject: Identifiable, Codable {
    let id = UUID()
    
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
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
        url = try container.decode(String.self, forKey: .url)
        urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage)
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
    }
    
    var authorText: String {
        author ?? ""
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

struct ArticleSource: Codable {
    let name: String
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
