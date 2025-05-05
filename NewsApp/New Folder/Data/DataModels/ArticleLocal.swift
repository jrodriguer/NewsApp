//
//  ArticleLocal.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 2/5/25.
//

import Foundation

struct ArticleLocal: Codable {
    let id: UUID
    let source: String
    let author: String?
    let title: String
    let description: String?
    let url: String
    let publishedAt: Date
    let content: String?
    let urlToImage: String?
    
    func toDomain() -> Article {
        return Article(
            id: id,
            source: source,
            author: author,
            title: title,
            description: description,
            url: url,
            publishedAt: publishedAt,
            content: content,
            urlToImage: urlToImage
        )
    }
    
    static func fromDomain(_ domain: Article) -> ArticleLocal {
        return ArticleLocal(
            id: domain.id,
            source: domain.source,
            author: domain.author,
            title: domain.title,
            description: domain.description,
            url: domain.url,
            publishedAt: domain.publishedAt,
            content: domain.content,
            urlToImage: domain.urlToImage
        )
    }
}
