//
//  ArticleView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import SwiftUI

struct ArticleView: View {
    @StateObject var vm = ArticleViewModel()
    enum ViewOption: String, CaseIterable {
        case cardView = "Card View"
        case listView = "List View"
    }
    @State private var selectedViewOption = ViewOption.cardView
    @State private var showFavoritesOnly = false
    private var filteredArticles: [ArticleApiObject] {
        vm.articles.filter { article in
            (!showFavoritesOnly || vm.contains(article))
        }
    }
    @State var showFab = true
    @State var scrollOffset: CGFloat = 0.00
    
    var body: some View {
        NavigationStack {
            VStack {
                switch selectedViewOption {
                case .cardView: cardSection
                case .listView: listSection
                }
            }
            .navigationBarTitle("Headers")
            .toolbar {
                ToolbarItem {
                    // TODO: Menu with option to sort articles alphabetically or temporally, where you can select the display option, toggle to show only favorites.
                    Menu {
                        Section("Sort by") {
                            Button("Alphabetical") {  }
                            Button("Newest First") {  }
                            Button("Oldest First") {  }
                        }
                        
                        Toggle(isOn: $showFavoritesOnly) {
                            Text("Favorites only")
                        }
                        
                        Divider()
                        
                        Section("Show items as") {
                            Button {
                                //
                            } label: {
                                Label("Grid", systemImage: "square.grid.2x2")
                            }
                            Button {
                                //
                            } label: {
                                Label("List", systemImage: "list.bullet")
                            }
                        }
                        
                    } label: {
                        Label("Menu", systemImage: "ellipsis.circle")
                    }
                    .menuOrder(.fixed)
                }
            }
        }
    }
}

extension ArticleView {
    private var cardSection: some View {
        Group {
            if vm.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    VStack(spacing: 0) {
                        
                        
                        if !filteredArticles.isEmpty {
                            ForEach(filteredArticles) { article in
                                if article.title != "[Removed]" {
                                    NavigationLink(destination:
                                                    ArticleDetailView(article: article)
                                        .environmentObject(vm)
                                    ) {
                                        ArticleCardView(article: article)
                                            .multilineTextAlignment(.leading)
                                            .environmentObject(vm)
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
                        if !filteredArticles.isEmpty {
                            ForEach(filteredArticles) { article in
                                if article.title != "[Removed]" {
                                    ZStack(alignment: .leading) {
                                        ArticleRowView(article: article)
                                            .environmentObject(vm)
                                        
                                        NavigationLink(destination:
                                                        ArticleDetailView(article: article)
                                            .environmentObject(vm)
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
                    .navigationBarTitle("Characters")
                    .scrollContentBackground(.hidden)
                    .background(Color(.baseGray).edgesIgnoringSafeArea(.all))
                }
            }
        }
        .background(GeometryReader { geometry in
            return Color.clear.preference(key: ViewOffsetKey.self,
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
                if showFab, !filteredArticles.isEmpty {
                    /*FloatingActionButtonView(nameIcon: "chevron.up") {
                        // TODO: Go to top.
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
