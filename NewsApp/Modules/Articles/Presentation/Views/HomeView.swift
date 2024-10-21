//
//  HomeView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Tabs = .News
    @State private var showModal: Bool = false
    
    let articleView: ArticleView
    
    var body: some View {
        if selectedTab == .News {
            ArticleView()
                .accessibilityIdentifier("ArticleView")
        } else {
            Text("Favorites view")
                .accessibilityIdentifier("FavoritesView")
        }
        CustomTabBarView(selectedTab: $selectedTab, showModal: $showModal)
    }
}

//#Preview {
//    HomeView(articleView: ArticleView(apiDataTransferService: )
//}
