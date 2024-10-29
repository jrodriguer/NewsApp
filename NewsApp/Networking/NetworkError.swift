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
    case unableToDecode
    case notConnected
    case badHostname
    case timeout            // HTTP timeout
    case unauthorized       // HTTP 401
    case forbidden          // HTTP 403
    case notFound           // HTTP 404
    case serverError        // HTTP 500-599
    
    /// A human-readable description of each error case.
    var description: String {
        switch self {
        case .unableToDecode: return "Response can't be decoded"
        case .notConnected: return "The internet connection appears to be offline"
        case .badHostname: return "The specified hostname for this server could not be found"
        case .unauthorized: return "Unauthorized access"
        case .forbidden: return "Access is forbidden"
        case .notFound: return "Requested resource not found"
        case .serverError: return "Server encountered an error"
        case .timeout: return "Request timed out"
        }
    }
    
    /// Resolves a generic Error or HTTP status code into a specific NetworkError case.
    ///
    /// - Parameter error: The error to resolve.
    /// - Returns: A NetworkError case corresponding to the specific error.
    static func resolve(error: Error) -> NetworkError {
        let nsError = error as NSError
        // Map URLError cases first
        let urlErrorCode = URLError.Code(rawValue: nsError.code)
        switch urlErrorCode {
        case .notConnectedToInternet:
            Log.error(tag: NetworkError.self, message: "No internet connection detected", error: error)
            return .notConnected
        case .cannotFindHost:
            Log.error(tag: NetworkError.self, message: "Host not found", error: error)
            return .badHostname
        case .timedOut:
            Log.warning(tag: NetworkError.self, message: "Request timed out")
            return .timeout
        default:
            break
        }
        
        if let httResponse = nsError.userInfo["statusCode"] as? Int {
            switch httResponse {
            case 401:
                Log.error(tag: NetworkError.self, message: "Unauthorized access", error: error)
                return .unauthorized
            case 403:
                Log.warning(tag: NetworkError.self, message: "Forbidden access")
                return .forbidden
            case 404:
                Log.info(tag: NetworkError.self, message: "Resource not found")
                return .notFound
            case 500...599:
                Log.error(tag: NetworkError.self, message: "Server encountered an error", error: error)
                return .serverError
            default:
                break
            }
        }
    }
}
