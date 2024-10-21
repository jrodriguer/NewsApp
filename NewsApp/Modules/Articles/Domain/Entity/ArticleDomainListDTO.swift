//
//  ArticleDomainListDTO.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 2/9/24.
//

import Foundation

struct ArticleDomainListDTO {
    let articleId: UUID
    let title: String
    let url: String
    let publishedAt: Date
    let author: String?
    let description: String?
    let urlToImage: String?
    let content: String?
}
