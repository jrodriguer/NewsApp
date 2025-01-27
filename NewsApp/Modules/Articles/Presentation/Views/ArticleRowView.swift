//
//  ArticleRowView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleRowView: View {
    var article: ArticleListItemViewModel
    @EnvironmentObject var favorites: FavoritesViewModel<ArticleListItemViewModel>
        
    var body: some View {
        ZStack(alignment: .leading) {
            //        VStack(alignment: .leading, spacing: Spacing.small) {
            HStack {
                Text(article.displayTitle)
                    .applyStyle(.h3)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)
                    .swipeActions(edge: .leading) {
                        Button {
                            favorites.toggle(article)
                        } label: {
                            if favorites.contains(article) {
                                Label("", systemImage: "heart.slash")
                            } else {
                                Label("", systemImage: "suit.heart.fill")
                            }                            
                        }
                        .tint(.red)
                    }
                
                if favorites.contains(article) {
                    Spacer()
                    Image(systemName: "heart.fill")
                        .accessibilityLabel("This is a favorite article")
                        .foregroundStyle(.red)
                }
            }
            
//            HStack {
//                Text(article.source)
//                    .applyStyle(.footNote)
//                    .foregroundStyle(.secondary)
//            }
//            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}
