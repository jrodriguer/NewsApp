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
    @State var scrollOffset: CGFloat = 0.00
    
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
        }
        .coordinateSpace(name: "scroll")
        .overlay(
            Group {
                if showFab {
                    createFab()
                }
            },
            alignment: Alignment.bottomTrailing
        )
    }
    
    fileprivate func createFab() -> some View {
        Button(action: {
            //
        }, label: {
            Image(systemName: "plus")
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 40, height: 40, alignment: .center)
        })
        .padding(8)
        .background(Color.blue)
        .cornerRadius(15)
        .padding(8)
        .shadow(radius: 3,
                x: 3,
                y: 3)
        .transition(.scale)
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
    HeadersView(articles: ModelData().news.articles)
        .environmentObject(Favorites())
}
