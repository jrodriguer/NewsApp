//
//  DataTransferService.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 3/9/24.
//

import Foundation

protocol DataTransferService {
    func request<T: Decodable>(request: NetworkRequest) async throws -> T
}

final class DefaultDataTransferService: DataTransferService {
    
    /// Method to fetch data from Network Manager and Decode the data using decode method
    /// - Parameter request: Network request
    /// - Returns: Decodable type object
    func request<T>(request: any NetworkRequest) async throws -> T where T : Decodable {
        <#code#>
    }
    
    func decode<T>(data: Data) throws -> T where T : Decodable {
        do {
            
        } catch {
            throw NetworkError
        }
    }
}
