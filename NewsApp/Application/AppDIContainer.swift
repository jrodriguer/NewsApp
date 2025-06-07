//
//  AppDIContainer.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 19/10/24.
//
//  Description:
//  Initialize global dependencies and creates the entry point of the app.

import Foundation

class AppDIContainer {
    // Data sources
    lazy var articleRemoteDataSource = ArticleRemoteDataSource()
    lazy var articleLocalDataSource = ArticleLocalDataSource()
    lazy var searchLocalDataSource = SearchHistoryLocalDataSource()
    
    // Repositories
    lazy var articleListRepositoryProtocol: ArticleListRepositoryProtocol = ArticleListRepository(
        remoteDataSource: articleRemoteDataSource,
        localDataSource: articleLocalDataSource
    )
    lazy var searchHistoryRepositoryProtocol: SearchHistoryRepositoryProtocol = SearchHistoryRepository(
        localDataSource: searchLocalDataSource
    )
    
    // Use cases
    lazy var getArticlesUseCase: GetArticleUseCase = GetArticleUseCase(
        repository: articleListRepositoryProtocol
    )
    lazy var manageSearchHistoryUseCase: ManageSearchHistoryUseCase = ManageSearchHistoryUseCase(
        repository: searchHistoryRepositoryProtocol
    )
    
    // View models
    func makeArticleViewModel() -> ArticleViewModel {
        ArticleViewModel(
            getArticleUseCase: getArticlesUseCase,
            searchHistoryUseCase: manageSearchHistoryUseCase
        )
    }
}
