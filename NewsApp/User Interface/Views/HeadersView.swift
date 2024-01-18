//
//  Headers.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 7/1/24.
//

import SwiftUI

struct HeadersView: View {
    enum ViewOption: String, CaseIterable {
        case cardView = "Card View"
        case listView = "List View"
    }
    @State private var selectedViewOption = ViewOption.cardView
        
    var articles: [Article]
    
    @EnvironmentObject var favorites: Favorites
    
    // TODO: Add animation translation on cards view, or datapicker
    
    var body: some View {
        VStack {
            viewForSelectedOption()
        }
    }
    
    private func filterToogle() -> some View {
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
        NavigationSplitView {
            ScrollView {
                VStack {
                    filterToogle()
                    
                    if !articles.isEmpty {
                        ForEach(articles) { article in
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
        } detail: {
            Text("Select a Article")
        }
    }
    
    private func listView() -> some View {
        NavigationView {
            VStack {
                filterToogle()
                
                List {
                    if !articles.isEmpty {
                        ForEach(articles) { article in
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
            }
            .navigationTitle("Headers")
        }
    }
}

#Preview {
    HeadersView(articles: ModelData().news.articles)
        .environmentObject(Favorites())
}
