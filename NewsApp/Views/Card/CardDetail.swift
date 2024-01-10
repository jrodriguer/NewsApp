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
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 0))
            } else {
                notImageView()
            }
            
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .lineLimit(3)
                    .padding([.vertical, .bottom], 14.976)
                Text(article.source.name.uppercased())
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(article.description ?? "Not description")
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundColor(.primary)
                    .padding(.bottom, 12.8)
                Text(article.content ?? "Not content")
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundColor(.primary)
                    .padding(.bottom, 12.8)
            }
            .padding(.horizontal)
        }
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
    CardDetail(article: ModelData().news.articles[2])
}
