//
//  ArticleWidgetModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/5/24.
//

import Foundation

struct ArticleWidgetModel: Identifiable {
    enum State {
        case placeholder
        case article(article: ArticleApiObject, imageData: Data?)
    }
    
    let state: State
    
    var id: UUID {
        switch state {
        case .placeholder:
            return UUID()
        case .article(let article, _):
            return article.id
        }
    }
}
