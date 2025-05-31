//
//  ArticleSearchViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 17/2/25.
//

import Foundation

class ArticleSearchViewModel: ObservableObject {
    
    @Published var searchText = ""
    
    private let GetArticleUseCase: GetArticleUseCase!
    
    init(useCase: GetArticleUseCase) {
        self.GetArticleUseCase = useCase
    }

}
