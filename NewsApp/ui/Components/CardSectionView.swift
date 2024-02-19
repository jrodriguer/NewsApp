//
//  CardSectionView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 16/2/24.
//

import SwiftUI

struct CardSectionView: View {
    @StateObject var vm = ArticleViewModel()
    @State private var showFavoritesOnly = false
    private var filteredArticles: [ArticleApiObject] {
        vm.articles.filter { article in
            (!showFavoritesOnly || vm.contains(article))
        }
    }
        
    var body: some View {
        if vm.isLoading {
            ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
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
    
    // TODO: Infinite scroll.
    
}
