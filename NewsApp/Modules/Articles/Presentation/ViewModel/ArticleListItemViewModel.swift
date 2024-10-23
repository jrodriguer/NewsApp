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
}
