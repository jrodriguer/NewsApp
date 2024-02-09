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
        do {
            let list: ListApiObject<ArticleApiObject> = try apiRest.load("TopHeadLines.json")
            self.articles = list.articles
        } catch {
            print("Error loading articles: \(error.localizedDescription)")
        }
    }
    
    func loadFavorites() {
        do {
            self.articlesIds = try apiRest.get()
        } catch {
            print("Error loading favorites: \(error.localizedDescription)")
        }
    }
    
    func contains(_ article: ArticleApiObject) -> Bool {
        articlesIds.contains(article.id)
    }
    
    func add(_ article: ArticleApiObject) {
        objectWillChange.send()
        articlesIds.insert(article.id)
        do {
            try apiRest.save(articlesIds)
        } catch {
            print("Error adding articles: \(error.localizedDescription)")
        }
    }
    
    func remove(_ article: ArticleApiObject) {
        objectWillChange.send()
        articlesIds.remove(article.id)
        do {
            try apiRest.save(articlesIds)
        } catch {
            print("Error removing articles: \(error.localizedDescription)")
        }
    }
}
