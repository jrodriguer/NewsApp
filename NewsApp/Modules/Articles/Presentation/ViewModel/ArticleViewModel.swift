//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import Foundation

protocol ArticleViewModelProtocol: ObservableObject {
    var articles: [ArticleListItemViewModel] { get set }
    var showError: Bool {get}
    var error: String {get}
    var isEmpty: Bool {get}
    func fetchArticles() async
}

final class ArticleViewModel: ArticleViewModelProtocol {
    
    @Published var articles: [ArticleListItemViewModel] = []
    @Published var showError: Bool = false
    @Published var error: String = ""
    var isEmpty: Bool { return articles.isEmpty }
    
    private let articleListUseCase: ArticleListUseCase!
    
    init(useCase: ArticleListUseCase) {
        self.articleListUseCase = useCase
    }
    
    /// Fetches articles and catches error if any
    /// - Parameter category: category case
    @MainActor func fetchArticles() async {
        do {
            let articleList = try await articleListUseCase.fetchArticleList()
            self.articles = self.transformFetchedArticles(articleList)
            self.showError = false
        } catch {
            self.showError = true
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
                link: article.url,
                publishedAt: article.publishedAt.formatted(date: .long, time: .shortened),
                description: article.description ?? "Not description",
                image: article.urlToImage ?? nil
            )
        }
    }
}
