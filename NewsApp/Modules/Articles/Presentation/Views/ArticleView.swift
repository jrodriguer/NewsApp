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
    @StateObject private var favorites = FavoritesViewModel<ArticleListItemViewModel>(saveKey: FavoriteKey.articleFavorites)
    @State private var selectedCategory = Category.general
    @State private var selectedViewOption = ViewOption.cardView
    @State private var showFavoritesOnly = false
    @State private var scrollToID: UUID? = nil
    @State private var showFab = false
    
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
        }
        .task {
            await fetchArticles()
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
                    .frame(width: 24, height: 24)
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
        Button(!showFavoritesOnly ? "Favorites only" : "All Articles") {
            showFavoritesOnly.toggle()
        }
    }
    
    private var cardSection: some View {
        ScrollView {
            VStack {
                if viewModel.shouldShowLoader() {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else {
                    ForEach(viewModel.filteredArticles) { article in
                        NavigationLink(value: article) {
                            ArticleCardView(article: article)
                                .overlay {
                                    if viewModel.isError {
                                        ErrorView(errorDescription: viewModel.error) {
                                            Task {
                                                await fetchArticles()
                                            }
                                        }
                                    }
                                }
                        }
                        .accessibilityIdentifier("NavigationLink_\(article.id)")
                    }
                    .navigationDestination(for: ArticleListItemViewModel.self, destination: { article in
                        ArticleDetailView(article: article)
                            .environmentObject(favorites)
                    })
                }
            }
        }
    }
    
    private var listSection: some View {
        ScrollViewReader { scrollProxy in
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    VStack {
                        if !viewModel.searchText.isEmpty &&
                            viewModel.filteredArticles.isEmpty {
                            Text("No articles found")
                                .foregroundColor(.secondary)
                        } else {
                            ForEach(viewModel.filteredArticles) { article in
                                NavigationLink(destination:
                                                ArticleDetailView(article: article)
                                    .environmentObject(favorites)
                                ) {
                                    ArticleRowView(article: article)
                                        .environmentObject(favorites)
                                        .id(article.id)
                                }
                                .accessibilityIdentifier("NavigationLink_\(article.id)")
                            }
                        }
                    }.background(GeometryReader {
                        Color.clear.preference(key: ViewOffsetKey.self,
                                               value: -$0.frame(in: .named("scroll")).origin.y)
                    })
                    .onPreferenceChange(ViewOffsetKey.self) { handleScrollOffset($0) }
                }.coordinateSpace(name: "scroll")

                if showFab {
                    Button {
                        scrollToTop(scrollProxy)
                    } label: {
                        Image(systemName: "chevron.up")
                            .font(.largeTitle)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 55, height: 55, alignment: .center)
                    }
                    .foregroundStyle(Color.white)
                    .background(.secondary.opacity(0.6))
                    .cornerRadius(55/2)
                    .padding()
                    .accessibilityIdentifier("FabButton")
                }
            }
        }
    }
    
    private func scrollToTop(_ proxy: ScrollViewProxy) {
        if let firstArticle = viewModel.filteredArticles.first {
            scrollToID = firstArticle.id
            DispatchQueue.main.async {
                withAnimation {
                    proxy.scrollTo(firstArticle.id, anchor: .top)
                }
            }
        }
    }
    
    private func handleScrollOffset(_ newOffset: CGFloat) {
        withAnimation {
            showFab = newOffset > 168 // random value to compare
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

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(viewModel: ArticleView_Previews.getViewModel())
    }
}
