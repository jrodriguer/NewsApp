//
//  ArticleView_Previews.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/1/25.
//

import SwiftUI

extension ArticleView_Previews {
    static func getViewModel() -> ArticleListItemViewModelMock {
        return ArticleListItemViewModelMock()
    }
    
    class ArticleListItemViewModelMock: ArticleViewModelProtocol {
        
        func shouldShowLoader() -> Bool {isEmpty && isError}
        
        var articles: [ArticleListItemViewModel] = [.init(
            id: UUID(),
            source: "The Washington Post",
            title: "Americans see disparities in mental and physical care, survey finds - The Washington Post",
            link: "https://www.washingtonpost.com/wellness/2024/05/27/mental-health-treatment-disparity/",
            publishedAt: "2024-05-27T12:30:00Z")
        ]
        
        var isEmpty: Bool { return articles.isEmpty }
        var isError: Bool = false
        var error: String = "Error"
        func fetchArticles() async { }
    }
}
