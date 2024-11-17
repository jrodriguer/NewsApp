//
//  ArticleProvider.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 17/11/24.
//

import Foundation
import WidgetKit

struct ArticleProvider: TimelineProvider {
    
    private let viewModel: ArticleViewModel
    
    init() {
        // MARK: - Config the use case with the right repository.
        let repository = DefaultArticleListRepository()
        let useCase = DefaultArticleListUseCase(repository: repository)
        self.viewModel = ArticleViewModel(useCase: useCase)
    }
    
    func placeholder(in context: Context) -> ArticleEntry {
        ArticleEntry(
            date: Date(),
            state: .articles([]),
            category: "Placeholder"
        )
    }
    
    func getSnapshot(in context: Context, completion: @escaping (ArticleEntry) -> Void) {
        Task {
            let entry = await fetchEntry(category: "General")
            completion(entry)
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ArticleEntry>) -> Void) {
        Task {
            let entry = await fetchEntry(category: "General")
            let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(3600)))
            completion(timeline)
        }
    }
    
    private func fetchEntry(category: String) async -> ArticleEntry {
        do {
            await viewModel.fetchArticles()
            let widgetModels = viewModel.transformToWidgetModels()
            return ArticleEntry(date: Date(), state: .articles(widgetModels), category: category)
        } catch {
            return ArticleEntry(date: Date(), state: .failure(error.localizedDescription), category: category)
        }
    }
}
