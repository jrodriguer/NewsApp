//
//  ArticleTabView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import SwiftUI

enum ViewOption: String, CaseIterable {
    case cardView = "Card View"
    case listView = "List View"
}

struct ArticleTabView<ViewModel>: View where ViewModel: ArticleViewModelProtocol {
    
    @ObservedObject private var viewModel: ViewModel
    @EnvironmentObject private var bookmarks: BookmarkViewModel
    @State private var selectedCategory = Category.general
    @State private var selectedViewOption = ViewOption.cardView
    @State private var showFavoritesOnly = false
    @State private var scrollToID: UUID? = nil
    @State private var showFab = false
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        viewModel.loadFirstPage()
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
                toolbarItem
            }
            .navigationTitle("News")
        }
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
    
    private var cardSection: some View {
        ScrollContentView(
            articles: viewModel.articles,
            content: { article in
                NavigationLink(destination: ArticleDetailView(article: article)
                    .environmentObject(bookmarks)) {
                        ArticleCardView(article: article)
                                .environmentObject(bookmarks)
                    }
                    .accessibilityIdentifier("NavigationLink_\(article.id)")
            },
            showFab: $showFab,
            handleScrollOffset: handleScrollOffset
        )
    }
    
    private var listSection: some View {
        ScrollContentView(
            articles: viewModel.articles,
            content: { article in
                NavigationLink(destination: ArticleDetailView(article: article)
                    .environmentObject(bookmarks)) {
                        ArticleRowView(article: article)
                            .environmentObject(bookmarks)
                    }
                    .accessibilityIdentifier("NavigationLink_\(article.id)")
            },
            showFab: $showFab,
            handleScrollOffset: handleScrollOffset
        )
    }
    
    private func handleScrollOffset(_ newOffset: CGFloat) {
        withAnimation {
            showFab = newOffset > 200
        }
        
        let contentHeight = calculateContentHeight()
        let screenHeight = UIScreen.main.bounds.height
        
        if (newOffset + screenHeight) >= contentHeight * 0.95
            && !viewModel.shouldShowLoader()
            && !viewModel.isLoading {
            viewModel.requestMoreItemsIfNeeded()
        }
    }
    
    private func calculateContentHeight() -> CGFloat {
        let estimatedRowHeight = selectedViewOption == .cardView ? 300.0 : 80.0
        return CGFloat(viewModel.articles.count) * estimatedRowHeight
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
