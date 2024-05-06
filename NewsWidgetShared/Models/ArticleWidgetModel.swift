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
    
    var title: String {
        switch state {
        case .placeholder:
            return "This is a placeholder text for News App"
        case .article(let article, _):
            return article.title
        }
    }
    
    var subtitle: String {
        switch state {
        case .placeholder:
            return "This is a placeholder text for News App"
        case .article(let article, _):
            return article.descriptionField
        }
    }
    
    var url: URL {
        switch state {
        case .placeholder:
            return URL(string: "xcanewsapp://home")!
        case .article(let article, _):
            return article.articleURL
        }
    }
    
    var isPlaceholder: Bool {
        if case .placeholder = state {
            return true
        }
        
        return false
    }
    
    var article: ArticleApiObject? {
        if case .article(let article, _) = state {
            return article
        }
        
        return nil
    }
    
    var imageData: Data? {
        if case .article(_, let imageData) = state {
            return imageData
        }
        
        return nil
    }
}
