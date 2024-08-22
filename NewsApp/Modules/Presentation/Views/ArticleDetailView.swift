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
                AsyncImage(url: article.imageURL) { phase in
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
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(Utils.displayTitle(article.title))
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                    }
                    
                        Text(article.authorText)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    
                    
                        Text(article.descriptionText)
                            .font(.headline)
                            .foregroundColor(.primary)
                            .lineLimit(nil)
                            .padding(.bottom, 8)
                    
                    
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
                        Link(destination: article.link) {
                            Image(systemName: "link.circle.fill")
                                .font(.largeTitle)
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
                        .accessibilityIdentifier("FavoritesButton")
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
