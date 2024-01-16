//
//  ArticleDetail.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleDetail: View {
    var article: Article
    
    @StateObject var favorites = Favorites()
    
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
                            WrongImage()
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
                    WrongImage()
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        
                        Text(article.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    }
                    
                    // TODO: Add grey container, similar "background" an input field when data it's nil.
                    
                    Text(article.author ?? article.source.name)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    
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
                        
                        Text(content)
                            .font(.body)
                            .foregroundColor(.primary)
                            .lineLimit(nil)
                            .padding(.bottom, 2)
                    }
                    
                    Link("Visit Newspaper", destination: article.url)
                                        
                    Spacer()
                    
                    // TODO: Check with FavoriteButton.
                    Button(favorites.contains(article) ? "Remove from Favorites" : "Add to Favorites") {
                        if favorites.contains(article) {
                            favorites.remove(article)
                        } else {
                            favorites.add(article)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
        }
        .navigationTitle("Article from \(article.source.name)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ArticleDetail(article: ModelData().news.articles[1])
        .environmentObject(Favorites())
}
