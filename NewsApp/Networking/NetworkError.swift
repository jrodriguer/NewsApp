//
//  NetworkError.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 3/9/24.
//
//  Description:
//  NetworkError defines and handles common network-related errors in the application.
//  It provides error cases with corresponding descriptions to support more effective
//  debugging and user feedback during network requests.
//

import Foundation

/// Enum representing different types of network errors.
enum NetworkError: Error {
    
    /// Specific network error cases.
    case badURL
    case unableToDecode
    case notConnected
    case badHostname
    case unauthorized       // HTTP 401
    case forbidden          // HTTP 403
    case notFound           // HTTP 404
    case serverError        // HTTP 500-599
    case timeout            // HTTP timeout
    case generic            // Unclassified error
    
    /// A human-readable description of each error case.
    var description: String {
        switch self {
        case .badURL: return "Bad URL"
        case .unableToDecode: return "Response can't be decoded"
        case .notConnected: return "The internet connection appears to be offline"
        case .badHostname: return "The specified hostname for this server could not be found"
        case .unauthorized: return "Unauthorized access"
        case .forbidden: return "Access is forbidden"
        case .notFound: return "Requested resource not found"
        case .serverError: return "Server encountered an error"
        case .timeout: return "Request timed out"
        case .generic: return "Something went wrong"
        }
    }
    
    /// Resolves a generic Error or HTTP status code into a specific NetworkError case.
    ///
    /// - Parameter error: The error to resolve.
    /// - Returns: A NetworkError case corresponding to the specific error.
    static func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .notConnected
        case .cannotFindHost: return .badHostname
        default: return .generic
        }
    }
}
