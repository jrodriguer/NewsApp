//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import Foundation

protocol ArticleViewModelProtocol: ObservableObject {
    var articles: [ArticleListItemViewModel] { get set }
    var isError: Bool {get}
    var isEmpty: Bool {get}
    func fetchArticles(category: Category?) async
}

final class ArticleViewModel: ArticleViewModelProtocol {
    
    @Published var articles: [ArticleListItemViewModel] = []
    @Published var isError: Bool = false
    var isEmpty: Bool { return articles.isEmpty }
    private let articleListUseCase: ArticleListUseCase!
    
    init(useCase: ArticleListUseCase) {
        self.articleListUseCase = useCase
    }
    
    func fetchArticles(category: Category? = nil) {
//        backendApi?.getTopHeadLinesArticles(category: category)?.responseDecodable(of: ArticleListApiObject.self) { [weak self] response in
//            guard let self = self else { return }
//            
//            switch response.result {
//            case .success(let articlesListApiObject):
//                self.articles = articlesListApiObject.articles
//            case .failure(let error):
//                Log.error(tag: ArticleViewModel.self, message: "\(error)")
//            }
//            
//            DispatchQueue.main.async {
//                self.isLoading = false
//            }
//        }
    }
}
