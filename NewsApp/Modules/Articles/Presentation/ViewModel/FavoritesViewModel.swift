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

protocol FavoritesViewModelProtocol: ObservableObject {
    associatedtype T: Identifiable & Codable
    var favorites: [T] { get set }
    func contains(_ value: T) -> Bool
    func add(_ value: T)
    func remove(_ value: T)
    func filtered(from allItems: [T], showFavoritesOnly: Bool) -> [T]
}

class FavoritesViewModel<T: Identifiable & Codable>: FavoritesViewModelProtocol {
    
    @Published var favorites: [T] = []
    
    private var saveKey: FavoriteKey
    private var userDefaultsManager: any UserDefaultsServiceProtocol.Type
    
    init(saveKey: FavoriteKey, userDefaultsManager: any UserDefaultsServiceProtocol.Type = UserDefaultsService<T>.self) {
        self.saveKey = saveKey
        self.userDefaultsManager = userDefaultsManager
        self.favorites = loadFavorites()
    }
    
    private func loadFavorites() -> [T] {
        if let storedItems = UserDefaultsService<[T]>.getItem(saveKey),
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
            UserDefaultsService<T>.saveItem(saveKey, encoded)
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
    
    func toggle(_ value: T) {
        if contains(value) {
            remove(value)
        } else {
            add(value)
        }
    }
    
    func filtered(from allItems: [T], showFavoritesOnly: Bool) -> [T] {
        return showFavoritesOnly ? allItems.filter { contains($0) } : allItems
    }
}
