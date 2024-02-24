//
//  FavoritesManger.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 22/2/24.
//

import Foundation

enum FavoriteKey: String, CaseIterable {
    case articleFavorite, characterFavorite
}

class FavoritesManager: ObservableObject {
    // MARK: How the favorites are identified in UserDefaults.
    private let saveKey: FavoriteKey
    
    private var itemsIds: Set<UUID> = []
    
    init(saveKey: FavoriteKey) {
        self.saveKey = saveKey
    }
    
    // MARK: UserDefaults settings.
    
    func saveFavorite(_ id: Set<UUID>) {
        if let encoded = try? JSONEncoder().encode(id) {
            UserDefaults.standard.set(encoded, forKey: saveKey.rawValue)
        }
    }
    
    func getItems() -> Set<UUID> {
        if let savedIDs = UserDefaults.standard.data(forKey: saveKey.rawValue),
           let decodedIDs = try? JSONDecoder().decode(Set<UUID>.self, from: savedIDs) {
            return decodedIDs
        } else {
            return []
        }
    }
}
