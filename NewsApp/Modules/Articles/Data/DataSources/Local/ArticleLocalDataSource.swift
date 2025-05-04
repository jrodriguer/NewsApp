//
//  ArticleLocalDataSource.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 22/4/25.
//

import Foundation

class ArticleLocalDataSource  {
    private let userDefaults = UserDefaults.standard
    
    func getArticle(forArticle article: String) throws -> ArticleLocal? {
        guard let data = userDefaults.data(forKey: "article_\(article.lowercased())") else {
            return nil
        }
        return try JSONDecoder().decode(ArticleLocal.self, from: data)
    }
    
    func saveArticle(_ article: ArticleLocal) throws {
        let data = try JSONEncoder().encode(article)
        userDefaults.set(data, forKey: "weather_\(article.title.lowercased())")
    }
}
