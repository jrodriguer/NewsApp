//
//  UserDefaultsManager.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 22/2/24.
//

import Foundation

class UserDefaultsManager<T: Codable>: ObservableObject {
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
        return UserDefaults.standard.data(forKey: saveKey.rawValue)
    }
}
