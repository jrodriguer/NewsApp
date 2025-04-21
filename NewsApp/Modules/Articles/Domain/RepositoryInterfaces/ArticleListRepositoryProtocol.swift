//
//  ArticleListRepositoryProtocol.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 2/9/24.
//

import Foundation

protocol ArticleListRepository {
    func fetchArticleList(page: Int) async throws -> [ArticleDomainListDTO]
}
