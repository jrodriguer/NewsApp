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
    @State private var scrollToID: UUID? = nil
    @State private var showFab = true
    @State private var offset = CGFloat.zero
    
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
                                            .environmentObject(vm)
                                            .environmentObject(favorites)
                                    }                                    
                                    .accessibilityIdentifier("NavigationLink_\(article.id)")
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
            if vm.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollViewReader { proxy in
                    ZStack(alignment: .bottomTrailing) {
                        List {
                            if !searchResult.isEmpty {
                                ForEach(searchResult) { article in
                                    if article.title != "[Removed]" {
                                        ZStack(alignment: .leading) {
                                            ArticleRowView(article: article)
                                                .environmentObject(vm)
                                                .environmentObject(favorites)
                                                .id(article.id)
                                            
                                            NavigationLink(destination:
                                                            ArticleDetailView(article: article)
                                                .environmentObject(vm)
                                                .environmentObject(favorites)
                                            ) {
                                                EmptyView()
                                            }
                                            .accessibilityIdentifier("NavigationLink_\(article.id)")
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
                        .background(Color(.baseGray).edgesIgnoringSafeArea(.all))
                        
                        if showFab {
                            FloatingActionButtonView(name: "chevron.up", radius: 55, action: {
                                if let firstArticle = searchResult.first {
                                    scrollToID = firstArticle.id
                                    DispatchQueue.main.async {
                                        withAnimation {
                                            proxy.scrollTo(firstArticle.id, anchor: .top)
                                        }
                                    }
                                }
                            })
                            .accessibilityIdentifier("FabButton")
                        }
                    }
                    // MARK: - Capture current scroll offset
                    .background(GeometryReader {
                        Color.clear.preference(key: ViewOffsetKey.self,
                                               value: -$0.frame(in: .named("scroll")).origin.y)
                    })
                    .onPreferenceChange(ViewOffsetKey.self) { newOffset in
                        self.offset = newOffset
                        withAnimation {
                            showFab = newOffset > -100
                        }
                    }
                }
            }
        }
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

#Preview {
    ArticleView()
}
