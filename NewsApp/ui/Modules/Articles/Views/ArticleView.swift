//
//  ArticleView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import SwiftUI

enum Category: String, CaseIterable {
    case business = "business"
    case entertainment = "entertainment"
    case general = "general"
    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"
}

enum ViewOption: String, CaseIterable {
    case cardView = "Card View"
    case listView = "List View"
}

struct ArticleView: View {
    @StateObject var vm = ArticleViewModel()
    @StateObject var favorites = ArticleFavoritesViewModel()
    @State private var selectedCategory = Category.business
    @State private var selectedViewOption = ViewOption.cardView
    @State private var showFavoritesOnly = false
    @State var showFab = true
    @State var scrollOffset: CGFloat = 0.00
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(Category.allCases, id: \.self) { category in
                            Button(action: {
                                vm.loadCategoryArticles(category: category.rawValue)
                                selectedCategory = category
                            }) {
                                Text(category.rawValue)
                                    .font(.headline)
                                    .foregroundColor(selectedCategory == category ? .primary : .secondary)
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                switch selectedViewOption {
                case .cardView: cardSection
                case .listView: listSection
                }
            }
            .navigationBarTitle("Headers")
            .onAppear {
                vm.loadCategoryArticles(category: Category.allCases.first?.rawValue ?? "")
            }
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
        favorites.filteredArticles(from: vm.articles, showFavoritesOnly: showFavoritesOnly)
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
                    .navigationBarTitle("Headers")
                    //.scrollContentBackground(.hidden)
                    .background(Color(.baseGray).edgesIgnoringSafeArea(.all))
                }
            }
        }
        .background(GeometryReader { geometry in
            Color.clear.preference(key: ViewOffsetKey.self,
                                          value: -geometry.frame(in: .named("scroll")).origin.y)
        })
        .onPreferenceChange(ViewOffsetKey.self) { offset in
            withAnimation {
                if offset > 50 {
                    showFab = offset < scrollOffset
                } else  {
                    showFab = true
                }
            }
            scrollOffset = offset
        }
        .coordinateSpace(name: "scroll")
        .overlay(
            Group {
                if showFab, !searchResult.isEmpty {
                    /*FloatingActionButtonView(nameIcon: "chevron.up") {
                        print("click button")
                    }*/
                }
            },
            alignment: Alignment.bottomTrailing
        )
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
