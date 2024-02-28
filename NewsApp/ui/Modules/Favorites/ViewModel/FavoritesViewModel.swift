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
        
        // Identifiable conditional type to make sure that value has an id property that can be used for comparison.
        if let valueWithId = value as? (any Identifiable), let itemId = valueWithId.id as? T {
            return favorite == itemId // FIXME: Binary operator '==' cannot be applied to two 'T' operands
        }
        
        return false
    }
    
    func add(_ saveKey: FavoriteKey, value: T) {
        objectWillChange.send()
        // favorite.insert(value.id)
        
        do {
            let encoded = try JSONEncoder().encode(value)
            UserDefaultsManager<T>.saveItem(saveKey, data: encoded)
        } catch {
            print("Error encoding value \(error)")
        }
    }
    
    func remove(_ saveKey: FavoriteKey, value: T) {
        // TODO: Add logic for remove particular item.
        
        objectWillChange.send()
        //favorite.remove(value.id)
        
        do {
            let encoded = try JSONEncoder().encode(value)
            UserDefaultsManager<T>.saveItem(saveKey, data: encoded)
        } catch {
            print("Error encoding value \(error)")
        }
    }
    
    func filtered(from allItems: [T], showFavoritesOnly: Bool) -> [T] {
        return showFavoritesOnly ? allItems.filter { contains($0) } : allItems
    }
}
