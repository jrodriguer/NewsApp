//
//  ArticleView_Previews.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/1/25.
//

import SwiftUI

extension ArticleView_Previews {
    static func getViewModel() -> ArticleViewModelMock {
        return ArticleViewModelMock()
    }
    
    class ArticleViewModelMock: ArticleViewModelProtocol {
        
        // MARK: - Mock Data
        var articles: [ArticleListItemViewModel] = [
            .init(
                id: UUID(),
                source: "The Washington Post",
                title: "Americans see disparities in mental and physical care, survey finds - The Washington Post",
                link: "https://www.washingtonpost.com/wellness/2024/05/27/mental-health-treatment-disparity/",
                publishedAt: "2024-05-27T12:30:00Z"
            )
        ]
        
        var searchText: String = "The"
        var isError: Bool = false
        var error: String = "Error"
        
        // MARK: - Computed Properties
        var isEmpty: Bool { articles.isEmpty }
        
        var filteredArticles: [ArticleListItemViewModel] {
            guard !searchText.isEmpty else { return articles }
            return articles.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        
        // MARK: - Protocol Methods
        func shouldShowLoader() -> Bool {
            isEmpty && !isError
        }
        
        func loadFirstPage() async { }
    }
}
