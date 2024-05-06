//
//  ArticleEntry.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/5/24.
//

import Foundation
import WidgetKit

struct ArticleEntry: TimelineEntry {
    enum State {
        case articles([ArticleWidgetModel])
        case failure(Error)
    }
    
    let date: Date
    let state: State
    let category: Category
}
