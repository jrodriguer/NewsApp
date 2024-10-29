//
//  DataTransferService.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 28/9/24.
//
//  Description:
//  Acts as a general service to interact with the backend.
//  It wraps the NetworkManager and facilitates the communication of data to and from the API in an abstract way.

import Foundation

/// Through this interface, the application requests and receives data in a comprehensible and simplified way.
protocol DataTransferService {
    func request<T: Decodable>(request: NetworkRequest) async throws -> T
}

final class DefaultDataTransferService: DataTransferService {

    private var networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    /// Method to fetch data from Network Manager and Decode the data using decode method
    /// - Parameter request:  Network request
    /// - Returns: Decodable type object
    func request<T>(request: any NetworkRequest) async throws -> T where T : Decodable {
        let data = try await networkManager.fetch(request: request)
        Log.debug(tag: DataTransferService.self, message: "Data fetched from Network Manager: \(data)")
        return try decode(data: data)
    }
    
    /// Method to decode data using JSONDecoder
    /// - Parameter data: Data
    /// - Returns: Decodable type object
    func decode<T>(data: Data) throws -> T where T : Decodable {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            Log.debug(tag: DataTransferService.self, message: "Data decoded: \(decodedData)")
            return decodedData
        } catch {
            throw NetworkError.unableToDecode
        }
    }
}
