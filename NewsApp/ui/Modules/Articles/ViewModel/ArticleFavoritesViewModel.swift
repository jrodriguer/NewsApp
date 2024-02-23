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
    
    func filteredArticles(from allArticles: [ArticleApiObject], showFavoritesOnly: Bool) -> [ArticleApiObject] {
        return showFavoritesOnly ? allArticles.filter { contains($0) } : allArticles
    }
}
