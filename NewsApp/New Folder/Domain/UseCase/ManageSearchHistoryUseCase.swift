//
//  ManageSearchHistoryUseCase.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 5/5/25.
//

import Foundation

class ManageSearchHistoryUseCase {
    private let repository: SearchHistoryRepositoryProtocol
    
    init(repository: SearchHistoryRepositoryProtocol) {
        self.repository = repository
    }
    
    func getRecentSearches() async throws -> [String] {
        return try await repository.getRecentSearches()
    }
    
    func addSearchTerm(_ cityName: String) async throws {
        try await repository.addSearch(cityName)
    }
}
