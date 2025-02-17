//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import Foundation

protocol ArticleViewModelProtocol: ObservableObject {
    var articles: [ArticleListItemViewModel] { get set }
    var isEmpty: Bool { get }
    var isLoading: Bool { get }
    var isError: Bool { get }
    var error: String { get }
    func loadFirstPage()
    func requestMoreItemsIfNeeded()
    func shouldShowLoader() -> Bool
}

class ArticleViewModel: ArticleViewModelProtocol {

    @Published var articles: [ArticleListItemViewModel] = []
    @Published var isLoading = false
    @Published var isError = false
    @Published var error = ""
        
    var isEmpty: Bool { return articles.isEmpty }
        
    private var totalArticlesAvailable: Int?
    private var articlesLoadedCount: Int?
    private var page = 1
    
    private let articleListUseCase: ArticleListUseCase!
    
    init(useCase: ArticleListUseCase) {
        self.articleListUseCase = useCase
    }
    
    func shouldShowLoader() -> Bool {
        return (isEmpty && !isError)
    }
    
    func loadFirstPage() {
        page = 1
        Task {
            await fetchArticles(page: page)
        }
    }
    
    func requestMoreItemsIfNeeded() {
        guard let articlesLoadedCount = articlesLoadedCount,
              let totalArticlesAvailable = totalArticlesAvailable, !isLoading else {
            return
        }
        
        isLoading = true
        
        if moreItemsRemaining(articlesLoadedCount, totalArticlesAvailable) {
            page += 1
            Log.debug(tag: ArticleViewModel.self, message: "To fetch more items. Page: \(page)")
            Task {
                await fetchArticles(page: page)
            }
        }
    }
    
    /// Fetches articles and catches error if any.
    /// - Parameter page.
    private func fetchArticles(page: Int) async {
        isLoading = true
        do {
            let response = try await articleListUseCase.fetchArticleList(page: page)
            totalArticlesAvailable = response.map { $0.totalResults }.first
            let validatedResponse = response.filter { $0.title != "[Removed]" }
            let newArticles = transformFetchedArticles(validatedResponse)
            
            await MainActor.run {
                articles.append(contentsOf: newArticles)
                articlesLoadedCount = articles.count
                isLoading = false
                isError = false
            }
        } catch {
            isError = true
            
            if let networkError = error as? NetworkError {
                self.error = networkError.description
            } else {
                self.error = error.localizedDescription
            }
        }
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
//    private func thresholdMeet(_ articlesLoadedCount: Int, _ index: Int) -> Bool {
//        Log.debug(tag: ArticleViewModel.self, message: "\(articlesLoadedCount - index == articlesFromEndThreshold ? "Threshold met!" : "Threshold not met!")")
//        return (articlesLoadedCount - index) == articlesFromEndThreshold
//    }
    
    /// Determines whether there is more data to load.
    private func moreItemsRemaining(_ articlesLoadedCount: Int, _ totalArticlesAvailable: Int) -> Bool {
        Log.debug(tag: ArticleViewModel.self, message: "More items remaining! Articles loaded: \(articlesLoadedCount), Total articles available: \(totalArticlesAvailable)")
        return articlesLoadedCount < totalArticlesAvailable
    }
}
