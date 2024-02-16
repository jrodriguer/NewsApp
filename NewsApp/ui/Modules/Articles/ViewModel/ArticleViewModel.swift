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
        //FIXME: Mismatch between the expected Swift type during the decoding process.
        //FIXME: Change 'responseJSON' deprecated to 'responseDecodable'.
        
        backendApi?.getArticles()?.responseJSON { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let value):
                if let dictionary = value as? [String: Any],
                   let articlesApObject = dictionary["articles"] as? [[String: Any]] {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: articlesApObject)
                        let articles = try JSONDecoder().decode([ArticleApiObject].self, from: jsonData)
                        self.articles = articles
                    } catch {
                        print("Error decoding articles: \(error)")
                    }
                } else {
                    print("Unexpected response format")
                }
                
            case .failure(let error):
                print("Error: \(error)")
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
