//
//  ArticleRemoteDataSource.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 22/4/25.
//

import Foundation

class ArticleRemoteDataSource {
    
    private let apiKey = "978764b3fe6b412f8517a7d9c0a1e140"
    private let baseURL = "https://newsapi.org/v2/"
    
    func fetchArticlesByQuery(_ query: String) async throws -> ArticlePageListDTO {
        guard let url = URL(string: "\(baseURL)everything?q=\(query)&apiKey=\(apiKey)") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        return try JSONDecoder().decode(ArticlePageListDTO.self, from: data)
    }
    
    func fetchTrendingArticles(page: Int) async throws -> ArticlePageListDTO {
        guard let url = URL(string: "\(baseURL)top-headlines?page=\(page)&apiKey=\(apiKey)") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        return try JSONDecoder().decode(ArticlePageListDTO.self, from: data)
    }
}

enum APIError: Error {
    case invalidResponse
    case decodingFailed
}
