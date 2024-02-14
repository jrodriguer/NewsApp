//
//  NetworkApi.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 13/2/24.
//

import Foundation

protocol BackendApiProtocol {
    func getArticles() -> DataRequest?
}

class BackendApi: ApiRestManager, BackendApiProtocol {
    let apiUrl: String
    
    init(apiUrl: String) {
        self.apiUrl = apiUrl
        super.init(url: apiUrl)
    }
    
    private func makeUrl(forEndpoint endpoint: String) -> String {
        return apiUrl + endpoint
    }
    
    func getArticles() -> DataRequest? {
        let serviceURL = makeUrl(forEndpoint: "https://newsapi.org/v2/top-headlines?country=us&apiKey=978764b3fe6b412f8517a7d9c0a1e140")
        return get(service: serviceURL)
    }
}
