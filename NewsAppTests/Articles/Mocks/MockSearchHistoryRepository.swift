//
//  MockSearchHistoryRepository.swift
//  NewsAppTests
//
//  Created by Julio Rodriguez on 5/5/25.
//

@testable import NewsApp
import Foundation

class MockSearchHistoryRepository: SearchHistoryRepositoryProtocol {
    var searchs = [String]()
    var getRecentSearchesCalled = false
    var addSearchCalled = false
    var shouldThrowError = false
    private let errotToThrow = NSError(domain: "error", code: 0 )

    var lastAddedSearch: String? {
        searchs.last
    }
    func getRecentSearches() async throws -> [String] {
        getRecentSearchesCalled = true
        if shouldThrowError {
            throw errotToThrow
        }
        return searchs
    }
    
    func addSearch(_ articleTitle: String) async throws {
        addSearchCalled = true
        if shouldThrowError {
            throw errotToThrow
        }
        searchs.append(articleTitle)
    }
}

