//
//  BackendApi.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 13/2/24.
//

import Foundation
import Alamofire

protocol BackendApiProtocol {
    func getTopHeadLinesArticles(category: Category?) -> DataRequest?
    func getEverythingArticles() -> DataRequest?
}

class BackendApi: ApiRestManager, BackendApiProtocol {
    let apiUrl: String
    
    init(apiUrl: String) {
        self.apiUrl = apiUrl
        super.init(url: apiUrl)
    }
        
    func getTopHeadLinesArticles(category: Category?) -> DataRequest? {
        let apiKey = "978764b3fe6b412f8517a7d9c0a1e140"
        var serviceURL: String = "/v2/top-headlines?country=us&apiKey=\(apiKey)"
        
        if let category = category {
            serviceURL += "&category=\(category.rawValue)"
        }
        return get(service: serviceURL)
    }
    
    func getEverythingArticles() -> DataRequest? {
        let apiKey = "978764b3fe6b412f8517a7d9c0a1e140"
        var serviceURL: String = "/v2/everything&apiKey=\(apiKey)"
        
        return get(service: serviceURL)
    }
}
