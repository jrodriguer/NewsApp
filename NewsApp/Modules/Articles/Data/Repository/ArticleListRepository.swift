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
    
    func fetchArticleList(itemsPerPage: Int, page: Int) async throws -> [ArticleDomainListDTO] {
        let fetchedArticles = try await service.fetchArticleListFromNetwork(itemsPerPage: itemsPerPage, page: page).articles.map{ $0.toDomain() }
        return fetchedArticles
    }
}
