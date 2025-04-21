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
    
    func fetchArticleList(page: Int) async throws -> [ArticleList] {
        let fetchedArticles = try await service.fetchArticleListFromNetwork(page: page).toDomain()
        return fetchedArticles
    }
}
