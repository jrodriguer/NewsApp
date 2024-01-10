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
    
    // FIXME: Not navigate with Picker
    // TODO: Change Headers filter
    var body: some View {
        VStack {
            Picker("Select View", selection: $selectedViewOption) {
                ForEach(ViewOption.allCases, id: \.self) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            viewForSelectedOption()
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
                    // FIXME: Fix content alignment. This's not good, but into View it's OK
                    if !articles.isEmpty {
                        ForEach(articles) { article in
                            if article.title != "[Removed]" {
                                NavigationLink {
                                    ArticleDetail(article: article)
                                    
                                } label: {
                                    ArticleCard(article: article)
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
        List {
            if !articles.isEmpty {
                ForEach(articles) { article in
                    if article.title != "[Removed]" {
                        ArticleRow(article: article)
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

#Preview {
    HeadersView(articles: ModelData().news.articles)
        .environmentObject(Favorites())
}
