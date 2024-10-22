//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import Foundation

protocol ArticleViewModelProtocol: ObservableObject {
    var articles: [ArticleListItemViewModel] { get set }
    var isError: Bool {get}
    var error: String {get}
    var isEmpty: Bool {get}
    func fetchArticles(category: Category?) async
}

final class ArticleViewModel: ArticleViewModelProtocol {
    
    @Published var articles: [ArticleListItemViewModel] = []
    @Published var isError: Bool = false
    @Published var error: String = ""
    var isEmpty: Bool { return articles.isEmpty }
    private let articleListUseCase: ArticleListUseCase!
    
    init(useCase: ArticleListUseCase) {
        self.articleListUseCase = useCase
    }
    
    /// Fetches articles, transform and catches error if any
    /// - Parameter category: category case
    @MainActor func fetchArticles(category: Category? = nil) async {
        do {
            let articleList = try await articleListUseCase.fetchArticleList()
            self.articles = self.transformFetchedArticles(articleList)
            self.isError = false
        } catch {
            self.isError = true
            if let networkError = error as? NetworkError {
                self.error = networkError.description
            } else {
                self.error = error.localizedDescription
            }
        }
    }
    
    func transformFetchedArticles(_ articles: [ArticleDomainListDTO]) -> [ArticleListItemViewModel] {
        return articles.map { article in
            ArticleListItemViewModel(
                id: article.articleId,
                title: article.title ?? "Not title",
                link: article.url.absoluteString,
                publishedAt: article.publishedAt.formatted(date: .long, time: .shortened),
                author: article.author ?? "Not author",
                description: article.description ?? "Not description",
                image: article.urlToImage?.absoluteString
            )
        }
    }
}
