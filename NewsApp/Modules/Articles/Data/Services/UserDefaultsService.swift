//
//  UserDefaultsService.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 12/6/25.
//

import Foundation

final class UserDefaultsService: UserDefaultsServiceProtocol {
    private static let defaults = UserDefaults.standard
    
    static func saveItem<U: Encodable>(_ key: BookmarkKey, _ value: U) {
        do {
            let data = try JSONEncoder().encode(value)
            defaults.set(data, forKey: key.rawValue)
        } catch {
            Log.error(tag: UserDefaultsService.self, message: "Failed to encode and save item: \(error)")
        }
    }
    
    static func getItem<U: Decodable>(_ key: BookmarkKey) -> U? {
        guard let data = defaults.data(forKey: key.rawValue) else { return nil }
        return try? JSONDecoder().decode(U.self, from: data)
    }
}
