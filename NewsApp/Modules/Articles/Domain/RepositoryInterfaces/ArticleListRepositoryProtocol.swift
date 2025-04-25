//
//  ArticleListRepositoryProtocol.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 2/9/24.
//

import Foundation

protocol ArticleListRepository {
    func fetchArticlesByQuery(query: String) async throws -> [ArticleList]
    func fetchTrendingArticles(page: Int) async throws -> [ArticleList]
}
