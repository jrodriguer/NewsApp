//
//  UserDefaultsManager.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 22/2/24.
//

import Foundation

enum FavoriteKey: String, CaseIterable {
    case articleFavorite, characterFavorite
}

class UserDefaultsManager: ObservableObject {
    static func saveFavorite(_ saveKey: FavoriteKey, data: Data) -> Void {
        UserDefaults.standard.set(data, forKey: saveKey.rawValue)
        /*
         if let encoded = try? JSONEncoder().encode(id) {
             UserDefaults.standard.set(encoded, forKey: saveKey.rawValue)
         }
         */
    }
    
    static func getItems(_ saveKey: FavoriteKey) -> Data? {
        return UserDefaults.standard.data(forKey: saveKey.rawValue)
        /*if let savedIDs = UserDefaults.standard.data(forKey: saveKey.rawValue),
           let decodedIDs = try? JSONDecoder().decode(Set<UUID>.self, from: savedIDs) {
            return decodedIDs
        } else {
            return []
        }*/
    }
}
