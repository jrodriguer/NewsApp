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
    @StateObject var favorites = Favorites()
    @State private var showFavoritesOnly = false
    @Namespace var topID
    @Namespace var bottomID
    @State var scrollPosition: Int?
    
    var body: some View {
        VStack {
            viewForSelectedOption()
        }
    }
    
    private var filteredArticles: [Article] {
        articles.filter { article in
            (!showFavoritesOnly || favorites.contains(article))
        }
    }
    
    private func selectionToogle() -> some View {
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
            ScrollViewReader { proxy in
                GeometryReader { geometry in
                    ScrollView {
                        LazyVStack {
                            VStack(spacing: 0) {
                                selectionToogle()
                                
                                Toggle(isOn: $showFavoritesOnly) {
                                    Text("Favorites only")
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .cornerRadius(10)
                                .padding(10)
                                
                                if !filteredArticles.isEmpty {
                                    ForEach(Array(filteredArticles.enumerated()), id: \.element.id) { (index, article) in
                                        if article.title != "[Removed]" {
                                            NavigationLink {
                                                ArticleDetail(article: article)
                                            } label: {
                                                ArticleCard(article: article)
                                                    .multilineTextAlignment(.leading)
                                            }
                                            // Set the scroll position when the button is tapped
                                            .id(index)
                                        }
                                    }
                                    
                                } else {
                                    Text("No articles available")
                                        .foregroundColor(.red)
                                        .padding()
                                }
                            }
                            
                            // TODO: Add button for go to top, fixed positioned on following scroll location.
                            
                            Button(action: {
                                withAnimation {
                                    proxy.scrollTo(0)
                                }
                            }, label: {
                                Image(systemName: "arrow.up.circle.fill")
                                    .font(.system(size: 32))
                                    .foregroundColor(Color.white)
                            })
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(38.5)
                            .padding()
                            .shadow(color: Color.black.opacity(0.3),
                                    radius: 3,
                                    x: 3,
                                    y: 3)
                            .zIndex(1)
                            .opacity(geometry.frame(in: .global).minY > 300 ? 1 : 0)
                        }
                        .scrollTargetLayout()
                    }
                    .scrollPosition(id: $scrollPosition)
                    .navigationTitle("Headers")
                }
            }
        }
        .environmentObject(favorites)
    }
    
    private func listView() -> some View {
        NavigationView {
            VStack {
                selectionToogle()
                
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
                                    
                                    // TODO: Move heart image to right of row, alignment all places.
                                    
                                    if favorites.contains(article) {
                                        Spacer()
                                        Image(systemName: "heart.fill")
                                            .accessibilityLabel("This is a favorite article")
                                            .foregroundColor(.red)
                                    }
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
        .environmentObject(favorites)
    }
}

#Preview {
    HeadersView(articles: [])
}
