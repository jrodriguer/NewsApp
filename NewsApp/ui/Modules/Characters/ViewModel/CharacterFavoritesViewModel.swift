//
//  CharacterFavoritesViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 23/2/24.
//

import Foundation

class CharacterFavoritesViewModel: ObservableObject {
    private var favoritesManager: FavoritesManager
    private var charactersIds: Set<UUID> = []
        
    // TODO: More easy and save, Work on enum for manage saveKeys.
    init(favoritesManager: FavoritesManager = FavoritesManager(saveKey: "Characterfavorites")) {
        self.favoritesManager = favoritesManager
        self.loadfavoritesManager()
    }
    
    func loadfavoritesManager() {
        self.charactersIds = favoritesManager.getItems()
    }
    
    func contains(_ article: CharacterApiObject) -> Bool {
        charactersIds.contains(article.id)
    }
    
    func add(_ article: CharacterApiObject) {
        objectWillChange.send()
        charactersIds.insert(article.id)
        favoritesManager.saveFavorite(charactersIds)
    }
    
    func remove(_ article: CharacterApiObject) {
        objectWillChange.send()
        charactersIds.remove(article.id)
        favoritesManager.saveFavorite(charactersIds)
    }
}
