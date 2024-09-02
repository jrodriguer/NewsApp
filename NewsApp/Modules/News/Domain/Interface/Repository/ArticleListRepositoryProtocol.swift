//
//  ArticleListRepositoryProtocol.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 2/9/24.
//

import Foundation

protocol ArticleListRepository {
    func fetchTopHeadlines() async throws -> [ArticleDomainListDTO]
    func search(query: String) async throws -> [ArticleDomainListDTO]
}
