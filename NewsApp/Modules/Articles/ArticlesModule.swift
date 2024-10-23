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
    
    func generateHomeView() -> HomeView {
        return HomeView(articleView: generateArticleView())
    }
    
    private func generateArticleView() -> ArticleView<ArticleViewModel> {
        return ArticleView(viewModel: generateArticleViewModel())
    }
    
    private func generateArticleViewModel() -> ArticleViewModel {
        ArticleViewModel(useCase: generateArticleListUseCase())
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
