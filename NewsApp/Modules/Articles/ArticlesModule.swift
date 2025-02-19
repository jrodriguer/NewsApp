//
//  ArticlesModule.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 22/8/24.
//

import Foundation
import SwiftUI

final class ArticlesModule {
    
    private let apiDataTransferService: DataTransferService
    
    init(apiDataTransferService: DataTransferService) {
        self.apiDataTransferService = apiDataTransferService
    }
    
    func generateTabContentView() -> TabContentView {
        return TabContentView(articleTabView: generateArticleTabView(), searchTabView: generateSearchTabView())
    }
    
    private func generateArticleTabView() -> ArticleTabView<ArticleViewModel> {
        return ArticleTabView(viewModel: generateArticleViewModel())
    }
    
    private func generateSearchTabView() -> SearchTabView<ArticleViewModel> {
        return SearchTabView(viewModel: generateArticleViewModel())
    }
    
    private func generateBookmarkTabView() -> BookmarkTabView {
        return BookmarkTabView()
    }
    
    private func generateArticleViewModel() -> ArticleViewModel {
        ArticleViewModel(useCase: generateArticleListUseCase())
    }
    
    private func generateBookmarkViewModel() -> BookmarkViewModel {
        BookmarkViewModel(saveKey: BookmarkKey.articleBookmarks)
    }
    
    private func generateArticleListUseCase() -> ArticleListUseCase {
        DefaultArticleListUseCase(repository: generateArticleListRepository())
    }
    
    private func generateArticleListRepository() -> ArticleListRepository {
        DefaultArticleListRepository(service: generateArticleListService())
    }
    
    private func generateArticleListService() -> ArticleListService {
        DefaultArticleListService(apiDataService: apiDataTransferService)
    }
}
