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
    
    var body: some View {
        if selectedTab == .News {
            ArticleView()
                .accessibilityIdentifier("ArticleView")
        }
        CustomTabBarView(selectedTab: $selectedTab, showModal: $showModal)
    }
}

#Preview {
    HomeView()
}
