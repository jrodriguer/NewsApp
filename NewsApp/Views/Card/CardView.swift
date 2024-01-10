//
//  CardView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 8/1/24.
//

import SwiftUI

struct CardView: View {
    var article: Article
    
    var body: some View {
        VStack {
            if let imageURL = article.urlToImage {
                AsyncImage(url: article.urlToImage) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    @unknown default:
                        EmptyView()
                    }
                }
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 0))
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 100)
                    .padding()
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
            }
            .padding(.horizontal, 4)
        }
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(10)
    }
}

#Preview {
    CardView(article: ModelData().news.articles[1])
    
}
