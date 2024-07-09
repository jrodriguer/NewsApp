//
//  MockStorage.swift
//  NewsAppTests
//
//  Created by Julio Rodriguez on 9/7/24.
//

import Foundation

@testable import NewsApp
class MockStorage {
    private var storage: [String: Data] = [:]

    func saveItem(_ saveKey: FavoriteKey, _ data: Data) {
        storage[saveKey.rawValue] = data
    }
    
    func removeItem(_ saveKey: FavoriteKey) {
        storage.removeValue(forKey: saveKey.rawValue)
    }

    func getItem(_ saveKey: FavoriteKey) -> Data? {
        return storage[saveKey.rawValue]
    }

    func clear() {
        storage.removeAll()
    }
}
