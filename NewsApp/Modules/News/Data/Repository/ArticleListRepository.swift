//
//  ArticleListRepository.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 3/9/24.
//

import Foundation

protocol ArticleListLocalStorage {
    func saveArticlesList(_ articles: [ArticleDomainListDTO])
    func getArticlesList() -> [ArticleDomainListDTO]?
    func removeArticles(articleIDs: [UUID])
}

final class DefaultArticleListRepository: ArticleListRepository {
    
    private let service: ArticleListService
    private let localStorage: ArticleListLocalStorage
    
    init(service: ArticleListService, localStorage: ArticleListLocalStorage) {
        self.service = service
        self.localStorage = localStorage
    }
    
    func fetchArticleList() async throws -> [ArticleDomainListDTO] {
        if let articles = localStorage.getArticlesList() {
            return articles
        } else {
            let fetchedArticles = try await service.fetchArticleListFromNetwork().articles.map{ $0.toDomain() }
            localStorage.saveArticlesList(fetchedArticles)
            return fetchedArticles
        }
    }
}
