//
//  ArticleRow.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleRow: View {
    var article: Article
    
    @StateObject var favorites = Favorites()

    var body: some View {
        HStack {
            Text(article.title)
            
            // FIXME: Check article is favorite.
            
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
    let articles = ModelData().news.articles
    return ArticleRow(article: articles[1])

    .environmentObject(Favorites())
}
