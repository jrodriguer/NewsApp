//
//  ListSectionView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 16/2/24.
//

import SwiftUI

struct ListSectionView: View {
    @StateObject var vm = ArticleViewModel()
    @State private var showFavoritesOnly = false
    private var filteredArticles: [ArticleApiObject] {
        vm.articles.filter { article in
            (!showFavoritesOnly || vm.contains(article))
        }
    }
    
    @State var showFab = true
    @State var scrollOffset: CGFloat = 0.00
        
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                if vm.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        Toggle(isOn: $showFavoritesOnly) {
                            Text("Favorites only")
                        }
                        
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
                    FloatingActionButtonView(nameIcon: "chevron.up") {
                        // TODO: Go to top.
                        
                        print("click button")
                    }
                }
            },
            alignment: Alignment.bottomTrailing
        )
    }
    
    // TODO: Infinite scroll.

}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

#Preview {
    ListSectionView()
}
