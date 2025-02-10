//
//  ArticleListService.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 3/9/24.
//

import Foundation

protocol ArticleListService {
    func fetchArticleListFromNetwork(page: Int) async throws -> ArticlePageDataListDTO
}

final class DefaultArticleListService: ArticleListService {
    
    private let apiDataService: DataTransferService
    
    init(apiDataService: DataTransferService) {
        self.apiDataService = apiDataService
    }
    
    func fetchArticleListFromNetwork(page: Int) async throws -> ArticlePageDataListDTO {
        let productListNetworkRequest = DefaultNetworkRequest(
            path: EndpointApi.topHeadlines,
            method: .get,
            queryParameters: ["page": page]
        )
        Log.debug(tag: DefaultArticleListService.self, message: "Request: \(productListNetworkRequest)")
        return try await apiDataService.request(request: productListNetworkRequest)
    }
}
