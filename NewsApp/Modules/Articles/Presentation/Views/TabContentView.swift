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
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
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
//                Tab("News", systemImage: "network", value: .news) {
//                    articleTabView
//                        .environmentObject(bookmarkViewModel)
//                }
//                
//                Tab("Searchs", systemImage: "magnifyingglass", value: .search) {
//                    searchTabView
//                }
//                
//                Tab("Bookmarks", systemImage: "bookmark", value: .bookmarks) {
//                    BookmarkTabView()
//                        .environmentObject(bookmarkViewModel)
//                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea(.all, edges: .bottom)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(TabSelect.allCases ,id: \.self) { viewSelect in
                        TabButton(tabSelect: viewSelect, selectedTab: $selectedTab)
                    }
                }
                
            }
            .padding(.horizontal, Spacing.extraMedium)
            .padding(.vertical, Spacing.minimum)
            .background(Color.white)
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 5, y: 5)
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: -5, y: -5)
            .padding(.horizontal)
        }
    }
}
