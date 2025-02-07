//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import Foundation

protocol ArticleViewModelProtocol: ObservableObject {
    var articles: [ArticleListItemViewModel] { get set }
    var searchText: String { get set }
    var isEmpty: Bool { get }
    var isError: Bool { get }
    var error: String { get }
    func loadFirstPage() async
    func shouldShowLoader() -> Bool
    var filteredArticles: [ArticleListItemViewModel] { get }
}

final class ArticleViewModel: ArticleViewModelProtocol {
    
    @Published var articles: [ArticleListItemViewModel]
    @Published var searchText: String
    @Published var isError: Bool
    @Published var error: String
    
    // FIXME: Clean flags.
    var isEmpty: Bool { return articles.isEmpty }
    var isSearching: Bool { return !searchText.isEmpty }

    private let articleListUseCase: ArticleListUseCase!
    
    init(useCase: ArticleListUseCase) {
        self.articleListUseCase = useCase
        self.articles = []
        self.searchText = ""
        self.isError = false
        self.error = ""
    }
    
    func shouldShowLoader() -> Bool {
        return (isEmpty && !isError)
    }
    
    /// Fetches articles and catches error if any
    /// - Parameter category: category case
    @MainActor func loadFirstPage() async {
        // FIXME: Infinite scrolling.
        do {
            await self.articleListUseCase.reset()
            
            let newArticles = try await self.articleListUseCase.fetchArticleList(itemsPerPage: 10, page: 1)
            articles.append(contentsOf: transformFetchedArticles(
                newArticles.filter { $0.title != "[Removed]" }
            ))
            isError = false
        } catch {
            isError = true
            
//            if let networkError = error as? NetworkError {
//                self.error = networkError.description
//            } else {
//                self.error = error.localizedDescription
//            }
            
            handlerError(error)
        }
    }
    
    func loadNextPage() async {
        do {
            let nextArticles = try await self.articleListUseCase.fetchArticleList(itemsPerPage: 10, page: 1)
            articles.append(contentsOf: transformFetchedArticles(
//                nextArticles.filter { $0.title != "[Removed]" }
                cleanArticles(for: nextArticles)
            ))
            
            isError = false
        } catch {
            isError = true

            handlerError(error)
        }
    }
    
    /// Computed property to compute the filtered array for articles.
    var filteredArticles: [ArticleListItemViewModel] {
        guard !searchText.isEmpty else { return articles }
        let lowercasedSearchText = searchText.lowercased()
        return articles.filter { $0.title.lowercased().contains(lowercasedSearchText) }
    }
    
    private func cleanArticles(for articles: [ArticleDomainListDTO]) -> [ArticleDomainListDTO] {
        articles.filter { $0.title != "[Removed]" }
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
    
    private func handlerError(_ error: Error) {
        Log.error(tag: ArticleViewModel.self, message: "Error: \(error)")
        
        if let networkError = error as? NetworkError {
            self.error = networkError.description
        } else {
            self.error = error.localizedDescription
        }
    }
}
