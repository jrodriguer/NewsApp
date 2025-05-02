//
//  ArticleListLocal.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 2/5/25.
//

import Foundation

struct ArticleListLocal: Codable {
    let articleId: UUID
    let totalResults: Int
    let source: String
    let author: String?
    let title: String
    let description: String?
    let url: String
    let publishedAt: Date
    let content: String?
    let urlToImage: String?
    
    func toDomain() -> ArticleList {
        return ArticleList(
            articleId: articleId,
            totalResults: totalResults,
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
    
    static func fromDomain(_ domain: ArticleList) -> ArticleListLocal {
        return ArticleListLocal(
            articleId: domain.articleId,
            totalResults: domain.totalResults,
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
