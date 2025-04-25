//
//  ArticleListRepository.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 3/9/24.
//

import Foundation

final class ArticleListRepository: ArticleListRepositoryProtocol {
    
    private let remoteDataSource: ArticleRemoteDataSource
    private let localDataSource: ArticleLocalDataSource
    
    init(remoteDataSource: ArticleRemoteDataSource, localDataSource: ArticleLocalDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func fetchArticlesByQuery(query: String) async throws -> [ArticleList] {
        let articleDTO = try await remoteDataSource.fetchArticlesByQuery(query)
        return articleDTO.toDomain()
    }
    
    func fetchTrendingArticles(page: Int) async throws -> [ArticleList] {
        let articleDTO = try await remoteDataSource.fetchTrendingArticles(page: page)
        return articleDTO.toDomain()
    }
}
