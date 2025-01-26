//
//  ArticleRowView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleRowView: View {
    var item: ArticleListItemViewModel
    @EnvironmentObject var favorites: FavoritesViewModel<ArticleListItemViewModel>
        
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.small) {
            HStack {
                Text(item.displayTitle)
                    .applyStyle(.h3)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)
                    .swipeActions(edge: .leading) {
                        Button {
                            if favorites.contains(item) {
                                favorites.remove(item)
                            } else {
                                favorites.add(item)
                            }
                        } label: {
                            if favorites.contains(item) {
                                Label("Favorite", systemImage: "heart.slash")
                            } else {
                                Label("Favorite", systemImage: "suit.heart.fill")
                            }                            
                        }
                        .tint(.red)
                    }
            }
            
            if favorites.contains(item) {
                Spacer()
                Image(systemName: "heart.fill")
                    .accessibilityLabel("This is a favorite item")
                    .foregroundStyle(.red)
            }
            
            HStack {
                Text(item.source)
                    .applyStyle(.footNote)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}
