//
//  NetworkError.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 3/9/24.
//

import Foundation

enum NetworkError: Error {
    case unableToDecode
    case notConnected
    case badHostname
    case generic
    
    var description: String {
        switch self {
        case .unableToDecode: return "Response can't be decoded"
        case .notConnected: return "The internet connection appears to be offline"
        case .badHostname: return "The specified hostname for this server could not be found"
        case .generic: return "Something went wrong"
        }
    }
    
    static func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .notConnected
        case .cannotFindHost: return .badHostname
        default: return .generic
        }
    }
}
