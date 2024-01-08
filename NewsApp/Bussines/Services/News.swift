//
//  News.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 8/1/24.
//

import Foundation

class News {
    let apiKey = "978764b3fe6b412f8517a7d9c0a1e140"
    let baseUrl = "https://newsapi.org/v2"
    var headLinesPage = 0
    var categoryAct = ""
    var categoryPg = 0
    
    func startQuery(query: String) async throws -> TopHeadlines {
        let urlString = "\(baseUrl)\(query)&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NSError(domain: "Server Error", code: 0, userInfo: nil)
        }
        
        let decodedData = try JSONDecoder().decode(TopHeadlines.self, from: data)
        return decodedData
    }
    
    func getTopHeadLines(completion: @escaping (Result<TopHeadlines, Error>) -> Void) {
        //TODO: Write getTopHeadLines function
    }
    
    func getTopHeadLinesCategory(category: String, completion: @escaping (Result<TopHeadlines, Error>) -> Void) {
        //TODO: Write getTopHeadLinesCategory function
    }
}

struct TopHeadlines: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String
    // TODO: Updaate Article structure
}

Task {
    
}
