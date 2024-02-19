//
//  HomeView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Tabs = .Headers
    @State private var showModal: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if selectedTab == .Headers {
                    ArticleView()
                } else {
                    CharacterView()
                }
                
                CustomTabBarView(selectedTab: $selectedTab, showModal: $showModal)
            }
        }
    }
}

#Preview {
    HomeView()
}
