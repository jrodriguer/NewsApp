//
//  ArticleCardView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleCardView: View {
    let article: ArticleApiObject
    
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
                        WrongImageView()
                    case .empty:
                        EmptyView()
                    @unknown default:
                        ProgressView()
                    }
                }
                .cornerRadius(10)
            } else {
                WrongImageView()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(article.source.name)
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text(Utils.displayTitle(article.title))
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .lineLimit(3)
                
                Divider()
                
                HStack(alignment: .top, spacing: 4) {
                    Text(Utils.timeDifference(from: article.publishedAt))
                    
                    if let author = article.author {
                        Text("•")
                        Text(Utils.displayAuthor(author))
                    }
                }
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
            }
            
        }
        .padding(12)
        .background(Color(.baseGray))
        .cornerRadius(10)
        .padding(10)
    }
}
