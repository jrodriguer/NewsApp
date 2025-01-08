//
//  UserDefaultsService.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 7/1/25.
//

import Foundation

protocol UserDefaultsProtocol {
    associatedtype T: Codable
    static func saveItem(_ saveKey: FavoriteKey, _ data: Data)
    static func removeItem(_ saveKey: FavoriteKey)
    static func getItem(_ saveKey: FavoriteKey) -> Data?
}

class UserDefaultsService<T: Codable>: UserDefaultsProtocol {
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
