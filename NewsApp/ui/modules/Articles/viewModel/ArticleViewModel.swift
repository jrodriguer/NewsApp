//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import Foundation

class ArticleViewModel: ObservableObject {
    var apiRest = ApiRestManager()
    @Published var articles: [ArticleApiObject] = []
    private var articlesId: Set<UUID> = []

    init() {
        self.loadArticles()
        self.loadFavorites()
    }
    
    func loadArticles() {
        let news: ListApiObject<ArticleApiObject> = apiRest.load("TopHeadLines.json")
        self.articles = news.articles
    }
    
    func loadFavorites() {
        self.articlesId = apiRest.get()
    }
    
    func contains(_ article: ArticleApiObject) -> Bool {
        articlesId.contains(article.id)
    }
    
    func add(_ article: ArticleApiObject) {
        objectWillChange.send()
        articlesId.insert(article.id)
        apiRest.save(articlesId)
    }
    
    func remove(_ article: ArticleApiObject) {
        objectWillChange.send()
        articlesId.remove(article.id)
        apiRest.save(articlesId)
    }
}
