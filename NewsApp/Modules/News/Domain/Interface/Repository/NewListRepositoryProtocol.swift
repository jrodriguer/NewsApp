//
//  NewListRepositoryProtocol.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 2/9/24.
//

import Foundation

protocol NewListRepository {
    func fetchTopHeadlines() async throws -> [NewDomainListDTO]
    func search(query: String) async throws -> [NewDomainListDTO]
}
