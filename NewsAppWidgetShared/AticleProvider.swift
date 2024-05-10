//
//  AticleProvider.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/5/24.
//

import Foundation
import WidgetKit

struct ArticleProvider: IntentTimelineProvider {
    typealias Entry = ArticleEntry
    typealias Intent = SelectCategoryIntent
    
    func placeholder(in context: Context) -> ArticleEntry {
        .placeholder
    }
    
    func getSnapshot(for configuration: SelectCategoryIntent, in context: Context, completion: @escaping (ArticleEntry) -> Void) {
        // Provide a placeholder for the snapshot

    }
    
    func getTimeline(for configuration: SelectCategoryIntent, in context: Context, completion: @escaping (Timeline<ArticleEntry>) -> Void) {
        let apiUrl = "your_api_url_here"
        let backendApi = BackendApi(apiUrl: apiUrl)
        
    }
}
