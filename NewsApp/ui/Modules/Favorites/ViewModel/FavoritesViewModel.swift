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

class FavoritesViewModel<T: Codable & Hashable & Identifiable>: ObservableObject {
    private var favorite: T?
    
    func loadFavorite(_ saveKey: FavoriteKey) -> T? {
        if let storedItem = UserDefaultsManager<T>.getItem(saveKey),
           let decodedItem = try? JSONDecoder().decode(T.self, from: storedItem) {
            favorite = decodedItem
            return favorite
        } else {
            return nil
        }
    }
    
    func contains(_ value: T) -> Bool {
        guard let favorite = favorite else { return false }
        return favorite == value
    }
    
    func add(_ saveKey: FavoriteKey, value: T) {
        objectWillChange.send()
        // favorite.insert(value.id)
        UserDefaultsManager<T>.saveFavorite(saveKey, data: value)
    }
    
    func remove(_ saveKey: FavoriteKey, value: T) {
        // TODO: Add logic for remove particular item.
        
        objectWillChange.send()
        //favorite.remove(value.id)
        UserDefaultsManager<T>.saveFavorite(saveKey, data: value)
    }
    
    func filtered(from allItems: [T], showFavoritesOnly: Bool) -> [T] {
        return showFavoritesOnly ? allItems.filter { contains($0) } : allItems
    }
}
