//
//  ArticleListItemViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 21/10/24.
//

import Foundation

struct ArticleListItemViewModel: Hashable {
    let id: UUID
    let source: String
    let author: String
    let title: String
    let link: URL
    let publishedAt: String
    let description: String?
    let image: URL?
    
    init(
        id: UUID,
        source: String,
        author: String,
        title: String,
        link: URL,
        publishedAt: String,
        description: String,
        image: URL? = nil
    ) {
        self.id = id
        self.source = source
        self.author = author
        self.title = title
        self.link = link
        self.publishedAt = publishedAt
        self.description = description
        self.image = image
    }
}
