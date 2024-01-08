//
//  Article.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 8/1/24.
//

import Foundation

struct Article: Decodable, Identifiable {
    var id = UUID()
    let source: ArticleSource
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

struct ArticleSource: Decodable {
    let id: String?
    let name: String
}

struct TopHeadlines: Decodable {
    let articles: [Article]
}
