//
//  ArticleDetailView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleDetailView: View {
    var article: ArticleListItemViewModel
    @EnvironmentObject var favorites: FavoritesViewModel<ArticleListItemViewModel>
    
    var body: some View {
        ScrollView {
            VStack {
                ImageView(image: article.image)
                    .frame(maxHeight: 300)
                    .cornerRadius(10)
                    .padding(Spacing.medium)
                
                VStack(alignment: .leading, spacing: Spacing.medium) {
                    Text(article.displayTitle)
                        .foregroundColor(.primary)
                        .applyStyle(.h1)
                        .multilineTextAlignment(.leading)
                    
                    if !article.displayAuthor.isEmpty {
                        Text(article.displayAuthor)
                            .foregroundColor(.secondary)
                            .applyStyle(.h2)
                    }
                    
                    Text(article.description ?? "")
                        .foregroundColor(.primary)
                        .applyStyle(.body)
                        .lineLimit(nil)
                    
                    if !article.displayContent.isEmpty {
                        Text(article.displayContent)
                            .applyStyle(.body)
                            .foregroundColor(.primary)
                            .lineLimit(nil)
                    }
                    
                    HStack {
                        Link(destination: URL(string: article.link)!) {
                            Image(systemName: "link.circle.fill")
                                .font(.system(size: Spacing.large))
                        }

                        Button {
                            if favorites.contains(article) {
                                favorites.remove(article)
                            } else {
                                favorites.add(article)
                            }
                        } label: {
                            if favorites.contains(article) {
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
