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
    private var articlesIds: Set<UUID> = []
    
    init(backendApi: BackendApi = BackendApi(apiUrl: "https://newsapi.org")) {
        self.backendApi = backendApi
        self.loadArticles()
        self.loadFavorites()
    }
    
    func loadArticles() {
        backendApi?.getArticles()?.responseDecodable(of: [ArticleApiObject].self) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let articlesApObject):
                self.articles = articlesApObject
            case .failure(let error):
                print("Error: \(String(describing: error))")
                if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                    print("Raw response: \(responseString)")
                }
            }
        }
    }
    
    func loadFavorites() {
        self.articlesIds = backendApi?.getFavorites() ?? []
    }
    
    func contains(_ article: ArticleApiObject) -> Bool {
        articlesIds.contains(article.id)
    }
    
    func add(_ article: ArticleApiObject) {
        objectWillChange.send()
        articlesIds.insert(article.id)
        backendApi?.saveFavorite(articlesIds)
    }
    
    func remove(_ article: ArticleApiObject) {
        objectWillChange.send()
        articlesIds.remove(article.id)
        backendApi?.saveFavorite(articlesIds)
    }
}
