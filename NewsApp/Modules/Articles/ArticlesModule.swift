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
        return TabContentView(articleTabView: generateArticleTabView(), searchTabView: generateSearchTabView(), bookmarkTabView: generateBookmarkTabView())
    }
    
    private func generateArticleTabView() -> ArticleTabView<ArticleViewModel> {
        return ArticleTabView(viewModel: generateArticleViewModel())
    }
    
    private func generateSearchTabView() -> SearchTabView {
        return SearchTabView()
    }
    
    private func generateBookmarkTabView() -> BookmarkTabView<BookmarkViewModel<ArticleListItemViewModel>> {
        return BookmarkTabView(viewModel: generateBookmarkViewModel())
    }
    
    private func generateArticleViewModel() -> ArticleViewModel {
        ArticleViewModel(useCase: generateArticleListUseCase())
    }
    
    private func generateBookmarkViewModel() -> BookmarkViewModel<ArticleListItemViewModel> {
        BookmarkViewModel(saveKey: BookmarkKey.articleFavorites)
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
