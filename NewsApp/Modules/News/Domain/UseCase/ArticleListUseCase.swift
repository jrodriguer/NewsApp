//
//  ArticleListUseCase.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 2/9/24.
//

import Foundation

protocol ArticleListUseCase {
    func fetchArticleList() async throws -> [ArticleDomainListDTO]
}

final class DefaultArticleListUseCase: ArticleListUseCase {
    
    private let repository: ArticleListRepository
    
    init(repository: ArticleListRepository) {
        self.repository = repository
    }
    
    func fetchArticleList() async throws -> [ArticleDomainListDTO] {
        try await repository.fetchArticleList()
    }
}
