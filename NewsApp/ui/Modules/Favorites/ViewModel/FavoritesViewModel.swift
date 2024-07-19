//
//  FavoritesViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 27/2/24.
//

import Foundation

enum FavoriteKey: String {
    case articleFavorites
}

class FavoritesViewModel<T: Identifiable & Codable>: ObservableObject {
    private var saveKey: FavoriteKey
    private var userDefaultsManager: any UserDefaultsManagerProtocol.Type
    @Published private var favorites: [T] = []
    
    init(saveKey: FavoriteKey, userDefaultsManager: any UserDefaultsManagerProtocol.Type = UserDefaultsManager<T>.self) {
        self.saveKey = saveKey
        self.userDefaultsManager = userDefaultsManager
        self.favorites = loadFavorites()
    }
    
    private func loadFavorites() -> [T] {
        if let storedItems = UserDefaultsManager<[T]>.getItem(saveKey),
           let decodedItems = try? JSONDecoder().decode([T].self, from: storedItems) {
            favorites = decodedItems
            return favorites
        } else {
            return []
        }
    }
    
    private func saveForites() {
        do {
            let encoded = try JSONEncoder().encode(favorites)
            UserDefaultsManager<T>.saveItem(saveKey, encoded)
        } catch {
            print("Error encoding value \(error)")
        }
    }
    
    func contains(_ value: T) -> Bool {
        return favorites.contains { $0.id == value.id }
    }
    
    func add(_ value: T) {
        objectWillChange.send()
        favorites.append(value)
        saveForites()
    }
    
    func remove(_ value: T) {
        objectWillChange.send()
        favorites.removeAll(where: { $0.id == value.id })
        saveForites()
    }
    
    func filtered(from allItems: [T], showFavoritesOnly: Bool) -> [T] {
        return showFavoritesOnly ? allItems.filter { contains($0) } : allItems
    }
}
