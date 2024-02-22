//
//  Favorites.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 22/2/24.
//

import Foundation

class Favorites: ObservableObject {
    private var backendApi: BackendApi?
    private var articlesIds: Set<UUID> = []
    
    init(backendApi: BackendApi? = nil) {
        self.backendApi = backendApi
        self.loadFavorites()
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
