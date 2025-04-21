//
//  ArticleListUseCase.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 2/9/24.
//

import Foundation

protocol ArticleListUseCase {
    func fetchArticleList(page: Int) async throws -> [ArticleList]
}

final class DefaultArticleListUseCase: ArticleListUseCase {
    
    private let repository: ArticleListRepository
    
    init(repository: ArticleListRepository) {
        self.repository = repository
    }
    
    func fetchArticleList(page: Int) async throws -> [ArticleList] {
        try await repository.fetchArticleList(page: page)
    }
}
