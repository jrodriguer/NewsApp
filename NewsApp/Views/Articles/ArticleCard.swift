//
//  ArticleCard.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleCard: View {
    var article: Article
    
    var body: some View {
        VStack {
            if let imageURL = article.urlToImage {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure(_):
                        notImageView()
                    case .empty:
                        EmptyView()
                    @unknown default:
                        ProgressView()
                    }
                }
                .cornerRadius(10)
            } else {
                notImageView()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(article.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .lineLimit(3)
                
                Text(article.author ?? article.source.name)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(article.description ?? "Not description")
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineLimit(2)
            }
        }
        .padding(12)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(10)
    }
    
    private func notImageView() -> some View {
        Image(systemName: "photo.circle.fill")
            .resizable()
            .foregroundColor(.teal)
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 100)
            .padding(.vertical, 10)
            .opacity(0.6)
    }
}

#Preview {
    ArticleCard(article: ModelData().news.articles[1])
}
