//
//  ArticleDataListDTO.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 3/9/24.
//

import Foundation

struct ArticlePageDataListDTO: Decodable {
    let status: String
    let totalResults: Int
    let articles: [ArticleDataListDTO]
}

struct ArticleDataListDTO: Decodable {
    let id: Int
    
    let source: Source
    let title: String
    let url: String
    let publishedAt: Date
    
    let author: String?
    let description: String?
    let urlToImage: String?
    let content: String?
    
    private enum CodingKeys: String, CodingKey {
        case id,
             source,
             title,
             url,
             publishedAt,
             author,
             description,
             urlToImage,
             content
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

extension ArticleDataListDTO {
    static var previewData: [ArticleApiObject] {
        let previewDataURL = Bundle.main.url(forResource: "news", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataURL)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        let apiResponse = try! jsonDecoder.decode(ArticleListApiObject.self, from: data)
        return apiResponse.articles
    }
    
    func toDomain() -> ArticleDomainListDTO {
        .init(id: id, title: title, publishedAt: publishedAt, author: author ?? "")
    }
}

//struct Source: Codable, Equatable {
//    let name: String
//}
