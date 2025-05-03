//
//  ArticleResponseDTO.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 3/9/24.
//

import Foundation

struct ArticleResponseDTO: Decodable {
    let status: String
    let totalResults: Int
    let articles: [ArticleDTO]
    
    struct ArticleDTO: Decodable {
        let source: SourceDTO
        let author: String?
        let title: String
        let description: String?
        let url: String
        let urlToImage: String?
        let publishedAt: Date
        let content: String?
        
        struct SourceDTO: Decodable {
            let id: String?
            let name: String
        }
    }
    
    func toDomain() -> [Article] {
        articles.map { article in
            Article(
                id: UUID(),
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
