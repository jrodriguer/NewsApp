//
//  ArticleDetailView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleDetailView: View {
    var article: ArticleApiObject
    @EnvironmentObject var favorites: FavoritesViewModel<ArticleApiObject>

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                if let imageURL = article.urlToImage {
                    // MARK: For animation -> transaction: .init(animation: .bouncy(duration: 2)).
                    
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        case .failure(_):
                            WrongImageView()
                        case .empty:
                            EmptyView()
                        @unknown default:
                            ProgressView()
                        }
                    }
                    .frame(maxHeight: 300)
                    .cornerRadius(10)
                    .padding()
                } else {
                    WrongImageView()
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(Utils.displayTitle(article.title))
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                    }
                    
                    if let author = article.author {
                        Text(author)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    if let description = article.description {
                        Text(description)
                            .font(.headline)
                            .foregroundColor(.primary)
                            .lineLimit(nil)
                            .padding(.bottom, 8)
                    }
                    
                    if let content = article.content {
                        Text("Content:")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text(Utils.displayContent(content))
                            .font(.body)
                            .foregroundColor(.primary)
                            .lineLimit(nil)
                            .padding(.bottom, 2)
                    }
                    
                    HStack {
                        Link(destination: article.url) {
                            Image(systemName: "link.circle.fill")
                                .font(.largeTitle)
                        }
                        Button {
                            if favorites.contains(article) {
                                favorites.remove(FavoriteKey.articleFavorite, value: article)
                            } else {
                                favorites.add(FavoriteKey.articleFavorite, value: article)
                            }
                        } label: {
                            if favorites.contains(article) {
                                Label {
                                    Text("Remove from Favorites")
                                } icon: {
                                    //
                                }
                            } else {
                                Label {
                                    Text("Add to Favorites")
                                } icon: {
                                    //
                                }
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Article from \(article.source.name)")
        .navigationBarTitleDisplayMode(.inline)
    }
}
