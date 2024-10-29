//
//  URLRequestGenerator.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 18/10/24.
//

import Foundation

/// Protocol that defines the requirements for generating a URLRequest from network configuration and request information
protocol URLRequestGenerator {
    func generateURLRequest(with config: NetworkConfigurable, from request: NetworkRequest) throws -> URLRequest
}

final class DefaultURLRequestGenerator: URLRequestGenerator {
    
    /// Generates a URLRequest with specified network configuration and request data
    /// - Parameters:
    ///   - config: Network configuration
    ///   - request: Network request information
    /// - Returns: Configured URLRequest
    func generateURLRequest(with config: NetworkConfigurable, from request: NetworkRequest) throws -> URLRequest {
        let url = try createURL(with: config, from: request)
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        // Set HTTP method and body if available
        urlRequest.httpMethod = request.method.rawValue
        if !request.bodyParameters.isEmpty {
            do {
                let bodyData = try JSONSerialization.data(withJSONObject: request.bodyParameters,
                                                           options: [.prettyPrinted])
                urlRequest.httpBody = bodyData
            } catch {
                throw NetworkError.unableToDecode
            }
        }
        config.headers.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        return urlRequest
    }
    
    /// Creates and validates a URL from network configuration and request data
    /// - Parameters:
    ///   - config: Network configuration containing base URL and other settings
    ///   - request: Network request with path and query parameters
    /// - Returns: Fully composed URL
    /// - Throws: `NetworkError.badURL` if URL composition fails
    private func createURL(with config: NetworkConfigurable, from request: NetworkRequest) throws -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = config.baseURL
        components.path = request.path.hasPrefix("/") ? request.path : "/" + request.path
        
        var queryParameters = request.queryParameters.map { URLQueryItem(name: $0, value: "\($1)") }
        queryParameters.append(URLQueryItem(name: "country", value: AppConfiguration.countryCode))
        queryParameters.append(URLQueryItem(name: "country", value: AppConfiguration.apiKey))
        components.queryItems = queryParameters
        
        guard let url = components.url else {
            Log.error(tag: DefaultURLRequestGenerator.self, message: "Failed to create URL from components")
            throw NetworkError.badHostname
        }
        Log.debug(tag: DefaultURLRequestGenerator.self, message: "URL created: \(url.absoluteString)")
        return url
    }
}
