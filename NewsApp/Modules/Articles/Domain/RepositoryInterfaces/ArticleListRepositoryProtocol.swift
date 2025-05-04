//
//  ArticleListRepositoryProtocolProtocol.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 2/9/24.
//

import Foundation

protocol ArticleListRepositoryProtocol {
    func fetchArticlesByQuery(query: String) async throws -> [Article]
    func fetchTrendingArticles(page: Int) async throws -> [Article]
}
