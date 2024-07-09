//
//  MockUserDefaultsManager.swift
//  NewsAppTests
//
//  Created by Julio Rodriguez on 9/7/24.
//

import Foundation

@testable import NewsApp
class MockUserDefaultsManager<T: Codable>: ObservableObject {
    private var mockStorage: MockStorage
    
    init(mockStorage: MockStorage) {
        self.mockStorage = mockStorage
    }
    
    func saveItem(_ saveKey: FavoriteKey, _ data: Data) {
        mockStorage.saveItem(saveKey, data)
    }
    
    func removeItem(_ saveKey: FavoriteKey) {
        mockStorage.removeItem(saveKey)
    }
    
    func getItem(_ saveKey: FavoriteKey) -> Data? {
        return mockStorage.getItem(saveKey)
    }
}
