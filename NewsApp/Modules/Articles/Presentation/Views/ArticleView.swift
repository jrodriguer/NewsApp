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

struct ArticleView<ViewModel>: View where ViewModel: ArticleViewModelProtocol {
    
    @ObservedObject private var viewModel: ViewModel
    @State private var selectedCategory = Category.general
    @State private var selectedViewOption = ViewOption.cardView
    @State private var showFavoritesOnly = false
    @State private var scrollToID: UUID? = nil
    @State private var showFab = true
    @State private var offset = CGFloat.zero
    @State private var dataID: UUID? = nil
    
    @StateObject private var favorites = FavoritesViewModel<ArticleListItemViewModel>(saveKey: FavoriteKey.articleFavorites)

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
        
    var body: some View {
        NavigationStack {
            VStack {
                switch selectedViewOption {
                case .cardView: cardSection
                case .listView: listSection
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("News")
                        .applyStyle(.h1)
                }
            }
            .toolbarRole(.navigationStack)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                toolbarContent
            }
        }
        .task {
            await fetchArticles()
        }
    }
    
    private func fetchArticles() async {
        await viewModel.fetchArticles()
    }
    
    private var toolbarContent: some ToolbarContent {
        ToolbarItem {
            Menu {
                Picker("View", selection: $selectedViewOption) {
                    ForEach(ViewOption.allCases, id: \.self) { option in
                        Label(option.rawValue, systemImage: option == .cardView ? "square.grid.2x2" : "list.bullet")
                            .tag(option)
                    }
                }
                .pickerStyle(.menu)
                
                sortButtons
                showFavoritesButton
            } label: {
                Label("Menu", systemImage: "ellipsis.circle")
            }
        }
    }
    
    private var sortButtons: some View {
        Section("Sort by") {
            Button("Newest First") {
                viewModel.articles.sort {
                    $1.publishedStringToDate.timeIntervalSinceNow < $0.publishedStringToDate.timeIntervalSinceNow
                }
            }
            Button("Oldest First") {
                viewModel.articles.sort {
                    $0.publishedStringToDate.timeIntervalSinceNow < $1.publishedStringToDate.timeIntervalSinceNow
                }
            }
        }
    }
    
    private var showFavoritesButton: some View {
        Button(!showFavoritesOnly ? "Favorites only" : "All Articles") {
            showFavoritesOnly.toggle()
        }
    }
    
    // TODO: Check and enable search articles result.
//    private var searchResult: [ArticleListItemViewModel] {
//        favorites.filtered(from: viewModel.articles, showFavoritesOnly: showFavoritesOnly)
//    }
    
    private var cardSection: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(viewModel.articles, id: \.id) { item in
                    if item.title != "[Removed]" {
                        NavigationLink(value: item) {
                            ArticleItemView(item: item)
                        }
                        .accessibilityIdentifier("NavigationLink_\(item.id)")
                    }
                }
                .navigationDestination(for: ArticleListItemViewModel.self, destination: { item in
                    ArticleDetailView(item: item)
                        .environmentObject(favorites)
                })
            }
        }
    }
    
    private var listSection: some View {
        // TODO: Infinite scrolling.
        List(viewModel.articles) { item in
            if item.title != "[Removed]" {
                NavigationLink(value: item) {
                    ArticleRowView(item: item)
                        .environmentObject(favorites)
                }
                .accessibilityIdentifier("NavigationLink_\(item.id)")
            }
        }
        .navigationDestination(for: ArticleListItemViewModel.self, destination: { item in
            ArticleDetailView(item: item)
                .environmentObject(favorites)
        })
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(viewModel: ArticleView_Previews.getViewModel())
    }
}
