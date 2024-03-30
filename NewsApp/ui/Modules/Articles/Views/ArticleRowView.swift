//
//  ArticleRowView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleRowView: View {
    var article: ArticleApiObject
    @EnvironmentObject var vm: ArticlesViewModel
    @EnvironmentObject var favorites: FavoritesViewModel<ArticleApiObject>
        
    var body: some View {
        HStack {
            Text(Utils.displayTitle(article.title))
                .swipeActions(edge: .leading) {
                    Button {
                        if favorites.contains(article) {
                            favorites.remove(FavoriteKey.articleFavorites, value: article)
                        } else {
                            favorites.add(FavoriteKey.articleFavorites, value: article)
                        }
                    } label: {
                        if favorites.contains(article) {
                            Label("Favorite", systemImage: "heart.slash")
                        } else {
                            Label("Favorite", systemImage: "heart.fill")
                        }
                    }
                    .tint(.red)
                }
            
            if favorites.contains(article) {
                Spacer()
                Image(systemName: "heart.fill")
                    .accessibilityLabel("This is a favorite article")
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    ArticleRowView(article: ArticleApiObject.mockArticle)
        .environmentObject(ArticlesViewModel())
        .environmentObject(FavoritesViewModel<ArticleApiObject>())
}
