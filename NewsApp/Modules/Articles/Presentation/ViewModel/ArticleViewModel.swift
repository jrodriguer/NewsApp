//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import Foundation

class ArticleViewModel: ObservableObject {
    private let getArticleUseCase: GetArticleUseCase
    private let searchHistoryUseCase: ManageSearchHistoryUseCase
    private var totalArticlesAvailable: Int?
    private var articlesLoadedCount: Int?
    private var page = 1
    @Published var articles: [ArticleUIModel] = []
    @Published var isLoading = false
    @Published var isError = false
    @Published var errorMessage = ""
    @Published var searchQuery = ""
    @Published var recentSearches: [String] = []
        
    var isEmpty: Bool { return articles.isEmpty }
    
    init(getArticleUseCase: GetArticleUseCase, searchHistoryUseCase: ManageSearchHistoryUseCase) {
        self.getArticleUseCase = getArticleUseCase
        self.searchHistoryUseCase = searchHistoryUseCase
        
        Task {
            await loadRecentSearches()
        }
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
            let response = try await getArticleUseCase.fetchArticles(page: page)
            totalArticlesAvailable = response.map { $0.totalResults }.first
            let validatedResponse = response.filter { $0.title != "[Removed]" }
            let articleListResponse = transformFetchedArticles(validatedResponse)
            
            await MainActor.run {
                articles.append(contentsOf: articleListResponse)
                articlesLoadedCount = articles.count
                isLoading = false
                isError = false
            }
        } catch {
            isError = true
            errorMessage = error.localizedDescription
        }
    }
    
    /// Maps Articles to ArticleUIModel.
    /// - Parameter articles: array of Articles.
    /// Returns: array of ArticleUIModel
    private func transformFetchedArticles(_ articles: [Article]) -> [ArticleUIModel] {
        return articles.map { article in
            ArticleUIModel(
                id: article.id,
                source: article.source,
                author: article.author,
                title: article.title,
                description: article.description,
                link: article.url,
                publishedAt: article.publishedAt,
                content: article.content,
                image: article.urlToImage
            )
        }
    }
    
    /// Determines whether there is more data to load.
    private func moreItemsRemaining(_ articlesLoadedCount: Int, _ totalArticlesAvailable: Int) -> Bool {
        Log.debug(tag: ArticleViewModel.self, message: "More items remaining! Articles loaded: \(articlesLoadedCount), Total articles available: \(totalArticlesAvailable)")
        return articlesLoadedCount < totalArticlesAvailable
    }
    
    @MainActor
    private func loadRecentSearches() async {
        do {
            self.recentSearches = try await searchHistoryUseCase.getRecentSearches()
        } catch {
            print("Failed to load recent searches: \(error)")
        }
    }
    
    @MainActor
    private func addToRecentSearches(_ articleTitle: String) async {
        do {
            try await searchHistoryUseCase.addSearchTerm(articleTitle)
            // Reload the list
            self.recentSearches = try await searchHistoryUseCase.getRecentSearches()
        } catch {
            print("Failed to update recent searches: \(error)")
        }
    }
}
