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
        let list: ArticleListApiObject<ArticleApiObject> = apiRest.load("TopHeadLines.json")
        self.articles = list.articles
    }
    
    func loadFavorites() {
        self.articlesIds = apiRest.get()
    }
    
    func contains(_ article: ArticleApiObject) -> Bool {
        articlesIds.contains(article.id)
    }
    
    func add(_ article: ArticleApiObject) throws {
        objectWillChange.send()
        articlesIds.insert(article.id)
        apiRest.save(articlesIds)
    }
    
    func remove(_ article: ArticleApiObject) {
        objectWillChange.send()
        articlesIds.remove(article.id)
        apiRest.save(articlesIds)
    }
}
