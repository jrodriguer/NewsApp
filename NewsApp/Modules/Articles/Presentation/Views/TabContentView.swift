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
    @State private var tabLocation: CGRect = .zero
    let articleTabView: ArticleTabView<ArticleViewModel>
    let searchTabView: SearchTabView<ArticleViewModel>
        
    var body: some View {
        let status = selectedTab == .news || selectedTab == .search

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
            
            HStack(spacing: Spacing.medium) {
                HStack(spacing: 0) {
                    ForEach(TabSelect.allCases ,id: \.rawValue) { tab in
                        TabButton(tabSelect: tab, selectedTab: $selectedTab, tabLocation: $tabLocation)
                    }
                }
                .background(alignment: .leading) {
                    Capsule()
                        .fill(.white.gradient)
                        .frame(width: tabLocation.width, height: tabLocation.height)
                        .offset(x: tabLocation.minX)
                }
                .coordinateSpace(.named("TABBARVIEW"))
                .padding(.horizontal, Spacing.minimum)
                .frame(height: 45)
                .background(
//                    .background
//                        .shadow(.drop(color: .primary.opacity(0.08), radius: 5, x: 5, y: 5))
//                        .shadow(.drop(color: .primary.opacity(0.08), radius: 5, x: -5, y: -5)),
//                    in: .capsule
                )
                .zIndex(10)
                
                Button {
                    
                } label: {
                    Image(systemName: selectedTab == .news ? "person.fill" : "slider.vertical.3")
                        .frame(width: 42, height: 42)
                        .foregroundStyle(Color.primary)
                        .background(.accent.gradient)
                        .clipShape(.circle)
                        
                }
                .allowsHitTesting(status)
                .offset(x: status ? 0 : -20)
                .padding(.leading, status ? 0 : -42)
                
            }
            .animation(.smooth(duration: 0.3, extraBounce: 0), value: selectedTab)
        }
    }
}
