//
//  ArticleListRepository.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 3/9/24.
//

import Foundation

final class DefaultArticleListRepository: ArticleListRepository {
    
    private let remoteDataSource: ArticleRemoteDataSource
    private let localDataSource: NewsLocalDataSource
    
    init(remoteDataSource: ArticleRemoteDataSource, localDataSource: NewsLocalDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func fetchArticlesByQuery(query: String) async throws -> [ArticleList] {
        let articleDTO = try await remoteDataSource.fetchArticlesByQuery(query)
        return articleDTO.toDomain()
    }
    
    func fetchTrendingArticles(page: Int) async throws -> [ArticleList] {
        return []
    }
}
