//
//  ArticleLocalDataSource.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 22/4/25.
//

import Foundation

class ArticleLocalDataSource  {
    private let userDefaults = UserDefaults.standard
    
    func saveArticles(_ articles: [ArticleLocal]) throws {
        let encodedArticles = try JSONEncoder().encode(articles)
        userDefaults.set(encodedArticles, forKey: "articles")
    }
}
