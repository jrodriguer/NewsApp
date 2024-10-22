//
//  ArticleListItemViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 21/10/24.
//

import Foundation

struct ArticleListItemViewModel: Hashable {
    let id: UUID
    let title: String?
    let link: String
    let publishedAt: String
    let author: String?
    let description: String?
    let image: String?
}
