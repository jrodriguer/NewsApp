//
//  ArticleList.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 2/9/24.
//

import Foundation

struct ArticleList {
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
}
