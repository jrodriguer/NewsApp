//
//  HomeView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import SwiftUI

struct HomeView: View {

    @AppStorage("sidebarCustomization") var customization: TabViewCustomization
    
    let articleView: ArticleView<ArticleViewModel>
    let favoriteView: FavoriteView<FavoritesViewModel<ArticleListItemViewModel>>
    
    var body: some View {
        TabView {
            Tab("News", systemImage: "network") {
                articleView
            }
            .customizationID("com.newsApp.News")
            Tab("Favorites", systemImage: "suit.heart") {
                favoriteView
            }
            .customizationID("com.newsApp.Favorites")
        }
        .tabViewStyle(.sidebarAdaptable)
        .tabViewCustomization($customization)
        .tint(.primary)
    }
}
