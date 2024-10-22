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
    let articleId: UUID
    let source: Source
    let title: String
    let url: URL
    let publishedAt: Date
    let author: String?
    let description: String?
    let urlToImage: URL?
    let content: String?
    private enum CodingKeys: String, CodingKey {
        case articleId,
             source,
             title,
             url,
             publishedAt,
             author,
             description,
             urlToImage,
             content
    }
}

extension ArticleDataListDTO {
    
    func toDomain() -> ArticleDomainListDTO {
        .init(articleId: UUID(),
              title: title,
              url: url,
              publishedAt: publishedAt,
              author: author,
              description: description,
              urlToImage: urlToImage,
              content: content)
    }
}

struct Source: Codable, Equatable {
    let name: String
}
