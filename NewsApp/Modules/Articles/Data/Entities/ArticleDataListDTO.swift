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

extension ArticlePageDataListDTO {
    func toDomain() -> [ArticleDomainListDTO] {
        articles.map { article in
            ArticleDomainListDTO(
                articleId: UUID(),
                totalResults: totalResults,
                source: article.source.name,
                author: article.author,
                title: article.title,
                description: article.description,
                url: article.url,
                publishedAt: article.publishedAt,
                content: article.content,
                urlToImage: article.urlToImage
            )
        }
    }
}

struct Source: Decodable {
    let id: String?
    let name: String
}
