//
//  ApiRestManager.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import Foundation

class ApiRestManager {
    private let saveKey = "Favorites"
    private let networkService: NetworkService

    init(networkService: NetworkService = .shared) {
        self.networkService = networkService
    }
    
    func loadList<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        networkService.request(endpoint, completion: completion)
    }
    
    /*func load<T: Decodable>(_ filename: String) -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }*/
    
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
