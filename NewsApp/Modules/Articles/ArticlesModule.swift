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
    
    func generateArticleView() -> ArticleView<ArticleViewModel> {
        return ArticleView(vm: generateArticleViewModel())
    }
    
    func generateArticleViewModel() -> ArticleViewModel {
        ArticleViewModel(useCase: generateArticleListUseCase())
    }
    
    func generateArticleListUseCase() -> ArticleListUseCase {
        DefaultArticleListUseCase(repository: generateArticleListRepository())
    }
    
    func generateArticleListRepository() -> ArticleListRepository {
        DefaultArticleListRepository(service: generateArticleListService())
    }
    
    func generateArticleListService() -> ArticleListService {
        DefaultArticleListService(apiDataService: apiDataTransferService)
    }
}
