//
//  ArticleCard.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleCard: View {
    let article: Article
    
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
                        WrongImage()
                    case .empty:
                        EmptyView()
                    @unknown default:
                        ProgressView()
                    }
                }
                .cornerRadius(10)
            } else {
                WrongImage()
            }
                    
            VStack(alignment: .leading, spacing: 8) {
                Text(article.source.name)
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text(article.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .lineLimit(3)
                
                TimeDifference(published: ModelData().news.articles[1].publishedAt)
            }
        }
        .padding(12)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(10)
    }
}

#Preview {
    ArticleCard(article: ModelData().news.articles[1])
}
