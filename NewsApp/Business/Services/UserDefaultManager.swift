//
//  UserDefaultsManager.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 22/2/24.
//

import Foundation

class UserDefaultsManager<T: Encodable>: ObservableObject {
    static func saveFavorite(_ saveKey: FavoriteKey, data: T) {
        /*
         if let encoded = try? JSONEncoder().encode(id) {
             UserDefaults.standard.set(encoded, forKey: saveKey.rawValue)
         }
         */
        
        do {
            let encoded = try JSONEncoder().encode(data)
            UserDefaults.standard.set(encoded, forKey: saveKey.rawValue)
        } catch {
            print("Error encoding value \(error)")
        }
    }
    
    static func getItems(_ saveKey: FavoriteKey) -> Data? {
        /*if let savedIDs = UserDefaults.standard.data(forKey: saveKey.rawValue),
           let decodedIDs = try? JSONDecoder().decode(Set<UUID>.self, from: savedIDs) {
            return decodedIDs
        } else {
            return []
        }*/
        
        return UserDefaults.standard.data(forKey: saveKey.rawValue)
    }
}
