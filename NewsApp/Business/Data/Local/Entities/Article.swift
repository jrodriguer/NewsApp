//
//  Article.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 29/5/24.
//

import Foundation

struct Article: Identifiable {
    let id: UUID
    
    let author: String
    let title: String
    let description: String
    let url: URL
    let urlToImage: URL
    let publishedAt: Date
    let content: String
    let source: ArticleSource
    
    static func build(apiObject: ArticleApiObject) -> Article? {
        guard let image = apiObject.urlToImage else { return nil }
        
        return Article(id: apiObject.id,
                       author: apiObject.author ?? "",
                       title: apiObject.title,
                       description: apiObject.description ?? "",
                       url: apiObject.url,
                       urlToImage: image,
                       publishedAt: apiObject.publishedAt,
                       content: apiObject.content ?? "",
                       source: apiObject.source
        )
    }
}
