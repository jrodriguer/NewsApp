//
//  SearchHistoryLocalDataSource.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 25/4/25.
//

import Foundation

protocol SearchHistoryLocalDataSourceProtocol {
    func getRecentSearches() throws -> [String]
    func saveSearch(_ cityName: String) throws
}

class SearchHistoryLocalDataSource: SearchHistoryLocalDataSourceProtocol {
    private let userDefaults = UserDefaults.standard
    private let recentSearchesKey = "recentSearches"
    private let maxSearches = 5
    
    func getRecentSearches() throws -> [String] {
        return userDefaults.stringArray(forKey: recentSearchesKey) ?? []
    }
    
    func saveSearch(_ articleTitle: String) throws {
        var searches = userDefaults.stringArray(forKey: recentSearchesKey) ?? []
        
        // Remove existing entry if present
        searches.removeAll { $0 == articleTitle }
        
        // Add at the beginning
        searches.insert(articleTitle, at: 0)
        
        // Limit to max number of searches
        if searches.count > maxSearches {
            searches = Array(searches.prefix(maxSearches))
        }
        
        userDefaults.set(searches, forKey: recentSearchesKey)
    }
}
