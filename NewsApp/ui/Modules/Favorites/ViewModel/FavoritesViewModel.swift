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
        return favorite.id == value.id
    }
    
    func add(_ saveKey: FavoriteKey, value: T) {
        objectWillChange.send()
        
        favorite = value
        do {
            let encoded = try JSONEncoder().encode(favorite)
            UserDefaultsManager<T>.saveItem(saveKey, encoded)
        } catch {
            print("Error encoding value \(error)")
        }
    }
    
    func remove(_ saveKey: FavoriteKey, value: T) {
        objectWillChange.send()
        /*do {
            let encoded = try JSONEncoder().encode(value)
            UserDefaultsManager<T>.removeItem(saveKey, encoded)
        } catch {
            print("Error encoding value \(error)")
        }*/
        
        // MARK: Directly delete the object saved in UserDefaults.
        UserDefaultsManager<T>.removeItem(saveKey)
        favorite = nil
    }
    
    func filtered(from allItems: [T], showFavoritesOnly: Bool) -> [T] {
        return showFavoritesOnly ? allItems.filter { contains($0) } : allItems
    }
}
