//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import Foundation
import SwiftUI

class ArticleViewModel: ObservableObject {
    private var apiRest: ApiRestManager
    @Published var articles: [ArticleApiObject] = []
    private var articlesIds: Set<UUID> = []
    
    init(apiRest: ApiRestManager = ApiRestManager()) {
        self.apiRest = apiRest
        self.loadArticles()
        self.loadFavorites()
    }
    
    func loadArticles() {
        // TODO: Woking on private params for API request.
        // TODO: Load following page break way, &page=<Int>.
        
        let endpoint = Endpoint(url: "https://newsapi.org/v2/top-headlines?country=us&apiKey=978764b3fe6b412f8517a7d9c0a1e140")
        apiRest.loadList(endpoint) { (result: Result<ArticleListApiObject<ArticleApiObject>, Error>) in
            switch result {
            case .success(let list):
                self.articles = list.articles
            case .failure(let error):
                print("Error loading articles: \(error.localizedDescription)")
            }
        }

        /*let list: ArticleListApiObject<ArticleApiObject> = apiRest.load("TopHeadLines.json")
        self.articles = list.articles*/
    }
    
    func loadFavorites() {
        self.articlesIds = apiRest.getFavorites()
    }
    
    func contains(_ article: ArticleApiObject) -> Bool {
        articlesIds.contains(article.id)
    }
    
    func add(_ article: ArticleApiObject) {
        objectWillChange.send()
        articlesIds.insert(article.id)
        apiRest.saveFavorite(articlesIds)
    }
    
    func remove(_ article: ArticleApiObject) {
        objectWillChange.send()
        articlesIds.remove(article.id)
        apiRest.saveFavorite(articlesIds)
    }
}
