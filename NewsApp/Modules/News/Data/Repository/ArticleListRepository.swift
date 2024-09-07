//
//  ArticleListRepository.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 3/9/24.
//

import Foundation

final class DefaultArticleListRepository: ArticleListRepository {
    
    private let service: ArticleListService
    
    init(service: ArticleListService) {
        self.service = service
    }
    
    func fetchTopHeadlines() async throws -> [ArticleDomainListDTO] {
//        try await service.fetchArticleListFromNetwork().articles.map { 0$.toDomain() }
    }
    
    func search(query: String) async throws -> [ArticleDomainListDTO] {
//        <#code#>
    }
}
