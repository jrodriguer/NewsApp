//
//  TabBarType.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 26/2/25.
//

import Foundation

enum TabBarType: String, CaseIterable {
    case news
    case search
    case bookmarks
    
    var tabIcon: String {
        switch self {
        case .news:
            return "network"
        case .search:
            return "magnifyingglass"
        case .bookmarks:
            return "bookmark"
        }
    }
    
    var title: String {
        switch self {
        case .news:
            return "News"
        case .search:
            return "Search"
        case .bookmarks:
            return "Bookmarks"
        }
    }
}
