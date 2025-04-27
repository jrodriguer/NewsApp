//
//  SearchHistoryRepositoryProtocol.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 27/4/25.
//

import Foundation

protocol SearchHistoryRepositoryProtocol {
    func getRecentSearches() async throws -> [String]
    func addSearch(_ articleTitle: String) async throws
}
