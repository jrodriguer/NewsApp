//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import Foundation

protocol ArticleViewModelProtocol: ObservableObject {
    var articles: [ArticleListItemViewModel] { get set }
    var isError: Bool { get }
    var error: String { get }
    var isEmpty: Bool { get }
    func shouldShowLoader() -> Bool
    func fetchArticles() async
}

final class ArticleViewModel: ArticleViewModelProtocol {
    
    @Published var articles: [ArticleListItemViewModel]
    @Published var isError: Bool
    @Published var error: String
    
    var isEmpty: Bool { return articles.isEmpty }
    
    private let articleListUseCase: ArticleListUseCase!
    private let pagingData = PagingData(itemsPerPage: 10, maxPageLimit: 5)
    
    init(useCase: ArticleListUseCase) {
        self.articleListUseCase = useCase
        self.articles = []
        self.isError = false
        self.error = ""
    }
    
    /// Fetches articles and catches error if any
    /// - Parameter category: category case
    @MainActor func fetchArticles() async {
        // TODO: Fetch per category (next version).
        do {
            let newArticles = try await pagingData.loadNextPage { page in
                try await self.articleListUseCase.fetchArticleList(page: page, itemsPerPage: self.pagingData.itemsPerPage)
            }
            articles.append(contentsOf: transformFetchedArticles(newArticles))
            isError = false
            Log.debug(tag: ArticleViewModel.self, message: "Articles fetched successfully, \(articles.count)")
        } catch {
            isError = true
            
            if let networkError = error as? NetworkError {
                self.error = networkError.description
            } else {
                self.error = error.localizedDescription
            }
            
        }
    }
    
    /// Maps Articles to ArticleListItemViewModel
    /// - Parameter articles: array of Articles
    /// Returns: array of ArticleListItemViewModel
    private func transformFetchedArticles(_ articles: [ArticleDomainListDTO]) -> [ArticleListItemViewModel] {
        return articles.map { article in
            ArticleListItemViewModel(
                id: article.articleId,
                source: article.source,
                author: article.author,
                title: article.title,
                description: article.description,
                link: article.url,
                publishedAt: article.publishedAt.formatted(date: .long, time: .shortened),
                content: article.content,
                image: article.urlToImage
            )
        }
    }
    
    func shouldShowLoader() -> Bool {
        return (isEmpty && !isError)
    }
}
