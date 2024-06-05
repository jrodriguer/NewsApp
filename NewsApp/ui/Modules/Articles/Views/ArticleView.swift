//
//  ArticleView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import SwiftUI

enum ViewOption: String, CaseIterable {
    case cardView = "Card View"
    case listView = "List View"
}

struct ArticleView: View {
    @StateObject private var vm = ArticlesViewModel()
    @StateObject private var favorites = FavoritesViewModel<ArticleApiObject>(saveKey:  FavoriteKey.articleFavorites)
    @State private var selectedCategory = Category.general
    @State private var selectedViewOption = ViewOption.cardView
    @State private var showFavoritesOnly = false
    @State private var showFab = true
    @State private var scrollOffset: CGFloat = 0.00
    
    var body: some View {
        NavigationStack {
            VStack {
                switch selectedViewOption {
                case .cardView: cardSection
                case .listView: listSection
                }
            }
            .navigationBarTitle("News")
            .toolbar {
                ToolbarItem {
                    Menu {
                        Picker("View", selection: $selectedViewOption) {
                            ForEach(ViewOption.allCases, id: \.self) { option in
                                Label {
                                    Text(option.rawValue)
                                } icon: {
                                    Image(systemName: option == .cardView ? "square.grid.2x2" : "list.bullet")
                                }
                                .tag(option)
                            }
                        }
                        .pickerStyle(.menu)
                        
                        Section("Sort by") {
                            Button("Alphabetical") { 
                                if !searchResult.isEmpty {
                                    vm.articles.sort { $0.source.name.lowercased() < $1.source.name.lowercased() }
                                }
                            }
                            Button("Newest First") { 
                                if !searchResult.isEmpty {
                                    vm.articles.sort { $1.publishedAt.timeIntervalSinceNow < $0.publishedAt.timeIntervalSinceNow }
                                }
                            }
                            Button("Oldest First") { 
                                if !searchResult.isEmpty {
                                    vm.articles.sort { $0.publishedAt.timeIntervalSinceNow < $1.publishedAt.timeIntervalSinceNow }
                                }
                            }
                        }
                        
                        Button(!showFavoritesOnly ? "Favorites only" : "All Articles") {
                            showFavoritesOnly.toggle()
                        }
                    } label: {
                        Label("Menu", systemImage: "ellipsis.circle")
                    }
                    .menuOrder(.fixed)
                }
            }
        }
    }
    
    private var searchResult: [ArticleApiObject] {
        favorites.filtered(from: vm.articles, showFavoritesOnly: showFavoritesOnly)
    }
}

extension ArticleView {
    private var cardSection: some View {
        Group {
            if vm.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else {
                ScrollView {
                    VStack(spacing: 0) {
                        if !searchResult.isEmpty {
                            ForEach(searchResult) { article in
                                if article.title != "[Removed]" {
                                    NavigationLink(destination:
                                                    ArticleDetailView(article: article)
                                        .environmentObject(vm)
                                        .environmentObject(favorites)
                                    ) {
                                        ArticleCardView(article: article)
                                            .multilineTextAlignment(.leading)
                                            .environmentObject(vm)
                                            .environmentObject(favorites)
                                    }
                                }
                            }
                        } else {
                            Text("No articles available")
                                .foregroundColor(.red)
                                .padding()
                        }
                    }
                }
            }
        }
    }
    
    private var listSection: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                if vm.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollViewReader { proxy in
                        VStack {
//                        ScrollView(showsIndicators: false) {
                            List {
                                if !searchResult.isEmpty {
                                    ForEach(searchResult) { article in
                                        if article.title != "[Removed]" {
                                            ZStack(alignment: .leading) {
                                                ArticleRowView(article: article)
                                                    .environmentObject(vm)
                                                    .environmentObject(favorites)
                                                
                                                NavigationLink(destination:
                                                                ArticleDetailView(article: article)
                                                    .environmentObject(vm)
                                                    .environmentObject(favorites)
                                                ) {
                                                    EmptyView()
                                                }
                                                .opacity(0.0)
                                            }
                                        }
                                    }
                                } else {
                                    Text("No articles available")
                                        .foregroundColor(.red)
                                        .padding()
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .listStyle(.plain)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
        }
    }
}

#Preview {
    ArticleView()
}
