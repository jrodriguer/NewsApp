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
        NavigationView {
            VStack {
                pickerSection
                
                switch selectedViewOption {
                    case .cardView: cardSection
                    case .listView: listSection
                }
            }
            .navigationTitle("Headers")
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

/*
 #Preview {
 ArticleView()
 }
 */

extension ArticleView {
    private var pickerSection: some View {
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
    
    private var cardSection: some View {
        ScrollView {
            VStack(spacing: 0) {
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
                                ArticleDetailView(article: article)
                                    .environmentObject(vm)
                            } label: {
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
    
    private var listSection: some View {
        VStack {
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    List {
                        Toggle(isOn: $showFavoritesOnly) {
                            Text("Favorites only")
                        }
                        
                        if !filteredArticles.isEmpty {
                            ForEach(filteredArticles) { article in
                                if article.title != "[Removed]" {
                                    NavigationLink {
                                        ArticleDetailView(article: article)
                                            .environmentObject(vm)
                                    } label: {
                                        ArticleRowView(article: article)
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
                    FloatingActionButton(nameIcon: "chevron.up") {
                        print("click button")
                    }
                }
            },
            alignment: Alignment.bottomTrailing
        )
    }
}
