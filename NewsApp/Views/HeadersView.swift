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
        ScrollView {
            VStack {
                if !articles.isEmpty {
                    ForEach(articles) { article in
                        if article.title != "[Removed]" {
                            CardView(imageURL: article.urlToImage, heading: article.title, author: article.source.name, description: article.description ?? "Not description")
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
    
    private func listView() -> some View {
        List {
            if !articles.isEmpty {
                ForEach(articles) { article in
                    ListView(title: article.title, author: article.source.name)
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
