//
//  ArticleListUseCase.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 2/9/24.
//

import Foundation

protocol ArticleListUseCase {
    func fetchArticleList(page: Int) async throws -> [ArticleDomainListDTO]
    func reset() async
}

final class DefaultArticleListUseCase: ArticleListUseCase {
    
    private let repository: ArticleListRepository
    private let pagingData = PagingData(itemsPerPage: 10, maxPageLimit: 5)
    
    init(repository: ArticleListRepository) {
        self.repository = repository
    }
    
    func fetchArticleList(page: Int) async throws -> [ArticleDomainListDTO] {
        try await repository.fetchArticleList(page: page)
    }
    
    func reset() async {
        await pagingData.reset()
    }
}
