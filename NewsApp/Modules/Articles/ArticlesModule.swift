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
    
    func generateArticleView() -> ArticleView {
        return ArticleView()
    }
}
