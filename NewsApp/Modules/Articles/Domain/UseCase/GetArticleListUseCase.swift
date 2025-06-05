//
//  GetArticleUseCase.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 2/9/24.
//

import Foundation

final class GetArticleUseCase {
    private let repository: ArticleListRepositoryProtocol
    
    init(repository: ArticleListRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchArticles(page: Int) async throws -> [Article] {
        try await repository.fetchTrendingArticles(page: page)
    }
}
