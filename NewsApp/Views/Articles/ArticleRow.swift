//
//  ArticleRow.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleRow: View {
    var article: Article
    
    @EnvironmentObject var favorites: Favorites
    
    var body: some View {
        HStack {
            Text(Utils.displayTitle(article.title))
                .swipeActions(edge: .leading) {
                    Button {
                        if favorites.contains(article) {
                            favorites.remove(article)
                        } else {
                            favorites.add(article)
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
    ArticleRow(article: ModelData().news.articles[1])
        .environmentObject(Favorites())
}
