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
    var isError: Bool { get set }
    var error: String { get }
    func fetchArticles() async
    func shouldShowLoader() -> Bool
    var filteredArticles: [ArticleListItemViewModel] { get }
}

final class ArticleViewModel: ArticleViewModelProtocol {
    
    @Published var articles: [ArticleListItemViewModel]
    @Published var searchText: String
    @Published var isError: Bool
    @Published var error: String
    
    var isEmpty: Bool { return articles.isEmpty }
    var isSearching: Bool { return !searchText.isEmpty }
    
    private let articleListUseCase: ArticleListUseCase!
    private let pagingData = PagingData(itemsPerPage: 10, maxPageLimit: 5)
    
    init(useCase: ArticleListUseCase) {
        self.articleListUseCase = useCase
        self.articles = []
        self.searchText = ""
        self.isError = false
        self.error = ""
    }
    
    /// Fetches articles and catches error if any
    /// - Parameter category: category case
    @MainActor func fetchArticles() async {
        // TODO: Fetch per category.
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
    
    func shouldShowLoader() -> Bool {
        return (isEmpty && !isError)
    }
    
    /// Computed property to compute the filtered array for articles.
    var filteredArticles: [ArticleListItemViewModel] {
        guard !searchText.isEmpty else { return articles }
        return articles.filter { article in
            Log.debug(tag: ArticleViewModel.self, message: "Filtering article \(article.title)")
            return article.title.lowercased().contains(searchText.lowercased())
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
}
