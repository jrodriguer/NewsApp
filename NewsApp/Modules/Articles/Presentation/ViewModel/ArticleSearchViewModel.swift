//
//  ArticleSearchViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 17/2/25.
//

import Foundation

class ArticleSearchViewModel: ObservableObject {
    
    @Published var searchText = ""
    
    private let articleListUseCase: ArticleListUseCase!
    
    init(useCase: ArticleListUseCase) {
        self.articleListUseCase = useCase
    }

}
