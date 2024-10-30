//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 28/9/24.
//

import Foundation

/// A protocol to encapsulate the necessary network configuration, such as the base URL and any header common to each request.
protocol NetworkSessionManager {
    func request(with config: NetworkConfigurable, request: NetworkRequest) async throws -> (Data?, URLResponse?)
}
protocol NetworkManager {
    func fetch(request: NetworkRequest) async throws -> Data
}

final class DefaultNetworkManager: NetworkManager {
    
    private let networkConfig: NetworkConfigurable
    private let sessionManager: NetworkSessionManager
    
    init(networkConfig: NetworkConfigurable,
         sessionManager: NetworkSessionManager = DefaultNetworkSessionManager()) {
        self.networkConfig = networkConfig
        self.sessionManager = sessionManager
    }
    
    /// Method to fetch data from Session Manager and validates the data and response
    /// - Parameter request: Network Request
    /// - Returns: Data
    func fetch(request: NetworkRequest) async throws -> Data {
        do {
            let (data, response) = try await sessionManager.request(with: networkConfig, request: request)
            guard let response = response as? HTTPURLResponse else {
                Log.error(tag: DefaultNetworkManager.self, message:"Invalid response format")
                throw NetworkError.generic
            }
            
            switch response.statusCode {
            case 200...299:
                guard let data = data else {
                    Log.error(tag: DefaultNetworkManager.self, message:"No data received")
                    throw NetworkError.generic
                }
                return data
            case 401:
                throw NetworkError.unauthorized
            case 403:
                throw NetworkError.forbidden
            case 404:
                throw NetworkError.notFound
            case 500...599:
                throw NetworkError.serverError
            default:
                throw NetworkError.generic
            }
        } catch {
            // Handle and rethrow as NetworkError
            let networkError = NetworkError.resolve(error: error)
            Log.error(tag: DefaultNetworkManager.self, message: "Network error occurred", error: networkError)
            throw networkError
        }
    }
}
