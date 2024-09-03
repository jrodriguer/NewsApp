//
//  ArticleListService.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 3/9/24.
//

import Foundation

protocol ArticleListService {
    func fetchArticleListFromNetwork() async throws -> ArticlePageDataListDTO
}

final class DefaultArticleListService: ArticleListService {
    
    private let apiDataService: DataTransferService
    
    func fetchArticleListFromNetwork() async throws -> ArticlePageDataListDTO {
        <#code#>
    }
}
