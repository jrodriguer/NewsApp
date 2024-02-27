//
//  FavoritesViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 27/2/24.
//

import Foundation

enum FavoriteKey: String {
    case articleFavorite, characterFavorite
}

class FavoritesViewModel<T: Codable>: ObservableObject {
    private var items: T?
    
    func loadFavorites(_ saveKey: FavoriteKey) -> T? {
        if let storedItems = UserDefaultsManager<T>.getItems(saveKey),
           let decodedItems = try? JSONDecoder().decode(T.self, from: storedItems) {
            items = decodedItems
            return items
        } else {
            return nil
        }
    }
    
    func contains(_ article: ArticleApiObject) -> Bool {
        itemsIds.contains(article.id)
    }
    
    func add(_ article: ArticleApiObject) {
        objectWillChange.send()
        itemsIds.insert(article.id)
        favoritesManager.saveFavorite(articlesIds)
    }
    
    func remove(_ article: ArticleApiObject) {
        objectWillChange.send()
        itemsIds.remove(article.id)
        favoritesManager.saveFavorite(articlesIds)
    }
    
    func filteredArticles(from allArticles: [ArticleApiObject], showFavoritesOnly: Bool) -> [ArticleApiObject] {
        return showFavoritesOnly ? allArticles.filter { contains($0) } : allArticles
    }
}
