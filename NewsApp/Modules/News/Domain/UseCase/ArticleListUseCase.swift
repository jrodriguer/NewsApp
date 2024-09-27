//
//  ArticleListUseCase.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 2/9/24.
//

import Foundation

protocol ArticleListUseCase {
    func fetchNewList() async throws -> [ArticleDomainListDTO]
}

final class DefaultArticleListUseCase: ArticleListUseCase {
    
    private let repository: ArticleListRepository
    
    init(repository: ArticleListRepository) {
        self.repository = repository
    }
    
    func fetchNewList() async throws -> [ArticleDomainListDTO] {
        try await repository.fetchArticleList()
    }
}
