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
        
    init(favoritesManager: FavoritesManager = FavoritesManager(saveKey: FavoriteKey.characterFavorite)) {
        self.favoritesManager = favoritesManager
        self.loadfavoritesManager()
    }
    
    func loadfavoritesManager() {
        self.charactersIds = favoritesManager.getItems()
    }
    
    func contains(_ article: CharacterApiObject) -> Bool {
        // FIXME: Cannot convert value of type 'Int' to expected argument type 'UUID'
        //charactersIds.contains(article.id)
        
        return false
    }
    
    func add(_ article: CharacterApiObject) {
        objectWillChange.send()
        // FIXME: Cannot convert value of type 'Int' to expected argument type 'UUID'
        //charactersIds.insert(article.id)
        favoritesManager.saveFavorite(charactersIds)
    }
    
    func remove(_ article: CharacterApiObject) {
        objectWillChange.send()
        // FIXME: Cannot convert value of type 'Int' to expected argument type 'UUID'
        //charactersIds.remove(article.id)
        favoritesManager.saveFavorite(charactersIds)
    }
    
    func filteredCharacters(from allCharacters: [CharacterApiObject], showFavoritesOnly: Bool) -> [CharacterApiObject] {
        return showFavoritesOnly ? allCharacters.filter { contains($0) } : allCharacters
    }
}
