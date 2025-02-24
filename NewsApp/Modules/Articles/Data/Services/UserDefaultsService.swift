//
//  UserDefaultsService.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 7/1/25.
//

import Foundation

protocol UserDefaultsServiceProtocol {
    associatedtype T: Codable
    static func saveItem(_ saveKey: BookmarkKey, _ data: Data)
    static func removeItem(_ saveKey: BookmarkKey)
    static func getItem(_ saveKey: BookmarkKey) -> Data?
}

class UserDefaultsService<T: Codable>: UserDefaultsServiceProtocol {
    static func saveItem(_ saveKey: BookmarkKey, _ data: Data) {
        UserDefaults.standard.set(data, forKey: saveKey.rawValue)
    }
    
    static func removeItem(_ saveKey: BookmarkKey) {
        UserDefaults.standard.removeObject(forKey: saveKey.rawValue)
    }

    static func getItem(_ saveKey: BookmarkKey) -> Data? {
        return UserDefaults.standard.data(forKey: saveKey.rawValue)
    }
}
