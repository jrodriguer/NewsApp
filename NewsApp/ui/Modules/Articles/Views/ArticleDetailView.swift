//
//  ArticleDetailView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleDetailView: View {
    var article: ArticleApiObject
    @EnvironmentObject var vm: ArticleViewModel
    @EnvironmentObject var favorites: Favorites
    
    // TODO: Ajust to color pattern.
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                if let imageURL = article.urlToImage {
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
                    
                    // TODO: Add published data.
                    
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
                        Button(favorites.contains(article) ? "Remove from Favorites" : "Add to Favorites") {
                            if favorites.contains(article) {
                                favorites.remove(article)
                            } else {
                                favorites.add(article)
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
