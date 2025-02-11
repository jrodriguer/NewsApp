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
    var filteredArticles: [ArticleListItemViewModel] { get }
    func loadFirstPage()
    func requestMoreItemsIfNeeded(for index: Int)
    func shouldShowLoader() -> Bool
}

final class ArticleViewModel: ArticleViewModelProtocol {

    @Published var articles: [ArticleListItemViewModel]
    @Published var searchText: String
    
    @Published var isError: Bool
    @Published var error: String
    
    // FIXME: Clean flags.
    var isEmpty: Bool { return articles.isEmpty }
    
    private let articlesFromEndThreshold: Int
    
    private var totalArticlesAvailable: Int?
    private var articlesLoadedCount: Int?
    private var page: Int
    
    private let articleListUseCase: ArticleListUseCase!
    
    init(useCase: ArticleListUseCase) {
        self.articleListUseCase = useCase
        self.articlesFromEndThreshold = 15
        self.page = 0
        self.articles = []
        self.searchText = ""
        self.isError = false
        self.error = ""
    }
    
    func shouldShowLoader() -> Bool {
        return (isEmpty && !isError)
    }
    
    func loadFirstPage() {
        page = 0
        Task { @MainActor in
            await fetchArticles(page: page)
        }
    }
    
    func requestMoreItemsIfNeeded(for index: Int) {
        guard let articlesLoadedCount = articlesLoadedCount,
              let totalArticlesAvailable = totalArticlesAvailable else {
            return
        }
        
        if thresholdMeet(articlesLoadedCount, index) &&
            moreItemsRemaining(articlesLoadedCount, totalArticlesAvailable) {
            Log.debug(tag: ArticleViewModel.self, message: "Index: \(index), requesting more items...")
            page += 1
            Task { @MainActor in
                await fetchArticles(page: page)
            }
        }
    }
    
    /// Fetches articles and catches error if any.
    /// - Parameter page.
    @MainActor private func fetchArticles(page: Int) async {
        
        // FIXME: Infinite scrolling.
        
        do {
            let response = try await articleListUseCase.fetchArticleList(page: page)
            totalArticlesAvailable = response.map { $0.totalResults }.first
            let validatedResponse = response.filter { $0.title != "[Removed]" }
            let newArticles = transformFetchedArticles(validatedResponse)
            
            articles.append(contentsOf: newArticles)
            articlesLoadedCount = articles.count

            isError = false
        } catch {
            isError = true
            
            if let networkError = error as? NetworkError {
                self.error = networkError.description
            } else {
                self.error = error.localizedDescription
            }
        }
        
    }
    
    /// Computed property to compute the filtered array for articles.
    var filteredArticles: [ArticleListItemViewModel] {
        guard !searchText.isEmpty else { return articles }
        let lowercasedSearchText = searchText.lowercased()
        return articles.filter { $0.title.lowercased().contains(lowercasedSearchText) }
    }
    
    /// Maps Articles to ArticleListItemViewModel.
    /// - Parameter articles: array of Articles.
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
    
    /// Determines whether we have meet the threshold for requesting more items.
    /// - Parameter articlesLoadedCount.
    /// - Parameter index.
    /// Returns: the truth that the difference of all items except the index is equal to the threshold.
    private func thresholdMeet(_ articlesLoadedCount: Int, _ index: Int) -> Bool {
        return (articlesLoadedCount - index) == articlesFromEndThreshold
    }
    
    /// Determines whether there is more data to load.
    private func moreItemsRemaining(_ itemsLoadedCount: Int, _ totalItemsAvailable: Int) -> Bool {
        return itemsLoadedCount < totalItemsAvailable
    }
}
