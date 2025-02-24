//
//  URLSessionProtocol.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 18/10/24.
//

import Foundation

protocol URLSessionProtocol {
    func asyncData(for request: URLRequest) async throws -> (Data?, URLResponse?)
}

extension URLSession: URLSessionProtocol {
    
    func asyncData(for request: URLRequest) async throws -> (Data?, URLResponse?) {
        return try await self.data(for: request)
    }
}
