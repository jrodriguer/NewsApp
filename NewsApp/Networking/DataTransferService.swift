//
//  DataTransferService.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 28/9/24.
//

import Foundation

protocol DataTransferService {
    func request<T: Decodable>(request: NetworkRequest) async throws -> T
}

final class DefaultDataTransferService: DataTransferService {

    private var networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func request<T>(request: any NetworkRequest) async throws -> T where T : Decodable {
        let data = try await networkManager.fetch(request: request)
        return try decode(data: data)
    }
    
    func decode<T>(data: Data) throws -> T where T : Decodable {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.unableToDecode
        }
    }
}
