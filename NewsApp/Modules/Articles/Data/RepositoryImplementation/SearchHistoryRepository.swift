//
//  SearchHistoryRepository.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 27/4/25.
//

import Foundation

class SearchHistoryRepository: SearchHistoryRepositoryProtocol {
    
    private let localDataSource: SearchHistoryLocalDataSourceProtocol
    
    init(localDataSource: SearchHistoryLocalDataSourceProtocol) {
        self.localDataSource = localDataSource
    }
    
    func getRecentSearches() async throws -> [String] {
        return try localDataSource.getRecentSearches()
    }
    
    func addSearch(_ articleTitle: String) async throws {
        try localDataSource.saveSearch(articleTitle)
    }
}
