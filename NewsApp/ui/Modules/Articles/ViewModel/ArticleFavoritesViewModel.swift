//
//  ArticleFavoritesViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 23/2/24.
//

import Foundation

class ArticleFavoritesViewModel: ObservableObject {
    private var favoritesManager: FavoritesManager
    private var articlesIds: Set<UUID> = []
    
    // An array of all articles available
    var allArticles: [ArticleApiObject] = []
    
    var filteredArticles: [ArticleApiObject] {
        // Filter the articles based on the favorites
        return allArticles.filter { contains($0) }
    }
        
    // TODO: More easy and save, Work on enum for manage saveKeys.
    init(favoritesManager: FavoritesManager = FavoritesManager(saveKey: "Articlefavorites")) {
        self.favoritesManager = favoritesManager
        self.loadfavoritesManager()
    }
    
    func loadfavoritesManager() {
        self.articlesIds = favoritesManager.getItems()
    }
    
    func contains(_ article: ArticleApiObject) -> Bool {
        articlesIds.contains(article.id)
    }
    
    func add(_ article: ArticleApiObject) {
        objectWillChange.send()
        articlesIds.insert(article.id)
        favoritesManager.saveFavorite(articlesIds)
    }
    
    func remove(_ article: ArticleApiObject) {
        objectWillChange.send()
        articlesIds.remove(article.id)
        favoritesManager.saveFavorite(articlesIds)
    }
}
