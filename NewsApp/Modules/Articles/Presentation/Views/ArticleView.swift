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
            .navigationTitle(Text("News").font(.h1))
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
    
//    private var searchResult: [ArticleListItemViewModel] {
//        favorites.filtered(from: viewModel.articles, showFavoritesOnly: showFavoritesOnly)
//    }
    
    private var cardSection: some View {
        ScrollView {
            VStack(spacing: 0) {
                if !viewModel.shouldShowLoader() {
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
                    })
                }
            }
        }
    }
    
    private var listSection: some View {
        VStack {
            ScrollViewReader { proxy in
                ZStack(alignment: .bottomTrailing) {
                    List {
                        if !viewModel.shouldShowLoader() {
                            ForEach(viewModel.articles, id: \.id) { item in
                                if item.title != "[Removed]" {
                                    ZStack(alignment: .leading) {
                                        ArticleRowView(item: item)
                                            .environmentObject(viewModel)
                                        
                                        NavigationLink(destination:
                                                        ArticleDetailView(item: item)
                                            .environmentObject(viewModel)
                                        ) {
                                            EmptyView()
                                        }
                                        .accessibilityIdentifier("NavigationLink_\(item.id)")
                                        .opacity(0.0)
                                    }
                                }
                            }
                        }
                    }
                    .background(Color.background.edgesIgnoringSafeArea(.all))
                    
//                    if showFab {
//                        FloatingActionButtonView(name: "chevron.up", radius: 55, action: {
//                            scrollToTop(proxy)
//                        })
//                    }
                }
                .background(GeometryReader {
                    Color.clear.preference(
                        key: ViewOffsetKey.self,
                        value: -$0.frame(in: .named("scroll")).origin.y
                    )
                })
                .onPreferenceChange(ViewOffsetKey.self) { newOffset in
                    handleScrollOffset(newOffset)
                }
            }
        }
    }
    
    private func scrollToTop(_ proxy: ScrollViewProxy) {
        if let firstArticle = viewModel.articles.first {
            scrollToID = firstArticle.id
            DispatchQueue.main.async {
                withAnimation {
                    proxy.scrollTo(firstArticle.id, anchor: .top)
                }
            }
        }
    }
    
    private func handleScrollOffset(_ newOffset: CGFloat) {
        offset = newOffset
        withAnimation {
            showFab = newOffset > -100
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
