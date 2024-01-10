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
    
    // TODO: Not navigate with Picker
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
        .navigationBarTitle("Headers")
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
                    // TODO: Fix content alignment. This's not good, but into View it's OK
                    if !articles.isEmpty {
                        ForEach(articles) { article in
                            if article.title != "[Removed]" {
                                NavigationLink {
                                    CardDetail(article: article)
                                    
                                } label: {
                                    CardView(article: article)
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
        } detail: {
            Text("Select a Article")
        }
    }
    
    private func listView() -> some View {
        List {
            if !articles.isEmpty {
                ForEach(articles) { article in
                    if article.title != "[Removed]" {
                        ListView(article: article)
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
