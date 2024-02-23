//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import Foundation

class ArticleViewModel: ObservableObject {
    private var backendApi: BackendApi?
    @Published var articles: [ArticleApiObject] = []
    @Published var isLoading: Bool = false
    
    init(backendApi: BackendApi = BackendApi(apiUrl: "https://newsapi.org")) {
        self.backendApi = backendApi
        self.loadArticles()
    }
    
    func loadArticles() {
        isLoading = true
                
        backendApi?.getArticles()?.responseDecodable(of: ArticleListApiObject.self) { [weak self] response in
            guard let self = self else { return }
            self.isLoading = false
            
            switch response.result {
            case .success(let articlesListApiObject):
                self.articles = articlesListApiObject.articles
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
