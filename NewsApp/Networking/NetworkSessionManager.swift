//
//  NetworkSessionManager.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 18/10/24.
//

import Foundation

final class DefaultNetworkSessionManager: NetworkSessionManager {
    
    private let session: URLSessionProtocol
    private let requestGenerator: URLRequestGenerator
    
    init(session: URLSessionProtocol = URLSession.shared,
         requestGenerator: URLRequestGenerator = DefaultURLRequestGenerator()) {
        self.session = session
        self.requestGenerator = requestGenerator
    }
    
    /// Method to get data and response from URLSession
    /// - Parameters:
    ///   - config: Network config
    ///   - request: Network request
    /// - Returns: Data and Response
    func request(with config: NetworkConfigurable, request: NetworkRequest) async throws -> (Data?, URLResponse?) {
        let urlRequest = try requestGenerator.generateURLRequest(with: config, from: request)
        do {
            return try await session.asyncData(for: urlRequest)
        } catch {
            throw NetworkError.resolve(error: error)
        }
    }
}
