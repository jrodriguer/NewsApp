//
//  CategoryArticles.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 5/5/24.
//

import Foundation

struct CategoryArticles: Codable {
    let category: Category
    let articles: [ArticleApiObject]
}
