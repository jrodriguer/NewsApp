//
//  TabContentView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import SwiftUI

struct TabContentView: View {

    @AppStorage("sidebarCustomization") var customization: TabViewCustomization
    
    let articleTabView: ArticleTabView<ArticleViewModel>
    let searchTabView: SearchTabView<ArticleViewModel>
    let bookmarkTabView: BookmarkTabView<BookmarkViewModel<ArticleListItemViewModel>>
    
    var body: some View {
        TabView {
            Tab("News", systemImage: "network") {
                articleTabView
            }
            .customizationID("com.newsApp.News")
            Tab("Searchs", systemImage: "magnifyingglass") {
                searchTabView
            }
            .customizationID("com.newsApp.Searchs")
            Tab("Bookmarks", systemImage: "bookmark") {
                bookmarkTabView
            }
            .customizationID("com.newsApp.Bookmarks")
        }
        .tabViewStyle(.sidebarAdaptable)
        .tabViewCustomization($customization)
        .tint(.primary)
    }
}
