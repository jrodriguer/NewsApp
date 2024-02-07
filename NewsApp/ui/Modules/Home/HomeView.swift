//
//  HomeView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            ArticleView()
                //.badge(2)
                .tabItem {
                    Label("Headers", systemImage: "network")
                }
            Text("Hello, World!")
                .tabItem {
                    Label("Sent", systemImage: "tray.and.arrow.up.fill")
                }
        }
    }
}

#Preview {
    HomeView()
}
