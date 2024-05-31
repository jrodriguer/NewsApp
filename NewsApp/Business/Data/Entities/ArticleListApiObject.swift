//
//  ArticleListApiObject.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 31/5/24.
//

import Foundation

struct ArticleListApiObject: Decodable {
    let status: String
    let totalResults: Int
    let articles: [ArticleApiObject]
}
