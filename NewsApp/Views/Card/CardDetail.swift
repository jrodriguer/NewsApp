//
//  CardDetail.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct CardDetail: View {
    var article: Article
    
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
                            notImageView()
                        case .empty:
                            EmptyView()
                        @unknown default:
                            ProgressView()
                        }
                    }
                    .frame(maxHeight: 300)
                    .cornerRadius(10)
                } else {
                        notImageView()
                    }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(article.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    
                    if let author = article.author {
                        Text("Author: \(author)")
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
                        
                        Text(content)
                            .font(.body)
                            .foregroundColor(.primary)
                            .lineLimit(nil)
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle("Article Detail")
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
    CardDetail(article: ModelData().news.articles[2])
}
