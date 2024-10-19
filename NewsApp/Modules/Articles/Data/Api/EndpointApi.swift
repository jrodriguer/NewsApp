//
//  EndpointApi.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 28/9/24.
//

import Foundation

struct EndpointApi {
    static let apiKey: String = "978764b3fe6b412f8517a7d9c0a1e140"
    static let versionApi: String = "/v2"
    static let topHeadlines: String = "\(versionApi)/top-headlines&apiKey=\(apiKey)"
}
