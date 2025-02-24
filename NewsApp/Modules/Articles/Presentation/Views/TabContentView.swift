//
//  TabsView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import SwiftUI

enum TabSelect: String, CaseIterable {
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

struct TabsView: View {
    
    @StateObject private var bookmarkViewModel = BookmarkViewModel(saveKey: BookmarkKey.articleBookmarks)
    @State var selectedTab: TabSelect = .news
    let articleTabView: ArticleTabView<ArticleViewModel>
    let searchTabView: SearchTabView<ArticleViewModel>
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                TabView(selection: $selectedTab) {
                    switch selectedTab {
                    case .news:
                        articleTabView
                            .environmentObject(bookmarkViewModel)
                    case .search:
                        searchTabView
                    case .bookmarks:
                        BookmarkTabView()
                            .environmentObject(bookmarkViewModel)
                    }
                }
            }
            
            HStack(spacing: 0) {
                ForEach(TabSelect.allCases ,id: \.rawValue) { tab in
                    TabButton(tabSelect: tab, selectedTab: $selectedTab)
                }
            }
            .coordinateSpace(.named("TABBARVIEW"))
            .padding(.horizontal, Spacing.minimum)
            .frame(height: 45)
//            .background(
//                .background
//                    .shadow(.drop(color: .primary.opacity(0.08), radius: 5, x: 5, y: 5))
//                    .shadow(.drop(color: .primary.opacity(0.06), radius: 5, x: -5, y: -5)),
//                in: .capsule
//            )
            .animation(.smooth(duration: 0.3, extraBounce: 0), value: selectedTab)
        }
    }
}
