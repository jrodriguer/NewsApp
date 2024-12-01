//
//  ArticleDomainListDTO.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 2/9/24.
//

import Foundation

struct ArticleDomainListDTO {
    let articleId: UUID
    let source: String
    let author: String
    let title: String
    let url: String
    let publishedAt: Date
    let description: String?
    let urlToImage: String?
    let content: String?
}
