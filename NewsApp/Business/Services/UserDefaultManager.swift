//
//  UserDefaultsManager.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 22/2/24.
//

import Foundation

class UserDefaultsManager<T: Codable>: ObservableObject {
    static func saveItem(_ saveKey: FavoriteKey, _ data: Data) {
        UserDefaults.standard.set(data, forKey: saveKey.rawValue)
    }
    
    static func removeItem(_ saveKey: FavoriteKey) {
        UserDefaults.standard.removeObject(forKey: saveKey.rawValue)
    }

    static func getItem(_ saveKey: FavoriteKey) -> Data? {
        return UserDefaults.standard.data(forKey: saveKey.rawValue)
    }
}
