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
    private var favorites: [T] = []
    
    func loadFavorite(_ saveKey: FavoriteKey) -> [T] {
        if let storedItems = UserDefaultsManager<[T]>.getItem(saveKey),
           let decodedItems = try? JSONDecoder().decode([T].self, from: storedItems) {
            favorites = decodedItems
            return favorites
        } else {
            return []
        }
    }
    
    func contains(_ value: T) -> Bool {
        return favorites.contains { $0.id == value.id }
    }
    
    func add(_ saveKey: FavoriteKey, value: T) {
        objectWillChange.send()
        favorites.append(value)
        saveForite(saveKey, favorites)
    }
    
    func remove(_ saveKey: FavoriteKey, value: T) {
        objectWillChange.send()
        favorites.removeAll(where: { $0.id == value.id })
        saveForite(saveKey, favorites)
    }
    
    func filtered(from allItems: [T], showFavoritesOnly: Bool) -> [T] {
        return showFavoritesOnly ? allItems.filter { contains($0) } : allItems
    }
    
    private func saveForite(_ saveKey: FavoriteKey, _ value: [T]) {
        do {
            let encoded = try JSONEncoder().encode(favorites)
            UserDefaultsManager<T>.saveItem(saveKey, encoded)
        } catch {
            print("Error encoding value \(error)")
        }
    }
}
