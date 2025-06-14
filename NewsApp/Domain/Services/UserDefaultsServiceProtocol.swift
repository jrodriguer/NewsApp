//
//  UserDefaultsServiceProtocol.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 12/6/25.
//

import Foundation

protocol UserDefaultsServiceProtocol {
    static func saveItem<T: Encodable>(_ key: BookmarkKey, _ value: T)
    static func getItem<T: Decodable>(_ key: BookmarkKey) -> T?
}
