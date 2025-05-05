//
//  ArticleListUseCase.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 2/9/24.
//

import Foundation

protocol ArticleListUseCase {
    func fetchArticleList(page: Int) async throws -> [Article]
}

final class DefaultArticleListUseCase: ArticleListUseCase {
    private let repository: ArticleListRepositoryProtocol
    
    init(repository: ArticleListRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchArticleList(page: Int) async throws -> [Article] {
        try await repository.fetchTrendingArticles(page: page)
    }
}
