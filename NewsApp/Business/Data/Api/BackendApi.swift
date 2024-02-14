//
//  NetworkApi.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 13/2/24.
//

import Foundation
import Alamofire

protocol BackendApiProtocol {
    func getArticles() -> DataRequest?
}

class BackendApi: ApiRestManager, BackendApiProtocol {
    private let saveKey = "Favorites"

    let apiUrl: String
    
    init(apiUrl: String) {
        self.apiUrl = apiUrl
        super.init(url: apiUrl)
    }
    
    private func makeUrl(forEndpoint endpoint: String) -> String {
        let apiKey = "978764b3fe6b412f8517a7d9c0a1e140"

        var components = URLComponents(string: apiUrl + endpoint)
        components?.queryItems = [URLQueryItem(name: "country", value: "us"), URLQueryItem(name: "apiKey", value: apiKey)]
        
        return components?.url?.absoluteString ?? ""
    }
    
    func getArticles() -> DataRequest? {
        let serviceURL = makeUrl(forEndpoint: "/top-headlines")
        print("Request URL: \(serviceURL)")
        return get(service: serviceURL)
    }
    
    func saveFavorite(_ id: Set<UUID>) {
        if let encoded = try? JSONEncoder().encode(id) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    func getFavorites() -> Set<UUID> {
        if let savedIDs = UserDefaults.standard.data(forKey: saveKey),
           let decodedIDs = try? JSONDecoder().decode(Set<UUID>.self, from: savedIDs) {
            return decodedIDs
        } else {
            return []
        }
    }
}
