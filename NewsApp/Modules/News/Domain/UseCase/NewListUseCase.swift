//
//  NewListUseCase.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 2/9/24.
//

import Foundation

protocol NewListUseCase {
    func fetchNewList() async throws -> [NewDomainListDTO]
}

final class DefaultNewListUseCase: NewListUseCase {
    
    private let repository: NewListRepository
    
    init(repository: NewListRepository) {
        self.repository = repository
    }
    
    func fetchNewList() async throws -> [NewDomainListDTO] {
        try await repository.fetchTopHeadlines()
    }
}
