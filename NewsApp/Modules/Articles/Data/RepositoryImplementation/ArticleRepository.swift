//
//  ArticleRepository.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 3/9/24.
//

import Foundation

class ArticleRepository: ArticleListRepositoryProtocol {
    private let remoteDataSource: ArticleRemoteDataSource
    private let localDataSource: ArticleLocalDataSource
    
    init(remoteDataSource: ArticleRemoteDataSource, localDataSource: ArticleLocalDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func fetchArticlesByQuery(query: String) async throws -> [Article] {
        let articleDTO = try await remoteDataSource.fetchArticlesByQuery(query)
        return articleDTO.toDomain()
    }
    
    func fetchTrendingArticles(page: Int) async throws -> [Article] {
        let articleDTO = try await remoteDataSource.fetchTrendingArticles(page: page)
        return articleDTO.toDomain()
    }
    
    func getCachedArticle(forArticle article: String) async throws -> Article? {
        return try localDataSource.getArticle(forArticle: article)?.toDomain()
    }
    
    func saveArticle(_ article: Article) async throws {
        let localModel = ArticleLocal.fromDomain(article)
        try localDataSource.saveArticle(localModel)
    }
}
