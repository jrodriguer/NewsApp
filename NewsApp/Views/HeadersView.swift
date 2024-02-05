//
//  Headers.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 7/1/24.
//

import SwiftUI

struct HeadersView: View {
    var articles: [Article]
    
    enum ViewOption: String, CaseIterable {
        case cardView = "Card View"
        case listView = "List View"
    }
    @State private var selectedViewOption = ViewOption.cardView
    
    @EnvironmentObject var favorites: Favorites
    
    @State private var showFavoritesOnly = false
    private var filteredArticles: [Article] {
        articles.filter { article in
            (!showFavoritesOnly || favorites.contains(article))
        }
    }
    
    @State var showFab = true
    
    var body: some View {
        VStack {
            viewForSelectedOption()
        }
    }
    
    private func selectionToggle() -> some View {
        VStack {
            Picker("Select View", selection: $selectedViewOption) {
                ForEach(ViewOption.allCases, id: \.self) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
    }
    
    @ViewBuilder
    private func viewForSelectedOption() -> some View {
        switch selectedViewOption {
        case .cardView:
            cardView()
        case .listView:
            listView()
        }
    }
    
    private func cardView() -> some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    selectionToggle()
                    
                    Toggle(isOn: $showFavoritesOnly) {
                        Text("Favorites only")
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .cornerRadius(10)
                    .padding(10)
                    
                    if !filteredArticles.isEmpty {
                        ForEach(filteredArticles) { article in
                            if article.title != "[Removed]" {
                                NavigationLink {
                                    ArticleDetail(article: article)
                                } label: {
                                    ArticleCard(article: article)
                                        .multilineTextAlignment(.leading)
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
            .navigationTitle("Headers")
        }
    }
    
    private func listView() -> some View {
        NavigationView {
            VStack {
                selectionToggle()
                
                ZStack(alignment: .bottomTrailing) {
                    List {
                        Toggle(isOn: $showFavoritesOnly) {
                            Text("Favorites only")
                        }
                        
                        if !filteredArticles.isEmpty {
                            ForEach(filteredArticles) { article in
                                if article.title != "[Removed]" {
                                    NavigationLink {
                                        ArticleDetail(article: article)
                                    } label: {
                                        ArticleRow(article: article)
                                    }
                                }
                            }
                        } else {
                            Text("No articles available")
                                .foregroundColor(.red)
                                .padding()
                        }
                    }
                    .navigationTitle("Headers")
                    
                    FloatingActionButton()
                }
            }
        }
    }
}

#Preview {
    HeadersView(articles: ModelData().news.articles)
        .environmentObject(Favorites())
}
