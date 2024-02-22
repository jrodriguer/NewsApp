//
//  BackendApi.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 13/2/24.
//

import Foundation
import Alamofire

protocol BackendApiProtocol {
    func getArticles() -> DataRequest?
    func getCharacters() -> DataRequest?
    func getLocations() -> DataRequest?
}

class BackendApi: ApiRestManager, BackendApiProtocol {
    private let saveKey = "Favorites"

    let apiUrl: String
    
    init(apiUrl: String) {
        self.apiUrl = apiUrl
        super.init(url: apiUrl)
    }
    
    func getArticles() -> DataRequest? {
        // TODO: Update way for get query params: apiKey, country.
        
        let apiKey = "978764b3fe6b412f8517a7d9c0a1e140"
        let serviceURL = "/v2/top-headlines/?country=us&apiKey=\(apiKey)"
        return get(service: serviceURL)
    }
    
    func getCharacters() -> DataRequest? {
        let serviceURL = "/api/character"
        return get(service: serviceURL)
    }
    
    func getLocations() -> DataRequest? {
        let serviceURL = "/api/location"
        return get(service: serviceURL)
    }
    
    func getEpisodes() -> DataRequest? {
        let serviceURL = "/api/episode"
        return get(service: serviceURL)
    }
    
    // TODO: User.default manager, not API in here.
    // TODO: Check saveKey, param (enum -> articles or characters).
    
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
