//
//  ArticleCardView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleCardView: View {
    
    let article: ArticleListItemViewModel
    
    var body: some View {
        VStack {
            AsyncImage(url: article.image) { phase in
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
            HStack {
                VStack(alignment: .leading) {
                    Text(article.source)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(Utils.displayTitle(article.title))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    
                    Divider()
                    
                    HStack(alignment: .top) {
                        Text(article.publishedAt)
                        Text(article.author)
                            .lineLimit(1)
                    }
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                }
                .layoutPriority(100)
                .multilineTextAlignment(.leading)
                
                Spacer()
            }
            accessibilityIdentifier("ArticleCardView_\(article.id)")
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

//#Preview {
//    ArticleCardView(article: .previewData[0])
//}
