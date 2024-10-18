//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 28/9/24.
//

import Foundation

protocol NetworkSessionManager {
    func request(with config: NetworkConfigurable, request: NetworkRequest) async throws -> (Data?, URLResponse?)
}
protocol NetworkManager {
    func fetch(request: NetworkRequest) async throws -> Data
}

final class DefaultNetworkManager: NetworkManager {
    
    private let networkConfig: NetworkConfigurable
    private let sessionManager: NetworkSessionManager
    
    init(networkConfig: NetworkConfigurable, sessionManager: NetworkSessionManager = DefaultNetworkSessionManager()) {
        self.networkConfig = networkConfig
        self.sessionManager = sessionManager
    }
    
    /// Method to fetch data from Session Manager and validates the data and response
    /// - Parameter request: Network Request
    /// - Returns: Data
    func fetch(request: NetworkRequest) async throws -> Data {
        return Data()
    }
}
