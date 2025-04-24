//
//  NewsRemoteDataSource.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 22/4/25.
//

import Foundation

class NewsRemoteDataSource {
    
    private let apiKey = "978764b3fe6b412f8517a7d9c0a1e140"
    private let baseURL = "https://newsapi.org/v2/"
    
    func getEverything(of query: String) async throws -> ArticlePageDataListDTO {
        guard let url = URL(string: "\(baseURL)everything?q=\(query)&apiKey=\(apiKey)") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        return try JSONDecoder().decode(ArticlePageDataListDTO.self, from: data)
    }
    
    func getTopHeadlines() async throws -> ArticlePageDataListDTO {
        guard let url = URL(string: "\(baseURL)top-headlines?apiKey=\(apiKey)") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        return try JSONDecoder().decode(ArticlePageDataListDTO.self, from: data)
    }
}

enum APIError: Error {
    case invalidResponse
    case decodingFailed
}
