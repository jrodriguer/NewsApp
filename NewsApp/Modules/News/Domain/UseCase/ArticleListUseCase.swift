//
//  ArticleListUseCase.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 2/9/24.
//

import Foundation

protocol ArticleListUseCase {
    func fetchNewList() async throws -> [ArticleDomainListDTO]
    func searchNewList(searched: String) async throws -> [ArticleDomainListDTO]
}

final class DefaultArticleListUseCase: ArticleListUseCase {
    
    private let repository: NewListRepository
    
    init(repository: NewListRepository) {
        self.repository = repository
    }
    
    func fetchNewList() async throws -> [ArticleDomainListDTO] {
        try await repository.fetchTopHeadlines()
    }
    
    func searchNewList(searched: String) async throws -> [ArticleDomainListDTO] {
        try await repository.search(query: searched)
    }
}
