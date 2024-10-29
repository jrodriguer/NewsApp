//
//  NetworkSessionManager.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 18/10/24.
//
//  Description:
//  Default implementation of `NetworkSessionManager`, which handles data fetching using URLSession
//

import Foundation

final class DefaultNetworkSessionManager: NetworkSessionManager {
    
    private let session: URLSessionProtocol
    private let requestGenerator: URLRequestGenerator
    /// Initializes the session manager with specified session and request generator
    /// - Parameters:
    ///   - session: URLSession to use (defaults to shared session)
    ///   - requestGenerator: URLRequest generator to build URLRequests
    init(session: URLSessionProtocol = URLSession.shared,
         requestGenerator: URLRequestGenerator = DefaultURLRequestGenerator()) {
        self.session = session
        self.requestGenerator = requestGenerator
    }
    
    /// Sends a request and returns data and response, handling errors if they occur
    /// - Parameters:
    ///   - config: Network configuration
    ///   - request: Network request information
    /// - Returns: Tuple containing optional Data and URLResponse
    /// - Throws: NetworkError if the request fails
    func request(with config: NetworkConfigurable, request: NetworkRequest) async throws -> (Data?, URLResponse?) {
        let urlRequest = try requestGenerator.generateURLRequest(with: config, from: request)
        do {
            return try await session.asyncData(for: urlRequest)
        } catch {
            let resolvedError = NetworkError.resolve(error: error)
            Log.error(tag: DefaultNetworkSessionManager.self, message: "Network request failed", error: resolvedError)
            throw resolvedError
        }
    }
}
