//
//  NewListRepository.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 2/9/24.
//

import Foundation

protocol NewListRepository {
    func fetchTopHeadlines() async throws -> [NewDomainListDTO]
    func searchArticles() async throws -> [NewDomainListDTO]
}
