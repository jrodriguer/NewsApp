//
//  ArticleDetailView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleDetailView: View {
    var item: ArticleListItemViewModel
    @EnvironmentObject var favorites: FavoritesViewModel<ArticleListItemViewModel>
    
    var body: some View {
        ScrollView {
            VStack {
                ImageView(image: item.image)
                    .frame(maxHeight: 300)
                    .cornerRadius(10)
                    .padding(Spacing.medium)
                
                VStack(alignment: .leading, spacing: Spacing.medium) {
                    Text(item.displayTitle)
                        .foregroundColor(.primary)
                        .applyStyle(.h1)
                        .multilineTextAlignment(.leading)
                    
                    if !item.displayAuthor.isEmpty {
                        Text(item.displayAuthor)
                            .foregroundColor(.secondary)
                            .applyStyle(.h2)
                    }
                    
                    Text(item.description ?? "")
                        .foregroundColor(.primary)
                        .applyStyle(.body)
                        .lineLimit(nil)
                    
                    if !item.displayContent.isEmpty {
                        Text(item.displayContent)
                            .applyStyle(.body)
                            .foregroundColor(.primary)
                            .lineLimit(nil)
                    }
                    
                    HStack {
                        Link(destination: URL(string: item.link)!) {
                            Image(systemName: "link.circle.fill")
                                .font(.system(size: Spacing.large))
                        }

                        Button {
                            if favorites.contains(item) {
                                favorites.remove(item)
                            } else {
                                favorites.add(item)
                            }
                        } label: {
                            if favorites.contains(item) {
                                Label {
                                    Text("Remove from Favorites")
                                } icon: { }
                            } else {
                                Label {
                                    Text("Add to Favorites")
                                } icon: { }
                            }
                        }
                        .accessibilityIdentifier("FavoritesButton")
                        .buttonStyle(.borderedProminent)
                        .padding(.horizontal, Spacing.medium)
                    }
                    .padding(.top, Spacing.medium)
                }
                .padding(Spacing.medium)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
