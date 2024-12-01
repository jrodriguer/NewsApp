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
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: Date
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
}

extension ArticleDataListDTO {
    func toDomain() -> ArticleDomainListDTO {
        .init(articleId: UUID(),
              source: source.name,
              author: author,
              title: title,
              url: url,
              publishedAt: publishedAt,
              description: description,
              urlToImage: urlToImage,
              content: content)
    }
}

struct Source: Decodable {
    let id: String?
    let name: String
}
