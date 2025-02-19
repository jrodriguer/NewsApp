//
//  TabContentView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import SwiftUI

struct TabContentView: View {

    @AppStorage("sidebarCustomization") var customization: TabViewCustomization
    @StateObject private var bookmarkViewModel = BookmarkViewModel(saveKey: BookmarkKey.articleBookmarks)
    let articleTabView: ArticleTabView<ArticleViewModel>
    let searchTabView: SearchTabView<ArticleViewModel>
        
    var body: some View {
        TabView {
            Tab("News", systemImage: "network") {
                articleTabView
                    .environmentObject(bookmarkViewModel)
            }
            .customizationID("com.newsApp.News")
            
            Tab("Searchs", systemImage: "magnifyingglass") {
                searchTabView
            }
            .customizationID("com.newsApp.Searchs")
            
            Tab("Bookmarks", systemImage: "bookmark") {
                BookmarkTabView()
                    .environmentObject(bookmarkViewModel)
            }
            .customizationID("com.newsApp.Bookmarks")
        }
        .tabViewStyle(.sidebarAdaptable)
        .tabViewCustomization($customization)
        .tint(.primary)
    }
}
