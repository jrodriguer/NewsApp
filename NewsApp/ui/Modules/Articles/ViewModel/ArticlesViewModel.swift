//
//  ArticlesViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import Foundation

final class ArticlesViewModel: ObservableObject {
    @Inject var backendApi: BackendApiProtocol?
    @Published var articles: [ArticleApiObject] = []
    @Published var isLoading: Bool = false
    
    init() {
        self.loadArticles()
    }
    
    func loadArticles(category: Category? = nil) {
        isLoading = true
                
        backendApi?.getTopHeadLinesArticles(category: category)?.responseDecodable(of: ArticleListApiObject.self) { [weak self] response in
            guard let self = self else { return }
            self.isLoading = false
            
            switch response.result {
            case .success(let articlesListApiObject):
                self.articles = articlesListApiObject.articles
            case .failure(let error):
                print("Error: \(error)")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.isLoading = false
            }
        }
    }
}
