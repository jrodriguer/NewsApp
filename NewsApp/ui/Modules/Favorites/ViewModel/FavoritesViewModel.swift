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

class FavoritesViewModel<T: Identifiable & Codable>: ObservableObject {
    
    //!! TODO: Refactor to array of favorites.
    
    private var favorites: [T]? = []
    
    func loadFavorite(_ saveKey: FavoriteKey) -> [T]? {
        if let storedItems = UserDefaultsManager<[T]>.getItem(saveKey),
           let decodedItems = try? JSONDecoder().decode([T].self, from: storedItems) {
            favorites = decodedItems
            return favorites
        } else {
            return nil
        }
    }
    
    func contains(_ value: T) -> Bool {
        guard let favorites = favorites else { return false }
        return favorites.contains { $0.id == value.id }
    }
    
    func add(_ saveKey: FavoriteKey, value: T) {
        objectWillChange.send()
        
        favorites?.append(value)
        /*do {
            let encoded = try JSONEncoder().encode(favorite)
            UserDefaultsManager<T>.saveItem(saveKey, encoded)
        } catch {
            print("Error encoding value \(error)")
        }*/
    }
    
    func remove(_ saveKey: FavoriteKey, value: T) {
        objectWillChange.send()
        
        // Directly delete the object saved in UserDefaults.
        /*UserDefaultsManager<T>.removeItem(saveKey)
        favorites = nil*/
    }
    
    func filtered(from allItems: [T], showFavoritesOnly: Bool) -> [T] {
        return showFavoritesOnly ? allItems.filter { contains($0) } : allItems
    }
}
