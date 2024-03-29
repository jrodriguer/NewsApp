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
            } else {
                WrongImageView()
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(article.source.name)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(Utils.displayTitle(article.title))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    
                    Divider()
                    
                    HStack(alignment: .top) {
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
                .layoutPriority(100)
                
                Spacer()
            }
            .padding()
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
        .padding([.top, .horizontal])
    }
}

#Preview {
    ArticleCardView(article: ArticleApiObject.mockArticle)
}
