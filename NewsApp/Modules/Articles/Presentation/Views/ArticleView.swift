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
    
    @StateObject private var favorites = FavoritesViewModel<ArticleListItemViewModel>(saveKey: FavoriteKey.articleFavorites)
    
    @State private var scrollToID: UUID? = nil
    @State private var showFab = true
    @State private var offset = CGFloat.zero
    @State private var dataID: UUID? = nil
    
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
            .searchable(text: $viewModel.searchText)
            .toolbar {
                toolbarItem
            }
            .navigationTitle("News")
            .task {
                await fetchArticles()
            }
            .sheet(isPresented: $viewModel.isError) {
                ErrorView(error: viewModel.error)
            }
        }
    }
    
    private func fetchArticles() async {
        await viewModel.fetchArticles()
    }
    
    private var toolbarItem: some ToolbarContent {
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
                Circle()
                    .stroke(Color.primary, lineWidth: 1)
                    .frame(width: 30, height: 30)
                    .overlay {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 13.0, weight: .semibold))
                            .foregroundColor(.primary)
                            .padding(Spacing.small)
                    }
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
        // FIXME: Display only favorites articles.
        Button(!showFavoritesOnly ? "Favorites only" : "All Articles") {
            showFavoritesOnly.toggle()
        }
    }
    
    private var cardSection: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 0) {
//                if viewModel.shouldShowLoader() {
//                    ProgressView()
//                } else {
                if !viewModel.searchText.isEmpty &&
                    viewModel.filteredArticles.isEmpty {
                        Text("No articles found")
                    } else {
                        ForEach(viewModel.filteredArticles) { item in
                            NavigationLink(value: item) {
                                ArticleCardView(item: item)
                            }
                            .accessibilityIdentifier("NavigationLink_\(item.id)")
                        }
                        .navigationDestination(for: ArticleListItemViewModel.self, destination: { item in
                            ArticleDetailView(article: item)
                                .environmentObject(favorites)
                        })
                    }
//                }
            }
        }
    }
    
    private var listSection: some View {
        // TODO: Infinite scrolling.
        List {
            if !viewModel.searchText.isEmpty &&
                viewModel.filteredArticles.isEmpty {
                Text("No articles found")
            } else {
                ForEach(viewModel.filteredArticles, id: \.id) { article in
                    ZStack(alignment: .leading) {
                        ArticleRowView(article: article)
                            .environmentObject(favorites)
                            .id(article.id)
                        
                        NavigationLink(destination:
                                        ArticleDetailView(article: article)
                            .environmentObject(favorites)
                        ) {
                            EmptyView()
                        }
                        .accessibilityIdentifier("NavigationLink_\(article.id)")
                        .opacity(0.0)
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(viewModel: ArticleView_Previews.getViewModel())
    }
}
