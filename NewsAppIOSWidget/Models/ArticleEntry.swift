//
//  ArticleEntry.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 17/11/24.
//

import Foundation
import WidgetKit

struct ArticleEntry: TimelineEntry {
    enum State {
        case articles([ArticleWidgetModel])
        case failure(String)
    }
    
    let date: Date
    let state: State
    let category: String
}
